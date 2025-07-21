-- Giao diện bác sĩ và kĩ thuật viên(Hoàng) 
-- 1) Tính số bệnh nhân mà bác sĩ cần khám trong một ngày nào đấy 
SELECT ma_bac_si, COUNT(ma_benh_nhan) as so_luot_dang_ky  
FROM  phieu_dang_ky  
WHERE thoi_gian = '2025-06-19'  
GROUP BY ma_bac_si; 
-- Index: 
CREATE INDEX idx_phieu_dang_ky_thoi_gian ON phieu_dang_ky(thoi_gian);  
CREATE INDEX idx_phieu_dang_ky_ma_bac_si ON phieu_dang_ky(ma_bac_si); 
 
  
-- 2) Liệt kê các buổi khám có nhiều chỉ định cận lâm sàng nhất 
WITH tmp AS ( 
SELECT bk.ma_buoi_kham, COUNT(kcls.ma_can_lam_sang) AS so_chi_dinh_cls  
FROM buoi_kham_chuyen_khoa bk  
JOIN kham_can_lam_sang kcls USING(ma_buoi_kham)  
GROUP BY bk.ma_buoi_kham)  
SELECT ma_buoi_kham  
FROM tmp  
WHERE so_chi_dinh_cls = (SELECT max(so_chi_dinh_cls) FROM tmp) 
-- Index: 
CREATE INDEX idx_kham_cls_ma_buoi_kham ON kham_can_lam_sang(ma_buoi_kham); 
 
-- 3) Tìm các dịch vụ cận lâm sàng ít được chỉ định 
with tmp as ( 
select ma_dich_vu, ten_dich_vu, count(ma_can_lam_sang) as so_lan_chi_dinh  
from danh_muc_can_lam_sang  
join kham_can_lam_sang using(ma_dich_vu)  
group by ma_dich_vu, ten_dich_vu )  
select ma_dich_vu, ten_dich_vu  
from tmp  
where so_lan_chi_dinh <= all(select so_lan_chi_dinh from tmp) 
-- Index: 
CREATE INDEX idx_kham_cls_ma_dich_vu ON kham_can_lam_sang(ma_dich_vu); 
 
 
-- 4) Thống kê các bệnh  với số lượng bệnh nhân nhiều nhất trong tháng  ***
with tmp as 
(SELECT ket_luan, count(distinct ma_benh_nhan) AS tong_so_benh_nhan  
FROM buoi_kham_chuyen_khoa  
JOIN phieu_dang_ky USING(ma_buoi_kham)  
WHERE extract(month from thoi_gian) = extract(month from current_date)  
GROUP BY ket_luan)  
SELECT ket_luan FROM tmp WHERE tong_so_benh_nhan >= ALL(select tong_so_benh_nhan from tmp) 
-- Index:  Neu month BETWEEN '' AND '', ben canh do su dung cac index tren pk de join cac bang nhanh hon
CREATE INDEX idx_phieu_dang_ky_thoi_gian ON phieu_dang_ky(thoi_gian); 
 
 
-- 5) Xem kết quả khám gần nhất của bệnh nhân 
select ket_luan  
from buoi_kham_chuyen_khoa  
join phieu_dang_ky using(ma_buoi_kham)  
where ma_benh_nhan = 'BN005'  
order by thoi_gian desc limit 1; 
-- Index: 
CREATE INDEX idx_phieu_dang_ky_ma_benh_nhan ON phieu_dang_ky(ma_benh_nhan);  
CREATE INDEX idx_phieu_dang_ky_thoi_gian_desc ON phieu_dang_ky(thoi_gian DESC); 
 
 
-- 6) Xem danh sách bệnh nhân đã khám với bác sĩ trong 7 ngày gần nhất 
select ma_benh_nhan, ho_ten  
from benh_nhan join phieu_dang_ky using(ma_benh_nhan)  
where ma_bac_si = 'BS001' and thoi_gian >= current_date - INTERVAL '7 days'; 
-- Index: 
CREATE INDEX idx_pdk_bac_si_thoi_gian ON phieu_dang_ky(ma_bac_si, thoi_gian); 
 
 
-- 7)  Thống kê số lần khám và số lượng bệnh nhân đã khám theo chuyên khoa của bác  sĩ 
select count(ma_dang_ky) as so_lan_kham, count(distinct ma_benh_nhan) as so_luong_benh_nhan, chuyen_khoa  
from phieu_dang_ky  
join bac_si using(ma_bac_si)  
group by chuyen_khoa; 
-- Index:
CREATE INDEX idx_bac_si_chuyen_khoa ON bac_si(chuyen_khoa); 
 
-- 8) Danh sách bệnh nhân đang nhập viện chưa xuất viện (vẫn đang điều trị nội trú) 
select ma_benh_nhan, ho_ten  
from benh_nhan  
join phieu_dang_ky using(ma_benh_nhan)  
join buoi_kham_chuyen_khoa using(ma_buoi_kham)  
join nhap_vien using(ma_nhap_vien)  
where ngay_xuat is null; 
-- Index: 
CREATE INDEX idx_nhapvien_null ON nhap_vien(ma_nhap_vien)
  WHERE ngay_xuat IS NULL; 
 
-- 9) Danh sách bệnh nhân đã từng được kê đơn với hơn 3 loại thuốc trong một buổi khám ***
with tmp as ( 
select ma_benh_nhan, ho_ten, ma_dang_ky, count(ma_chi_tiet_don_thuoc) as so_luong_loai_thuoc  
from benh_nhan bn  
join phieu_dang_ky using(ma_benh_nhan)  
join buoi_kham_chuyen_khoa using(ma_buoi_kham)  
join don_thuoc using(ma_don_thuoc) 
join chi_tiet_don_thuoc using(ma_don_thuoc) 
group by ma_benh_nhan, ho_ten, ma_dang_ky  
having count(ma_chi_tiet_don_thuoc) > 3)  
select distinct ma_benh_nhan, ho_ten from tmp; 
-- Index: 
CREATE INDEX idx_ct_don_thuoc_ma_don_thuoc ON chi_tiet_don_thuoc(ma_don_thuoc); 
 
 
-- 10) Tìm các bệnh nhân  khám nhiều hơn 2 lần trong tháng hiện tại ***
select ma_benh_nhan, ho_ten, count(ma_dang_ky) as so_lan_kham  
from benh_nhan  
join phieu_dang_ky using(ma_benh_nhan)  
where extract(month from thoi_gian) = extract(month from current_date)  
group by ma_benh_nhan, ho_ten 
having count(ma_dang_ky)>2; 


--11) Kĩ thuật viên cập nhật trạng thái đã khám ở bảng khám cận lâm sàng  ***

CREATE OR REPLACE FUNCTION trg_set_trang_thai_da_kham()
RETURNS TRIGGER AS $$
BEGIN
  NEW.trang_thai := 'đã khám';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_khamcls_set_da_kham
BEFORE INSERT OR UPDATE OF ket_qua
ON Kham_can_lam_sang
FOR EACH ROW
WHEN (NEW.ket_qua IS NOT NULL)
EXECUTE FUNCTION trg_set_trang_thai_da_kham();
