--
-- PostgreSQL database dump
--

-- Dumped from database version 17.3
-- Dumped by pg_dump version 17.3

-- Started on 2025-06-18 23:36:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 25090)
-- Name: bac_si; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bac_si (
    ma_bac_si character varying(20) NOT NULL,
    ho_ten character varying(100) NOT NULL,
    sdt character varying(20),
    nam_sinh character varying(4),
    chuyen_khoa character varying(100) NOT NULL
);


ALTER TABLE public.bac_si OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25083)
-- Name: benh_nhan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.benh_nhan (
    ma_benh_nhan character varying(20) NOT NULL,
    ho_ten character varying(100) NOT NULL,
    sdt character varying(20),
    nam_sinh character varying(4),
    so_bhyt character varying(30)
);


ALTER TABLE public.benh_nhan OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25147)
-- Name: buoi_kham_chuyen_khoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buoi_kham_chuyen_khoa (
    ma_buoi_kham character varying(20) NOT NULL,
    dia_diem character varying(100),
    trieu_chung character varying(1000),
    ket_luan character varying(1000),
    ke_hoach character varying(1000),
    ma_nhap_vien character varying(20),
    ma_don_thuoc character varying(20),
    ma_hoa_don character varying(20)
);


ALTER TABLE public.buoi_kham_chuyen_khoa OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25115)
-- Name: chi_tiet_dieu_tri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chi_tiet_dieu_tri (
    ma_dieu_tri character varying(20) NOT NULL,
    loai_dieu_tri character varying(100),
    gia character varying(15),
    trang_thai character varying(30),
    ma_nhap_vien character varying(20) NOT NULL
);


ALTER TABLE public.chi_tiet_dieu_tri OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25132)
-- Name: chi_tiet_don_thuoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chi_tiet_don_thuoc (
    ma_chi_tiet_don_thuoc character varying(20) NOT NULL,
    ten_thuoc character varying(100) NOT NULL,
    cach_dung character varying(100),
    so_luong integer,
    ma_don_thuoc character varying(20) NOT NULL
);


ALTER TABLE public.chi_tiet_don_thuoc OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25100)
-- Name: danh_muc_can_lam_sang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.danh_muc_can_lam_sang (
    ma_dich_vu character varying(20) NOT NULL,
    ten_dich_vu character varying(100) NOT NULL,
    gia character varying(15) NOT NULL
);


ALTER TABLE public.danh_muc_can_lam_sang OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25125)
-- Name: don_thuoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don_thuoc (
    ma_don_thuoc character varying(20) NOT NULL,
    cong_dung character varying(1000),
    ngay_ke date NOT NULL
);


ALTER TABLE public.don_thuoc OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25142)
-- Name: hoa_don; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hoa_don (
    ma_hoa_don character varying(20) NOT NULL,
    ngay_tao date NOT NULL,
    tong_tien character varying(15) NOT NULL,
    trang_thai character varying(30)
);


ALTER TABLE public.hoa_don OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25189)
-- Name: kham_can_lam_sang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kham_can_lam_sang (
    ma_can_lam_sang character varying(20) NOT NULL,
    dia_diem character varying(100),
    ket_qua character varying(1000),
    thoi_gian_ket_qua date,
    trang_thai character varying(30),
    ma_dich_vu character varying(20) NOT NULL,
    ma_ky_thuat_vien character varying(20) NOT NULL,
    ma_buoi_kham character varying(20)
);


ALTER TABLE public.kham_can_lam_sang OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25095)
-- Name: ky_thuat_vien; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ky_thuat_vien (
    ma_ky_thuat_vien character varying(20) NOT NULL,
    ho_ten character varying(100) NOT NULL,
    sdt character varying(20),
    chuc_vu character varying(50),
    nam_sinh character varying(4)
);


ALTER TABLE public.ky_thuat_vien OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25105)
-- Name: nhap_vien; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nhap_vien (
    ma_nhap_vien character varying(20) NOT NULL,
    phong character varying(30),
    ngay_nhap date NOT NULL,
    ngay_xuat date,
    gia_ngay character varying(15),
    ma_ky_thuat_vien character varying(20)
);


ALTER TABLE public.nhap_vien OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25169)
-- Name: phieu_dang_ky; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phieu_dang_ky (
    ma_dang_ky character varying(20) NOT NULL,
    thoi_gian date NOT NULL,
    ma_benh_nhan character varying(20) NOT NULL,
    ma_bac_si character varying(20) NOT NULL,
    ma_buoi_kham character varying(20) NOT NULL
);


ALTER TABLE public.phieu_dang_ky OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 25090)
-- Dependencies: 218
-- Data for Name: bac_si; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bac_si (ma_bac_si, ho_ten, sdt, nam_sinh, chuyen_khoa) FROM stdin;
BS001	BS. Lâm Hoàng	0912000001	1978	Nội tổng quát
BS002	BS. Hà Mỹ	0912000002	1980	Ngoại tiêu hoá
BS003	BS. Phương Ôn	0912000003	1975	Tim mạch
BS004	BS. Trí	0912000004	1983	Thần kinh
BS005	BS. Giang Thu	0912000005	1987	Da liễu
BS006	BS. Khang	0912000006	1979	Sản
BS007	BS. Như Ý	0912000007	1982	Nhi
BS008	BS. Bảo Châu	0912000008	1988	Hô hấp
BS009	BS. Quốc Anh	0912000009	1981	Mắt
BS010	BS. Diệu Mai	0912000010	1990	Tai-mũi-họng
\.


--
-- TOC entry 4921 (class 0 OID 25083)
-- Dependencies: 217
-- Data for Name: benh_nhan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.benh_nhan (ma_benh_nhan, ho_ten, sdt, nam_sinh, so_bhyt) FROM stdin;
BN001	Nguyễn Ánh	0901000001	2000	BHYT0001
BN002	Trần Lệ Oanh	0901000002	1999	BHYT0002
BN003	Phạm Đức Hùng	0901000003	1985	BHYT0003
BN004	Lê Thị Ý Nhi	0901000004	1995	BHYT0004
BN005	Đỗ Khải Minh	0901000005	2003	BHYT0005
BN006	Hoàng Thảo My	0901000006	2001	BHYT0006
BN007	Bùi Gia Hân	0901000007	1998	BHYT0007
BN008	Đặng Nhật	0901000008	1975	BHYT0008
BN009	Ngô Hữu Phúc	0901000009	1992	BHYT0009
BN010	Võ Cẩm Tú	0901000010	2004	BHYT0010
\.


--
-- TOC entry 4930 (class 0 OID 25147)
-- Dependencies: 226
-- Data for Name: buoi_kham_chuyen_khoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buoi_kham_chuyen_khoa (ma_buoi_kham, dia_diem, trieu_chung, ket_luan, ke_hoach, ma_nhap_vien, ma_don_thuoc, ma_hoa_don) FROM stdin;
BK001	PK Nội 1	Ho, khó thở	Viêm phổi	Theo dõi 48h	NV001	DON001	HD001
BK002	PK Ngoại 3	Đau bụng dữ dội	Viêm ruột thừa	Phẫu thuật	NV002	DON002	HD002
BK003	PK Thần kinh	Đau đầu	Migraine mạn	Điều trị ngoại trú	\N	DON003	HD003
BK004	PK Tiêu hoá	Ợ chua, tức bụng	Viêm dạ dày	Nội soi kiểm tra	NV004	DON004	HD004
BK005	PK Tai mũi họng	Ho kéo dài	Viêm họng	Thuốc uống	\N	DON005	HD005
BK006	PK Nhi	Biếng ăn	Thiếu vi chất	Bổ sung C	\N	DON006	HD006
BK007	PK Da liễu	Mẩn đỏ ngứa	Dị ứng da	Tránh dị nguyên	\N	DON010	HD010
BK008	PK Hô hấp	Sốt cao	Cúm A	Xét nghiệm thêm	NV008	DON008	HD008
BK009	PK Cấp cứu	Choáng	Sốc nhiệt	Chăm sóc tích cực	NV009	\N	HD009
BK010	PK Nội 2	Đau khớp	Thoái hoá nhẹ	Vật lý trị liệu	NV010	DON007	HD007
\.


--
-- TOC entry 4926 (class 0 OID 25115)
-- Dependencies: 222
-- Data for Name: chi_tiet_dieu_tri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chi_tiet_dieu_tri (ma_dieu_tri, loai_dieu_tri, gia, trang_thai, ma_nhap_vien) FROM stdin;
DT001	Kháng sinh	120000	Đang điều trị	NV001
DT002	Phẫu thuật	7500000	Hoàn tất	NV002
DT003	Xạ trị	15000000	Đang điều trị	NV003
DT004	Hoá trị	20000000	Đang điều trị	NV004
DT005	Phục hồi chức năng	300000	Hoàn tất	NV005
DT006	Chăm sóc hô hấp	200000	Đang điều trị	NV006
DT007	Thay băng	50000	Hoàn tất	NV007
DT008	Truyền máu	800000	Hoàn tất	NV008
DT009	Tiêm vaccine	450000	Hoàn tất	NV009
DT010	Chăm sóc đặc biệt	950000	Đang điều trị	NV010
\.


--
-- TOC entry 4928 (class 0 OID 25132)
-- Dependencies: 224
-- Data for Name: chi_tiet_don_thuoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chi_tiet_don_thuoc (ma_chi_tiet_don_thuoc, ten_thuoc, cach_dung, so_luong, ma_don_thuoc) FROM stdin;
CTDT001	Augmentin 625mg	2 viên/ngày	10	DON001
CTDT002	Azithromycin	1 viên/ngày	5	DON002
CTDT003	Paracetamol 500	3 viên/ngày	12	DON003
CTDT004	Omeprazol	1 viên sáng	7	DON004
CTDT006	Vitamin C 1000	1 viên/ngày	15	DON006
CTDT007	Immuno Booster	1 viên/ngày	30	DON007
CTDT008	Oseltamivir	1 viên/12h	10	DON008
CTDT009	Ibuprofen 400	3 viên/ngày	15	DON009
CTDT010	Loratadin	1 viên/ngày	10	DON010
CTDT005	Dextromethorphan	10ml mỗi 8h	4	DON005
\.


--
-- TOC entry 4924 (class 0 OID 25100)
-- Dependencies: 220
-- Data for Name: danh_muc_can_lam_sang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.danh_muc_can_lam_sang (ma_dich_vu, ten_dich_vu, gia) FROM stdin;
DV001	Công thức máu	150000
DV002	Sinh hoá máu	250000
DV003	X-quang ngực	200000
DV004	Siêu âm bụng	300000
DV005	MRI não	1800000
DV006	PCR COVID-19	450000
DV007	Điện tim	120000
DV008	Xét nghiệm đường huyết	80000
DV009	Nội soi dạ dày	700000
DV010	Đo chức năng hô hấp	160000
\.


--
-- TOC entry 4927 (class 0 OID 25125)
-- Dependencies: 223
-- Data for Name: don_thuoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don_thuoc (ma_don_thuoc, cong_dung, ngay_ke) FROM stdin;
DON001	Điều trị viêm phổi	2025-04-02
DON002	Kháng sinh sau phẫu thuật	2025-03-16
DON003	Giảm đau thần kinh	2025-05-05
DON004	Điều trị dạ dày	2025-03-11
DON005	Thuốc ho	2025-03-01
DON006	Bổ sung vitamin	2025-01-12
DON007	Tăng miễn dịch	2025-04-23
DON008	Kháng virus	2025-05-02
DON009	Hạ sốt	2025-02-06
DON010	Điều trị dị ứng	2025-04-18
\.


--
-- TOC entry 4929 (class 0 OID 25142)
-- Dependencies: 225
-- Data for Name: hoa_don; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hoa_don (ma_hoa_don, ngay_tao, tong_tien, trang_thai) FROM stdin;
HD001	2025-04-03	350000	Đã thanh toán
HD002	2025-03-20	7800000	Chưa thanh toán
HD003	2025-05-06	15500000	Chưa thanh toán
HD004	2025-03-25	20200000	Đã thanh toán
HD005	2025-03-02	550000	Chưa thanh toán
HD006	2025-01-18	670000	Đã thanh toán
HD007	2025-04-30	700000	Đã thanh toán
HD008	2025-05-04	820000	Chưa thanh toán
HD009	2025-02-10	610000	Đã thanh toán
HD010	2025-04-19	1200000	Chưa thanh toán
\.


--
-- TOC entry 4932 (class 0 OID 25189)
-- Dependencies: 228
-- Data for Name: kham_can_lam_sang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kham_can_lam_sang (ma_can_lam_sang, dia_diem, ket_qua, thoi_gian_ket_qua, trang_thai, ma_dich_vu, ma_ky_thuat_vien, ma_buoi_kham) FROM stdin;
KCLS001	P. Xét nghiệm 1	BC tăng	2025-04-02	Đã có	DV001	KTV001	BK001
KCLS002	P. X-quang	Tổn thương nhẹ	2025-03-16	Đã có	DV003	KTV002	BK002
KCLS003	P. Siêu âm	Gan nhiễm mỡ độ 1	2025-05-06	Đã có	DV004	KTV003	BK003
KCLS004	P. MRI	Bình thường	2025-03-12	Đã có	DV005	KTV004	BK004
KCLS005	P. PCR	Âm tính	2025-03-02	Đã có	DV006	KTV008	BK005
KCLS006	P. Điện tim	Nhịp xoang	2025-01-13	Đã có	DV007	KTV007	BK006
KCLS007	P. Đường huyết	10 mmol/L	2025-04-24	Đã có	DV008	KTV009	BK007
KCLS008	P. Nội soi	Viêm dạ dày nhẹ	2025-05-03	Đã có	DV009	KTV006	BK008
KCLS009	P. Hô hấp	Chuẩn	2025-02-06	Đã có	DV010	KTV010	BK009
KCLS010	P. Sinh hóa	ALT cao gấp 2	2025-04-19	Đã có	DV002	KTV005	BK010
\.


--
-- TOC entry 4923 (class 0 OID 25095)
-- Dependencies: 219
-- Data for Name: ky_thuat_vien; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ky_thuat_vien (ma_ky_thuat_vien, ho_ten, sdt, chuc_vu, nam_sinh) FROM stdin;
KTV001	KTV. Vũ Bình	0923000001	Xét nghiệm	1992
KTV002	KTV. Hạnh	0923000002	X-quang	1990
KTV003	KTV. Long	0923000003	Siêu âm	1989
KTV004	KTV. Tiến	0923000004	MRI	1991
KTV005	KTV. Mỹ Duyên	0923000005	Xét nghiệm	1993
KTV006	KTV. Văn	0923000006	X-quang	1994
KTV007	KTV. Hải	0923000007	Máu	1988
KTV008	KTV. Thư	0923000008	PCR	1995
KTV009	KTV. Phú	0923000009	Sinh hoá	1990
KTV010	KTV. Hường	0923000010	Hô hấp	1996
\.


--
-- TOC entry 4925 (class 0 OID 25105)
-- Dependencies: 221
-- Data for Name: nhap_vien; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nhap_vien (ma_nhap_vien, phong, ngay_nhap, ngay_xuat, gia_ngay, ma_ky_thuat_vien) FROM stdin;
NV001	201A	2025-04-01	\N	500000	KTV001
NV002	202B	2025-03-15	2025-03-20	450000	KTV002
NV003	303C	2025-05-05	\N	600000	KTV003
NV004	404D	2025-03-10	2025-03-25	550000	KTV004
NV005	505E	2025-02-28	\N	500000	KTV005
NV006	606F	2025-01-12	2025-01-18	450000	KTV006
NV007	707G	2025-04-22	2025-04-30	650000	KTV007
NV008	808H	2025-05-02	\N	700000	KTV008
NV009	909I	2025-02-05	2025-02-10	480000	KTV009
NV010	101J	2025-04-18	\N	520000	KTV010
\.


--
-- TOC entry 4931 (class 0 OID 25169)
-- Dependencies: 227
-- Data for Name: phieu_dang_ky; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phieu_dang_ky (ma_dang_ky, thoi_gian, ma_benh_nhan, ma_bac_si, ma_buoi_kham) FROM stdin;
DK001	2025-04-01	BN001	BS001	BK001
DK002	2025-03-15	BN002	BS002	BK002
DK003	2025-05-05	BN003	BS004	BK003
DK004	2025-03-10	BN004	BS005	BK004
DK005	2025-03-01	BN005	BS010	BK005
DK006	2025-01-12	BN006	BS007	BK006
DK007	2025-04-23	BN007	BS005	BK007
DK008	2025-05-02	BN008	BS008	BK008
DK009	2025-02-05	BN009	BS003	BK009
DK010	2025-04-18	BN010	BS001	BK010
\.


--
-- TOC entry 4743 (class 2606 OID 25094)
-- Name: bac_si bac_si_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bac_si
    ADD CONSTRAINT bac_si_pkey PRIMARY KEY (ma_bac_si);


--
-- TOC entry 4739 (class 2606 OID 25087)
-- Name: benh_nhan benh_nhan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benh_nhan
    ADD CONSTRAINT benh_nhan_pkey PRIMARY KEY (ma_benh_nhan);


--
-- TOC entry 4741 (class 2606 OID 25089)
-- Name: benh_nhan benh_nhan_so_bhyt_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benh_nhan
    ADD CONSTRAINT benh_nhan_so_bhyt_key UNIQUE (so_bhyt);


--
-- TOC entry 4759 (class 2606 OID 25153)
-- Name: buoi_kham_chuyen_khoa buoi_kham_chuyen_khoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buoi_kham_chuyen_khoa
    ADD CONSTRAINT buoi_kham_chuyen_khoa_pkey PRIMARY KEY (ma_buoi_kham);


--
-- TOC entry 4751 (class 2606 OID 25119)
-- Name: chi_tiet_dieu_tri chi_tiet_dieu_tri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chi_tiet_dieu_tri
    ADD CONSTRAINT chi_tiet_dieu_tri_pkey PRIMARY KEY (ma_dieu_tri);


--
-- TOC entry 4755 (class 2606 OID 25136)
-- Name: chi_tiet_don_thuoc chi_tiet_don_thuoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chi_tiet_don_thuoc
    ADD CONSTRAINT chi_tiet_don_thuoc_pkey PRIMARY KEY (ma_chi_tiet_don_thuoc);


--
-- TOC entry 4747 (class 2606 OID 25104)
-- Name: danh_muc_can_lam_sang danh_muc_can_lam_sang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.danh_muc_can_lam_sang
    ADD CONSTRAINT danh_muc_can_lam_sang_pkey PRIMARY KEY (ma_dich_vu);


--
-- TOC entry 4753 (class 2606 OID 25131)
-- Name: don_thuoc don_thuoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_thuoc
    ADD CONSTRAINT don_thuoc_pkey PRIMARY KEY (ma_don_thuoc);


--
-- TOC entry 4757 (class 2606 OID 25146)
-- Name: hoa_don hoa_don_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hoa_don
    ADD CONSTRAINT hoa_don_pkey PRIMARY KEY (ma_hoa_don);


--
-- TOC entry 4763 (class 2606 OID 25195)
-- Name: kham_can_lam_sang kham_can_lam_sang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kham_can_lam_sang
    ADD CONSTRAINT kham_can_lam_sang_pkey PRIMARY KEY (ma_can_lam_sang);


--
-- TOC entry 4745 (class 2606 OID 25099)
-- Name: ky_thuat_vien ky_thuat_vien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ky_thuat_vien
    ADD CONSTRAINT ky_thuat_vien_pkey PRIMARY KEY (ma_ky_thuat_vien);


--
-- TOC entry 4749 (class 2606 OID 25109)
-- Name: nhap_vien nhap_vien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhap_vien
    ADD CONSTRAINT nhap_vien_pkey PRIMARY KEY (ma_nhap_vien);


--
-- TOC entry 4761 (class 2606 OID 25173)
-- Name: phieu_dang_ky phieu_dang_ky_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieu_dang_ky
    ADD CONSTRAINT phieu_dang_ky_pkey PRIMARY KEY (ma_dang_ky);


--
-- TOC entry 4767 (class 2606 OID 25159)
-- Name: buoi_kham_chuyen_khoa fk_bk_don_thuoc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buoi_kham_chuyen_khoa
    ADD CONSTRAINT fk_bk_don_thuoc FOREIGN KEY (ma_don_thuoc) REFERENCES public.don_thuoc(ma_don_thuoc);


--
-- TOC entry 4768 (class 2606 OID 25164)
-- Name: buoi_kham_chuyen_khoa fk_bk_hoa_don; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buoi_kham_chuyen_khoa
    ADD CONSTRAINT fk_bk_hoa_don FOREIGN KEY (ma_hoa_don) REFERENCES public.hoa_don(ma_hoa_don);


--
-- TOC entry 4769 (class 2606 OID 25154)
-- Name: buoi_kham_chuyen_khoa fk_bk_nhap_vien; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buoi_kham_chuyen_khoa
    ADD CONSTRAINT fk_bk_nhap_vien FOREIGN KEY (ma_nhap_vien) REFERENCES public.nhap_vien(ma_nhap_vien);


--
-- TOC entry 4766 (class 2606 OID 25137)
-- Name: chi_tiet_don_thuoc fk_ctdt_don_thuoc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chi_tiet_don_thuoc
    ADD CONSTRAINT fk_ctdt_don_thuoc FOREIGN KEY (ma_don_thuoc) REFERENCES public.don_thuoc(ma_don_thuoc);


--
-- TOC entry 4765 (class 2606 OID 25120)
-- Name: chi_tiet_dieu_tri fk_ctdt_nhap_vien; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chi_tiet_dieu_tri
    ADD CONSTRAINT fk_ctdt_nhap_vien FOREIGN KEY (ma_nhap_vien) REFERENCES public.nhap_vien(ma_nhap_vien);


--
-- TOC entry 4770 (class 2606 OID 25179)
-- Name: phieu_dang_ky fk_dk_bac_si; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieu_dang_ky
    ADD CONSTRAINT fk_dk_bac_si FOREIGN KEY (ma_bac_si) REFERENCES public.bac_si(ma_bac_si);


--
-- TOC entry 4771 (class 2606 OID 25174)
-- Name: phieu_dang_ky fk_dk_benh_nhan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieu_dang_ky
    ADD CONSTRAINT fk_dk_benh_nhan FOREIGN KEY (ma_benh_nhan) REFERENCES public.benh_nhan(ma_benh_nhan);


--
-- TOC entry 4772 (class 2606 OID 25184)
-- Name: phieu_dang_ky fk_dk_buoi_kham; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieu_dang_ky
    ADD CONSTRAINT fk_dk_buoi_kham FOREIGN KEY (ma_buoi_kham) REFERENCES public.buoi_kham_chuyen_khoa(ma_buoi_kham);


--
-- TOC entry 4773 (class 2606 OID 25217)
-- Name: kham_can_lam_sang fk_kcls_buoi_kham; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kham_can_lam_sang
    ADD CONSTRAINT fk_kcls_buoi_kham FOREIGN KEY (ma_buoi_kham) REFERENCES public.buoi_kham_chuyen_khoa(ma_buoi_kham);


--
-- TOC entry 4774 (class 2606 OID 25196)
-- Name: kham_can_lam_sang fk_kcls_dich_vu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kham_can_lam_sang
    ADD CONSTRAINT fk_kcls_dich_vu FOREIGN KEY (ma_dich_vu) REFERENCES public.danh_muc_can_lam_sang(ma_dich_vu);


--
-- TOC entry 4775 (class 2606 OID 25201)
-- Name: kham_can_lam_sang fk_kcls_kytv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kham_can_lam_sang
    ADD CONSTRAINT fk_kcls_kytv FOREIGN KEY (ma_ky_thuat_vien) REFERENCES public.ky_thuat_vien(ma_ky_thuat_vien);


--
-- TOC entry 4764 (class 2606 OID 25110)
-- Name: nhap_vien fk_nv_kytv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhap_vien
    ADD CONSTRAINT fk_nv_kytv FOREIGN KEY (ma_ky_thuat_vien) REFERENCES public.ky_thuat_vien(ma_ky_thuat_vien);


-- Completed on 2025-06-18 23:36:48

--
-- PostgreSQL database dump complete
--

