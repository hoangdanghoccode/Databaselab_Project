-- Giao diện bệnh nhân(Hưng) 
-- //1) Xem lịch sử khám ***
SELECT thoi_gian AS ngay_kham, bs.ho_ten AS bac_si, bs.chuyen_khoa, trieu_chung,
ket_luan, ke_hoach  
FROM phieu_dang_ky  
JOIN bac_si bs USING (ma_bac_si)  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham)  
WHERE ma_benh_nhan = 'BN001'  
ORDER BY thoi_gian DESC; 
-- + Index sắp xếp thời gian
CREATE INDEX idx_pd_bn_thoi_gian ON phieu_dang_ky (thoi_gian DESC); 
-- + Index cho JOIN với bảng bac_si  
CREATE INDEX idx_pd_ma_bac_si ON phieu_dang_ky (ma_bac_si); 
-- + Index cho JOIN với bảng buoi_kham_chuyen_khoa  
CREATE INDEX idx_pd_ma_buoi_kham ON phieu_dang_ky (ma_buoi_kham); 

-- 2) Xem thông tin bác sĩ khám 
SELECT DISTINCT bs.ho_ten, bs.sdt, bs.nam_sinh, chuyen_khoa, thoi_gian AS ngay_kham  
FROM phieu_dang_ky  
JOIN bac_si bs USING (ma_bac_si)  
WHERE ma_benh_nhan = 'BN001'  
ORDER BY thoi_gian DESC; 
-- + Index sắp xếp thời gian  
CREATE INDEX idx_pd_bn_thoi_gian ON phieu_dang_ky (thoi_gian DESC); 
-- + Index cho JOIN với bảng bac_si  
CREATE INDEX idx_pd_ma_bac_si ON phieu_dang_ky (ma_bac_si); 

-- 3) Xem các chỉ định khám cận lâm sàng nào chưa thực hiện ***
SELECT ten_dich_vu, k.dia_diem, trang_thai  
FROM phieu_dang_ky  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham)  
JOIN kham_can_lam_sang k USING (ma_buoi_kham)  
JOIN danh_muc_can_lam_sang USING (ma_dich_vu)  
WHERE ma_benh_nhan = 'BN001' AND k.trang_thai = 'Chưa khám'  
-- + Index JOIN sang buoi_kham_chuyen_khoa  
CREATE INDEX idx_pd_bn_and_mb ON phieu_dang_ky (ma_buoi_kham); 

-- 4) Xem thông tin xét nghiệm và kết quả 
SELECT ten_dich_vu, k.dia_diem, k.thoi_gian_ket_qua, k.ket_qua, ktv.ho_ten AS ky_thuat_vien  
FROM phieu_dang_ky  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham)  
JOIN kham_can_lam_sang k USING (ma_buoi_kham)  
JOIN danh_muc_can_lam_sang USING (ma_dich_vu)  
JOIN ky_thuat_vien ktv USING (ma_ky_thuat_vien)  
WHERE ma_benh_nhan = 'BN001'  
ORDER BY thoi_gian_ket_qua DESC; 
-- + Index join buoi_kham  
CREATE INDEX idx_pd_bn_bk ON phieu_dang_ky (ma_buoi_kham); 
-- + Index tìm nhanh thoi_gian_ket_qua kết quả  
CREATE INDEX idx_kcls_bk_tkkq ON kham_can_lam_sang (thoi_gian_ket_qua DESC); 

-- 5) Xem toàn bộ đơn thuốc đã cấp ***
SELECT ma_don_thuoc, ngay_ke, cong_dung,  
ARRAY_AGG(ten_thuoc||'x'||so_luong) AS danh_sach_thuoc  
FROM don_thuoc JOIN chi_tiet_don_thuoc USING (ma_don_thuoc)  
JOIN buoi_kham_chuyen_khoa USING (ma_don_thuoc)  
JOIN phieu_dang_ky USING (ma_buoi_kham)  
WHERE ma_benh_nhan = 'BN001'  
GROUP BY ma_don_thuoc  
ORDER BY ngay_ke DESC; 
-- + Index giúp join nhanh buổi khám đến đơn thuốc 
CREATE INDEX idx_bk_dn ON buoi_kham_chuyen_khoa (ma_don_thuoc); 
-- + Index giúp join nhanh từ đơn thuốc lên chi tiết đơn thuốc 
CREATE INDEX idx_ctdt_dn ON chi_tiet_don_thuoc (ma_don_thuoc); 
-- + Index sắp xếp kết quả theo ngày đơn 
CREATE INDEX idx_dt_ngay_ke ON don_thuoc (ngay_ke DESC); 
 
-- 6) Xem thông tin nhập viện 
SELECT ma_nhap_vien, phong, ngay_nhap, ngay_xuat, gia_ngay, ktv.ho_ten AS ky_thuat_vien  
FROM phieu_dang_ky  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham)  
JOIN nhap_vien USING (ma_nhap_vien)  
JOIN benh_nhan USING (ma_benh_nhan)  
JOIN ky_thuat_vien ktv USING (ma_ky_thuat_vien)  
WHERE ma_benh_nhan = 'BN001' 
ORDER BY ngay_nhap DESC; 
-- + Index join buổi khám  
CREATE INDEX idx_pd_bn_buoi ON phieu_dang_ky (ma_buoi_kham); 
-- + Index join ngay buoi_kham_chuyen_khoa đến nhập viện 
CREATE INDEX idx_bk_nv ON buoi_kham_chuyen_khoa (ma_nhap_vien); 
-- + Index sắp xếp ngày nhập  
CREATE INDEX idx_nv_nv_ngay ON nhap_vien (ngay_nhap DESC); 
 
-- 7) Xem thông tin các điều trị 
SELECT ma_dieu_tri, loai_dieu_tri, trang_thai  
FROM chi_tiet_dieu_tri  
JOIN nhap_vien USING (ma_nhap_vien)  
JOIN buoi_kham_chuyen_khoa USING (ma_nhap_vien)  
JOIN phieu_dang_ky USING (ma_buoi_kham)  
WHERE ma_benh_nhan = 'BN001'; 
-- + Index join buoi_kham  
CREATE INDEX idx_pd_bn_buoi ON phieu_dang_ky (ma_buoi_kham); 
-- + Index giúp join buoi_kham_chuyen_khoa tiếp nhập việnviện 
CREATE INDEX idx_bk_nv ON buoi_kham_chuyen_khoa (ma_nhap_vien); 

-- 8) Xem hóa đơn (tổng tiền khám chữa bệnh) 
SELECT ma_hoa_don, ngay_tao, tong_tien  
FROM phieu_dang_ky  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham) 
JOIN hoa_don USING (ma_hoa_don)  
WHERE ma_benh_nhan = 'BN001' 
ORDER BY ngay_tao DESC;
-- + Index join buổi khám
CREATE INDEX idx_pd_bn_buoi ON phieu_dang_ky (ma_buoi_kham);
-- + Index join nhanh sang hóa đơn
CREATE INDEX idx_bk_hoa_don ON buoi_kham_chuyen_khoa (ma_hoa_don);
-- + Index sắp xếp theo ngày tạo giảm dần
CREATE INDEX idx_hd_ngay_tao ON hoa_don (ngay_tao DESC);

-- 9) Xem chi tiết giá từng loại điều trị 
SELECT ma_dieu_tri, loai_dieu_tri, gia 
FROM chi_tiet_dieu_tri  
JOIN nhap_vien USING (ma_nhap_vien)  
JOIN buoi_kham_chuyen_khoa USING (ma_nhap_vien)  
JOIN phieu_dang_ky USING (ma_buoi_kham)  
WHERE ma_benh_nhan = 'BN001' AND ngay_nhap = '2025-04-01'; 
-- + Index JOIN chi_tiet_dieu_tri đếnđến nhap_vien
CREATE INDEX idx_ctdt_ma_nhap_vien ON chi_tiet_dieu_tri (ma_nhap_vien);
-- + Index JOIN nhap_vien đếnđến buoi_kham_chuyen_khoa
CREATE INDEX idx_bk_ma_nhap_vien ON buoi_kham_chuyen_khoa (ma_nhap_vien);
-- + Index JOIN buoi_kham_chuyen_khoa đếnđến phieu_dang_ky
CREATE INDEX idx_pd_ma_buoi_kham ON phieu_dang_ky (ma_buoi_kham);

-- 10) Xem chi tiết tiền từng dịch vụ khám cận lâm sàng 
SELECT ma_dich_vu, ten_dich_vu, gia 
FROM phieu_dang_ky  
JOIN buoi_kham_chuyen_khoa USING (ma_buoi_kham)  
JOIN kham_can_lam_sang USING (ma_buoi_kham)  
JOIN danh_muc_can_lam_sang USING (ma_dich_vu)  
WHERE ma_benh_nhan = 'BN001' AND thoi_gian = '2025-04-01'; 
-- + Index trên phieu_dang_ky để JOIN nhanh sang buoi_kham_chuyen_khoa
CREATE INDEX idx_pd_ma_buoi_kham
  ON phieu_dang_ky (ma_buoi_kham);
-- + Index trên kham_can_lam_sang để JOIN nhanh từ buoi_kham_chuyen_khoa
CREATE INDEX idx_kcls_ma_buoi_kham
  ON kham_can_lam_sang (ma_buoi_kham);


