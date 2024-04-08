USE [master]
GO
/****** Object:  Database [webshop]    Script Date: 03/07/2024 12:14:24 ******/
CREATE DATABASE [webPKX]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'webshop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\webshop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'webshop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\webshop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [webshop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [webshop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [webPKX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [webPKX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [webPKX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [webPKX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [webPKX] SET ARITHABORT OFF 
GO
ALTER DATABASE [webPKX] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [webPKX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [webPKX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [webPKX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [webPKX] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [webPKX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [webPKX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [webPKX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [webPKX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [webPKX] SET  DISABLE_BROKER 
GO
ALTER DATABASE [webPKX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [webPKX] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [webPKX] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [webPKX] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [webPKX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [webPKX] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [webPKX] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [webPKX] SET RECOVERY FULL 
GO
ALTER DATABASE [webPKX] SET  MULTI_USER 
GO
ALTER DATABASE [webPKX] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [webPKX] SET DB_CHAINING OFF 
GO
ALTER DATABASE [webPKX] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [webPKX] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [webPKX] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [webPKX] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'webPKX', N'ON'
GO
ALTER DATABASE [webPKX] SET QUERY_STORE = OFF
GO
USE [webPKX]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 03/07/2024 12:14:24 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO

GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO

/****** Object:  Table [dbo].[Accounts]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_NhanVien](
	[ID_NhanVien] [int] IDENTITY(1,1) NOT NULL,
	[sSDT] [varchar](12) NULL,
	[sEmail] [nvarchar](50) NULL,
	[sPassword] [nvarchar](50) NULL,
	[sHoTen] [nvarchar](150) NULL,
	[ID_QuyenHan] [int] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[ID_NhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DanhMuc](
	[ID_DanhMuc] [int] IDENTITY(1,1) NOT NULL,
	[sTenDanhMuc] [nvarchar](250) NULL,
	[sMoTa] [nvarchar](max) NULL,
	[bTrangThai] [bit] NOT NULL,
	[sHinhAnh] [nvarchar](250) NULL,
	
 CONSTRAINT [PK_DanhMuc] PRIMARY KEY CLUSTERED 
(
	[ID_DanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_KhachHang](
	[ID_KhachHang] [int] IDENTITY(1,1) NOT NULL,
	[sTenKhachHang] [nvarchar](255) NULL,
	[sDiaChi] [nvarchar](255) NULL,
	[sEmail] [nchar](150) NULL,
	[sSDT] [varchar](12) NULL,
	[sPassword] [nvarchar](50) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[ID_KhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderDetails]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ChiTietDonHang](
	[ID_ChiTietDonHang] [int] IDENTITY(1,1) NOT NULL,
	[ID_DonHang] [int] NULL,
	[ID_SanPham] [int] NULL,
	[iSoLuong] [int] NULL,
	[fTongTien] [int] NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[ID_ChiTietDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DonHang](
	[ID_DonHang] [int] IDENTITY(1,1) NOT NULL,
	[ID_KhachHang] [int] NULL,
	[ID_TrangThai] [int] NULL,
	[sGhiChu] [nvarchar](max) NULL,
	[fPhiVanChuyen] [int] NULL,
	[fTongTien] [int] NULL,
	[sDiaChi] [nvarchar](max) NULL,
	[ID_SanPham] [int] NULL,
	[dNgayTao] [datetime] null
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SanPham](
	[ID_SanPham] [int] IDENTITY(1,1) NOT NULL,
	[sTenSanPham] [nvarchar](255) NULL,
	[sMoTa] [nvarchar](255) NULL,
	[sMoTaChiTiet] [nvarchar](max) NULL,
	[ID_DanhMuc] [int] NULL,
	[fGiaTien] [int] NULL,
	[sHinhAnh] [nvarchar](255) NULL,
	[dNgayTao] [datetime] NULL,
	[dNgaySua] [datetime] NULL,
	[bTrangThai] [bit] NULL,
	[Alias] [nvarchar](255) NULL,
	[iSoLuongTonKho] [int] NULL,
	[ID_NhaCungCap] int NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[ID_SanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_QuyenHan](
	[ID_QuyenHan] [int] IDENTITY(1,1) NOT NULL,
	[sTenQuyenHan] [nvarchar](50) NULL,
	[sMoTa] [nvarchar](50) NULL,
	[iMucDoSuDung] [int] NULL,
 CONSTRAINT [PK_QuyenHan] PRIMARY KEY CLUSTERED 
(
	[ID_QuyenHan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_NhaCungCap](
	[ID_NhaCungCap] [int] IDENTITY(1,1) NOT NULL,
	[sTenNhaCungCap] [nvarchar](300) NOT NULL,
	[sDiaChi] [nvarchar](300) NULL,
	[iSoLuongSanPham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_NhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactStatus]    Script Date: 03/07/2024 12:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TrangThaiDonHang](
	[ID_TrangThai] [int] IDENTITY(1,1) NOT NULL,
	[sTrangThai] [nvarchar](50) NULL,
	[sMoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_TrangThaiDonHang] PRIMARY KEY CLUSTERED 
(
	[ID_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_NhanVien] ON 

INSERT [dbo].[tbl_NhanVien] ([sSDT], [sEmail], [sPassword], [sHoTen], [ID_QuyenHan]) VALUES (N'0912654789', N'danbuii2001@gmail.com', N'123456', N'Bùi Thành ?an',1)
INSERT [dbo].[tbl_NhanVien] ([sSDT], [sEmail], [sPassword], [sHoTen], [ID_QuyenHan]) VALUES (N'0987123456', N'linhbui123@gmail.com', N'123456', N'Bùi Ph??ng Linh',2)
INSERT [dbo].[tbl_NhanVien] ([sSDT], [sEmail], [sPassword], [sHoTen], [ID_QuyenHan]) VALUES (N'0978654321', N'nva123321@gmail.com', N'123456', N'Nguy?n V?n A',1)


SET IDENTITY_INSERT [dbo].[tbl_NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_DanhMuc] ON 

INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'?èn tr? sáng', N'?èn tr? sáng ?i ?êm',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'M?ch ?èn', N'Cung c?p ngu?n ?i?n ?n ??nh cho các ch?c n?ng trên xe ho?t ??ng ?n ??nh',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'Khóa ch?ng tr?m', N'Khóa ch?ng tr?m thông minh smartkey',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'Combo ti?t ki?m', N'?èn tr? sáng và m?ch tích h?p',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'?? ch?i xe máy', N'Gù, g??ng, ?? trang trí, ...',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'Ph? ki?n ph??t', N'?? b?o h?, gù ch?ng ??,...',1 , N'default.jpg')
INSERT [dbo].[tbl_DanhMuc] ([sTenDanhMuc], [sMoTa], [bTrangThai], [sHinhAnh]) VALUES (N'?? ?i m?a', N'B?o v? ?i?n tho?i, ch?n bùn,...',1 , N'default.jpg')
SET IDENTITY_INSERT [dbo].[tbl_DanhMuc] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_KhachHang] ON 

INSERT [dbo].[tbl_KhachHang] ([sTenKhachHang],[sDiaChi], [sEmail], [sSDT], [sPassword]) VALUES (N'Kim Ph??ng',N'D??ng Qu?ng Hàm 8/48/72', N'kphuong@gmail.com', N'0973123654',N'123654')
INSERT [dbo].[tbl_KhachHang] ([sTenKhachHang],[sDiaChi], [sEmail], [sSDT], [sPassword]) VALUES (N'Nguy?n Ng?c Ng?n',N'Kim ??ng 23/2', N'ngan232@gmail.com', N'0123654789',N'123654')
INSERT [dbo].[tbl_KhachHang] ([sTenKhachHang],[sDiaChi], [sEmail], [sSDT], [sPassword]) VALUES (N'Bình',N'H?i D??ng', N'binhhd@gmail.com', N'0987765432',N'123654')
INSERT [dbo].[tbl_KhachHang] ([sTenKhachHang],[sDiaChi], [sEmail], [sSDT], [sPassword]) VALUES (N'H?i',N'Tuyên Quang', N'haitq@gmail.com', N'0973987879',N'123654')
INSERT [dbo].[tbl_KhachHang] ([sTenKhachHang],[sDiaChi], [sEmail], [sSDT], [sPassword]) VALUES (N'B?o Giang',N'Thanh Trì, Hà N?i', N'baogiangld@gmail.com', N'0999123123',N'123654')

SET IDENTITY_INSERT [dbo].[tbl_KhachHang] OFF
GO

SET IDENTITY_INSERT [dbo].[tbl_ChiTietDonHang] ON 

INSERT [dbo].[tbl_ChiTietDonHang] ([ID_DonHang], [ID_SanPham], [iSoLuong], [fTongTien]) VALUES (1, 1, 2, 1168000)
INSERT [dbo].[tbl_ChiTietDonHang] ([ID_DonHang], [ID_SanPham], [iSoLuong], [fTongTien]) VALUES (2, 3, 2, 102000)
INSERT [dbo].[tbl_ChiTietDonHang] ([ID_DonHang], [ID_SanPham], [iSoLuong], [fTongTien]) VALUES (3, 4, 2, 112000)
INSERT [dbo].[tbl_ChiTietDonHang] ([ID_DonHang], [ID_SanPham], [iSoLuong], [fTongTien]) VALUES (4, 2, 2, 80000)

SET IDENTITY_INSERT [dbo].[tbl_ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_DonHang] ON 

INSERT [dbo].[tbl_DonHang] ([ID_KhachHang], [ID_TrangThai], [sGhiChu],[fPhiVanChuyen], [fTongTien], [sDiaChi], [ID_SanPham],[dNgayTao]) VALUES (1, 1, Null, NULL,1168000 , NULL, 1, CAST(N'2023-04-17T10:13:35.093' AS DateTime))
INSERT [dbo].[tbl_DonHang] ([ID_KhachHang], [ID_TrangThai], [sGhiChu],[fPhiVanChuyen], [fTongTien], [sDiaChi], [ID_SanPham],[dNgayTao]) VALUES (2, 3, Null, NULL,102000 , NULL, 3, CAST(N'2023-04-17T10:13:35.093' AS DateTime))
INSERT [dbo].[tbl_DonHang] ([ID_KhachHang], [ID_TrangThai], [sGhiChu],[fPhiVanChuyen], [fTongTien], [sDiaChi], [ID_SanPham],[dNgayTao]) VALUES (3, 4, Null, NULL,112000 , NULL, 4, CAST(N'2023-04-17T10:13:35.093' AS DateTime))
INSERT [dbo].[tbl_DonHang] ([ID_KhachHang], [ID_TrangThai], [sGhiChu],[fPhiVanChuyen], [fTongTien], [sDiaChi], [ID_SanPham],[dNgayTao]) VALUES (4, 2, Null, NULL,80000 , NULL, 2, CAST(N'2023-04-17T10:13:35.093' AS DateTime))

SET IDENTITY_INSERT [dbo].[tbl_DonHang] OFF

GO

SET IDENTITY_INSERT [dbo].[tbl_SanPham] ON 

INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'?èn bi c?u mini T2', N'Bi c?u T2', N'?èn bi c?u tr? sáng ánh sáng ?? m?nh ?? ?i ?êm', 1, 600000, N'bicaumini1.jpg', CAST(N'2024-04-04T14:35:04.000' AS DateTime), CAST(N'2024-04-07T17:04:27.207' AS DateTime), 1, N'bi-cau-mini', 30)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'?èn bi c?u mini T3', N'Bi c?u T3', N'?èn bi c?u tr? sáng ánh sáng ?? m?nh ?? ?i ?êm', 1, 600000, N'bicaumini2.jpg', CAST(N'2024-04-04T14:35:04.000' AS DateTime), CAST(N'2024-04-07T17:04:27.207' AS DateTime), 1, N'bi-cau-mini', 30)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'M?ch ?èn xe', N'M?ch ?i?n', N'M?ch ?i?n n?i ?èn', 2, 200000, N'machdien1.jpg', CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1,N'mach-dien-xe-may', 50)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'M?ch b?t t?t ?èn xe', N'M?ch b?t t?t', N'M?ch n?i công t?c b?t t?t ?èn', 2, 100000, N'machbattat.jpg', CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1, N'bat-tat-den',50)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'Khóa ch?ng tr?m Hiper', N'Khóa ch?ng tr?m', N'Khóa ch?ng tr?m Hiper giá r?', 3, 800000,  N'khoahiper.jpg',  CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1,N'khoa-hiper',100)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'Khóa SmartKey Hyper MOD', N'Khóa ch?ng tr?m', N'Khóa cao c?p HyperMOD', 3, 2000000,  N'smkhyper.jpg',  CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1, N'smartkey-hypermod', 50)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'Combo 1', N'M?ch ?i?n và bi c?u mini T2', N'md1 biT2', 4, 700000,  N'combotk1.jpg',  CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1, N'mach-dien-bi-cau-t2', 50)
INSERT [dbo].[tbl_SanPham] ([sTenSanPham], [sMoTa], [sMoTaChiTiet], [ID_DanhMuc], [fGiaTien],[sHinhAnh], [dNgayTao], [dNgaySua],  [bTrangThai],  [Alias], [iSoLuongTonKho]) VALUES (N'Combo 2', N'M?ch ?i?n và bi c?u mini T3', N'md1 biT3', 4, 700000,  N'combotk2.jpg',  CAST(N'2024-04-20T14:35:04.000' AS DateTime), CAST(N'2024-05-31T17:04:27.207' AS DateTime), 1, N'mach-dien-bi-cau-t3', 50)


SET IDENTITY_INSERT [dbo].[tbl_SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_QuyenHan] ON 

INSERT [dbo].[tbl_QuyenHan] ( [sTenQuyenHan], [sMoTa], [iMucDoSuDung]) VALUES (N'Admin', N'Qu?n tr? viên', 1)
INSERT [dbo].[tbl_QuyenHan] ( [sTenQuyenHan], [sMoTa], [iMucDoSuDung]) VALUES (N'Nhân Viên', N'Nhân viên bán hàng', 2)
SET IDENTITY_INSERT [dbo].[tbl_QuyenHan] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_NhaCungCap] ON 

INSERT [dbo].[tbl_NhaCungCap] ( [sTenNhaCungCap], [sDiaChi], [iSoLuongSanPham]) VALUES ( N'?? Xe Hà Thành', N'Trung Ph?ng, Hà N?i', 200)
INSERT [dbo].[tbl_NhaCungCap] ( [sTenNhaCungCap], [sDiaChi], [iSoLuongSanPham]) VALUES ( N'AloBike', N'hà n?i', 500)
INSERT [dbo].[tbl_NhaCungCap] ( [sTenNhaCungCap], [sDiaChi], [iSoLuongSanPham]) VALUES ( N'Shop2Banh', N'Tp. H? Chí Minh', 200)

SET IDENTITY_INSERT [dbo].[tbl_NhaCungCap] OFF

GO
SET IDENTITY_INSERT [dbo].[tbl_TrangThaiDonHang] ON 

INSERT [dbo].[tbl_TrangThaiDonHang] ([sTrangThai], [sMoTa]) VALUES (N'Ch? l?y hàng', N'?ã xác nh?n và ?ang so?n hàng')
INSERT [dbo].[tbl_TrangThaiDonHang] ( [sTrangThai], [sMoTa]) VALUES ( N'Ch? xác nh?n ', N'?ang ???c ng??i bán xác nh?n v?i ng??i mua')
INSERT [dbo].[tbl_TrangThaiDonHang] ( [sTrangThai], [sMoTa]) VALUES (N'?ang giao', N'??n hàng ?ang ???c giao t?i ng??i mua')
INSERT [dbo].[tbl_TrangThaiDonHang] ( [sTrangThai], [sMoTa]) VALUES ( N'?ã giao thành công ', N'??n hàng ?ã ???c giao thành công t?i ng??i mua')
INSERT [dbo].[tbl_TrangThaiDonHang] ([sTrangThai], [sMoTa]) VALUES ( N'?ã h?y', N'??n hàng ?ã ???c h?y thành công')
INSERT [dbo].[tbl_TrangThaiDonHang] ( [sTrangThai], [sMoTa]) VALUES ( N'Tr? hàng ', N'??n hàng ?ã ???c tr? hàng thành công')
SET IDENTITY_INSERT [dbo].[tbl_TrangThaiDonHang] OFF
GO
ALTER TABLE [dbo].[tbl_NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_QuyenHan] FOREIGN KEY([ID_QuyenHan])
REFERENCES [dbo].[tbl_QuyenHan] ([ID_QuyenHan])
GO
ALTER TABLE [dbo].[tbl_NhanVien] CHECK CONSTRAINT [FK_NhanVien_QuyenHan]
GO
ALTER TABLE [dbo].[tbl_ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_DonHang] FOREIGN KEY([ID_DonHang])
REFERENCES [dbo].[tbl_DonHang] ([ID_DonHang])
GO
ALTER TABLE [dbo].[tbl_ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_DonHang]
GO
ALTER TABLE [dbo].[tbl_DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_KhachHang] FOREIGN KEY([ID_KhachHang])
REFERENCES [dbo].[tbl_KhachHang] ([ID_KhachHang])
GO
ALTER TABLE [dbo].[tbl_DonHang] CHECK CONSTRAINT [FK_DonHang_KhachHang]
GO
ALTER TABLE [dbo].[tbl_DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_SanPham] FOREIGN KEY([ID_SanPham])
REFERENCES [dbo].[tbl_SanPham] ([ID_SanPham])
GO
ALTER TABLE [dbo].[tbl_DonHang] CHECK CONSTRAINT [FK_DonHang_SanPham]
GO
ALTER TABLE [dbo].[tbl_DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_TrangThaiDonHang] FOREIGN KEY([ID_TrangThai])
REFERENCES [dbo].[tbl_TrangThaiDonHang] ([ID_TrangThai])
GO
ALTER TABLE [dbo].[tbl_DonHang] CHECK CONSTRAINT [FK_DonHang_TrangThaiDonHang]
GO
ALTER TABLE [dbo].[tbl_SanPham]  WITH CHECK ADD FOREIGN KEY(ID_NhaCungCap)
REFERENCES [dbo].[tbl_NhaCungCap] (ID_NhaCungCap)
GO
ALTER TABLE [dbo].[tbl_SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DanhMuc] FOREIGN KEY([ID_DanhMuc])
REFERENCES [dbo].[tbl_DanhMuc] ([ID_DanhMuc])
GO
ALTER TABLE [dbo].[tbl_SanPham] CHECK CONSTRAINT [FK_SanPham_DanhMuc]
GO



