-- Giao diện quản lý(Khôi) 
-- 1) Quản lý đếm số bệnh nhân nội trú trong khoảng thời gian nhất định 
SELECT COUNT(*) AS so_benh_nhan_noi_tru  
FROM nhap_vien  
WHERE  
ngay_nhap <= DATE '2025-04-30'  
AND (ngay_xuat >= DATE '2025-04-01' OR ngay_xuat IS NULL); 
 
CREATE INDEX idx_nhap_vien_ngay ON nhap_vien(ngay_nhap, ngay_xuat); 
-- Index này sẽ giúp tối ưu hóa điều kiện lọc theo ngày nhập và ngày xuất viện. 
 
-- 2) Quản lý đếm số ca cận lâm sàng mà 1 nhân viên phải làm trong ngày 
SELECT  
ktv.ho_ten,  
kcls.thoi_gian_ket_qua::date AS ngay,  
COUNT(*) AS so_ca  
FROM kham_can_lam_sang kcls  
JOIN ky_thuat_vien ktv ON kcls.ma_ky_thuat_vien = ktv.ma_ky_thuat_vien  
WHERE ktv.ho_ten = 'KTV. Vũ Bình'  
AND kcls.thoi_gian_ket_qua::date = DATE '2025-04-02'  
GROUP BY ktv.ho_ten, kcls.thoi_gian_ket_qua::date; 
 
CREATE INDEX idx_kcls_kythuat_ngay ON kham_can_lam_sang(ma_ky_thuat_vien, thoi_gian_ket_qua); 
 
-- 3) Gán mặc định trang_thái = 'Chưa thanh toán' cho hóa đơn  
CREATE OR REPLACE FUNCTION fn_default_trang_thai_hd()  
RETURNS TRIGGER AS $$  
BEGIN  
IF NEW.trang_thai IS NULL THEN  
NEW.trang_thai := 'Chưa thanh toán';  
END IF;  
RETURN NEW;  
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_default_trang_thai_hd  
BEFORE INSERT ON hoa_don  
FOR EACH ROW EXECUTE FUNCTION fn_default_trang_thai_hd(); 
 
-- 4) Tự động kiểm tra số ca cận lâm sàng của kỹ thuật viên trong ngày không vượt quá giới hạn (cảnh báo nhưng vẫn cho chèn) 
--***
CREATE OR REPLACE FUNCTION fn_canh_bao_gioi_han_ktv() 
RETURNS TRIGGER AS $$  
DECLARE  
ca_trong_ngay INT;  
BEGIN  
SELECT COUNT(*) INTO ca_trong_ngay  
FROM kham_can_lam_sang  
WHERE  
ma_ky_thuat_vien = NEW.ma_ky_thuat_vien  
AND thoi_gian_ket_qua::date = NEW.thoi_gian_ket_qua::date; 
IF ca_trong_ngay >= 10 THEN 
   RAISE WARNING ' Kỹ thuật viên % đã thực hiện % ca trong ngày % – vượt quá giới hạn khuyến nghị!', 
       NEW.ma_ky_thuat_vien, ca_trong_ngay, NEW.thoi_gian_ket_qua::date; 
       return NULL;
END IF; 
 
RETURN NEW; 
 
END; $$ LANGUAGE plpgsql; CREATE TRIGGER trg_canh_bao_ktv BEFORE INSERT ON kham_can_lam_sang FOR EACH ROW EXECUTE FUNCTION fn_canh_bao_gioi_han_ktv(); 
 
-- 5) Kiểm tra ngày nhập sớm hơn ngày xuất 
CREATE OR REPLACE FUNCTION fn_chk_ngay_xuat()  
RETURNS TRIGGER AS $$  
BEGIN  
IF NEW.ngay_xuat IS NOT NULL  
AND NEW.ngay_xuat < NEW.ngay_nhap THEN  
RAISE EXCEPTION 'ngay_xuat (%) không được trước ngay_nhap (%)', NEW.ngay_xuat, NEW.ngay_nhap;  
END IF;  
RETURN NEW;  
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_chk_ngay_xuat BEFORE INSERT OR UPDATE ON nhap_vien FOR EACH ROW EXECUTE FUNCTION fn_chk_ngay_xuat(); 
 
-- 6) Gán mặc định trang_thai = 'Chưa khám' cho KCLS 
CREATE OR REPLACE FUNCTION fn_default_kcls_status()  
RETURNS TRIGGER AS $$  
BEGIN  
IF NEW.trang_thai IS NULL THEN  
NEW.trang_thai := 'Chưa khám';  
END IF;  
RETURN NEW; 
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_default_kcls_status  
BEFORE INSERT ON kham_can_lam_sang  
FOR EACH ROW EXECUTE FUNCTION fn_default_kcls_status(); 
 
-- 7) Ghi lại mã và họ tên bệnh nhân sau khi xóa 
--*** 
CREATE TABLE IF NOT EXISTS benh_nhan_log (  
ma_benh_nhan VARCHAR(20), 
ho_ten VARCHAR(100),  
xoa_luc TIMESTAMP DEFAULT NOW() ); 
CREATE OR REPLACE FUNCTION fn_log_delete_bn() 
 RETURNS TRIGGER AS $$  
BEGIN  
INSERT INTO benh_nhan_log (ma_benh_nhan, ho_ten)  
VALUES (OLD.ma_benh_nhan, OLD.ho_ten);  
RETURN OLD; END; $$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_log_delete_bn  
AFTER DELETE ON benh_nhan  
FOR EACH ROW EXECUTE FUNCTION fn_log_delete_bn(); 
 
-- 8) Cập nhật tổng tiền hóa đơn khi xuất viện 
CREATE OR REPLACE FUNCTION fn_update_hd_after_discharge()  
RETURNS TRIGGER AS $$  
DECLARE  
v_days INT;  
v_ma_hd VARCHAR(20);  
BEGIN  
IF NEW.ngay_xuat IS NULL THEN 
RETURN NEW;  
END IF; 
v_days := GREATEST( (NEW.ngay_xuat - NEW.ngay_nhap) + 1 , 1 ); 
SELECT ma_hoa_don  
INTO v_ma_hd  
FROM buoi_kham_chuyen_khoa  
WHERE ma_nhap_vien = NEW.ma_nhap_vien LIMIT 1; 
IF v_ma_hd IS NOT NULL THEN  
UPDATE hoa_don  
SET tong_tien = COALESCE(tong_tien, '0')::NUMERIC + (v_days * NEW.gia_ngay)::NUMERIC  
WHERE ma_hoa_don = v_ma_hd;  
END IF; 
RETURN NEW;  
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_update_hd_after_discharge  
AFTER UPDATE OF ngay_xuat, gia_ngay ON nhap_vien  
FOR EACH ROW EXECUTE FUNCTION fn_update_hd_after_discharge(); 
 
-- 9) Tự động kiểm tra nếu tổng tiền hóa đơn vượt 10 triệu thì gán trạng thái “Chờ duyệt” 
--***
CREATE OR REPLACE FUNCTION fn_check_tong_tien_hd()  
RETURNS TRIGGER AS $$  
BEGIN  
IF NEW.tong_tien::NUMERIC > 10000000 THEN  
NEW.trang_thai := 'Chờ duyệt';  
END IF;  
RETURN NEW; 
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_check_tong_tien_hd  
BEFORE INSERT OR UPDATE ON hoa_don  
FOR EACH ROW EXECUTE FUNCTION fn_check_tong_tien_hd(); 
 
-- 10) Giới hạn đăng ký trong giờ hành chính 
CREATE OR REPLACE FUNCTION fn_gio_hanh_chinh_only()  
RETURNS TRIGGER AS $$  
DECLARE  
v_gio INTEGER;  
BEGIN 
v_gio := EXTRACT(HOUR FROM NEW.thoi_gian); 
IF v_gio < 8 OR v_gio >= 17 THEN  
RAISE EXCEPTION ' Chỉ cho phép đăng ký trong giờ hành chính (08:00 - 17:00). Thời 	gian bạn chọn: %', NEW.thoi_gian;  
END IF; 
RETURN NEW;  
END;  
$$ LANGUAGE plpgsql; 
CREATE TRIGGER trg_gio_hanh_chinh_only  
BEFORE INSERT ON phieu_dang_ky FOR EACH ROW  
EXECUTE FUNCTION fn_gio_hanh_chinh_only(); 

