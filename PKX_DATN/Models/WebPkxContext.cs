using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace PKX_DATN.Models;

public partial class WebPkxContext : DbContext
{
    public WebPkxContext()
    {
    }

    public WebPkxContext(DbContextOptions<WebPkxContext> options)
        : base(options)
    {
    }

    public virtual DbSet<TblChiTietDonHang> TblChiTietDonHangs { get; set; }

    public virtual DbSet<TblDanhMuc> TblDanhMucs { get; set; }

    public virtual DbSet<TblDonHang> TblDonHangs { get; set; }

    public virtual DbSet<TblKhachHang> TblKhachHangs { get; set; }

    public virtual DbSet<TblNhaCungCap> TblNhaCungCaps { get; set; }

    public virtual DbSet<TblNhanVien> TblNhanViens { get; set; }

    public virtual DbSet<TblQuyenHan> TblQuyenHans { get; set; }

    public virtual DbSet<TblSanPham> TblSanPhams { get; set; }

    public virtual DbSet<TblTrangThaiDonHang> TblTrangThaiDonHangs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DansLaptop\\SQLEXPRESS;Initial Catalog=webPKX;Integrated Security=True;Encrypt=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<TblChiTietDonHang>(entity =>
        {
            entity.HasKey(e => e.IdChiTietDonHang).HasName("PK_ChiTietDonHang");

            entity.ToTable("tbl_ChiTietDonHang");

            entity.Property(e => e.IdChiTietDonHang).HasColumnName("ID_ChiTietDonHang");
            entity.Property(e => e.FTongTien).HasColumnName("fTongTien");
            entity.Property(e => e.ISoLuong).HasColumnName("iSoLuong");
            entity.Property(e => e.IdDonHang).HasColumnName("ID_DonHang");
            entity.Property(e => e.IdSanPham).HasColumnName("ID_SanPham");

            entity.HasOne(d => d.IdDonHangNavigation).WithMany(p => p.TblChiTietDonHangs)
                .HasForeignKey(d => d.IdDonHang)
                .HasConstraintName("FK_ChiTietDonHang_DonHang");
        });

        modelBuilder.Entity<TblDanhMuc>(entity =>
        {
            entity.HasKey(e => e.IdDanhMuc).HasName("PK_DanhMuc");

            entity.ToTable("tbl_DanhMuc");

            entity.Property(e => e.IdDanhMuc).HasColumnName("ID_DanhMuc");
            entity.Property(e => e.BTrangThai).HasColumnName("bTrangThai");
            entity.Property(e => e.SHinhAnh)
                .HasMaxLength(250)
                .HasColumnName("sHinhAnh");
            entity.Property(e => e.SMoTa).HasColumnName("sMoTa");
            entity.Property(e => e.STenDanhMuc)
                .HasMaxLength(250)
                .HasColumnName("sTenDanhMuc");
        });

        modelBuilder.Entity<TblDonHang>(entity =>
        {
            entity.HasKey(e => e.IdDonHang).HasName("PK_DonHang");

            entity.ToTable("tbl_DonHang");

            entity.Property(e => e.IdDonHang).HasColumnName("ID_DonHang");
            entity.Property(e => e.DNgayTao)
                .HasColumnType("datetime")
                .HasColumnName("dNgayTao");
            entity.Property(e => e.FPhiVanChuyen).HasColumnName("fPhiVanChuyen");
            entity.Property(e => e.FTongTien).HasColumnName("fTongTien");
            entity.Property(e => e.IdKhachHang).HasColumnName("ID_KhachHang");
            entity.Property(e => e.IdSanPham).HasColumnName("ID_SanPham");
            entity.Property(e => e.IdTrangThai).HasColumnName("ID_TrangThai");
            entity.Property(e => e.SDiaChi).HasColumnName("sDiaChi");
            entity.Property(e => e.SGhiChu).HasColumnName("sGhiChu");

            entity.HasOne(d => d.IdKhachHangNavigation).WithMany(p => p.TblDonHangs)
                .HasForeignKey(d => d.IdKhachHang)
                .HasConstraintName("FK_DonHang_KhachHang");

            entity.HasOne(d => d.IdSanPhamNavigation).WithMany(p => p.TblDonHangs)
                .HasForeignKey(d => d.IdSanPham)
                .HasConstraintName("FK_DonHang_SanPham");

            entity.HasOne(d => d.IdTrangThaiNavigation).WithMany(p => p.TblDonHangs)
                .HasForeignKey(d => d.IdTrangThai)
                .HasConstraintName("FK_DonHang_TrangThaiDonHang");
        });

        modelBuilder.Entity<TblKhachHang>(entity =>
        {
            entity.HasKey(e => e.IdKhachHang).HasName("PK_KhachHang");

            entity.ToTable("tbl_KhachHang");

            entity.Property(e => e.IdKhachHang).HasColumnName("ID_KhachHang");
            entity.Property(e => e.SDiaChi)
                .HasMaxLength(255)
                .HasColumnName("sDiaChi");
            entity.Property(e => e.SEmail)
                .HasMaxLength(150)
                .IsFixedLength()
                .HasColumnName("sEmail");
            entity.Property(e => e.SPassword)
                .HasMaxLength(50)
                .HasColumnName("sPassword");
            entity.Property(e => e.SSdt)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("sSDT");
            entity.Property(e => e.STenKhachHang)
                .HasMaxLength(255)
                .HasColumnName("sTenKhachHang");
        });

        modelBuilder.Entity<TblNhaCungCap>(entity =>
        {
            entity.HasKey(e => e.IdNhaCungCap).HasName("PK__tbl_NhaC__D1E6E45E01664E25");

            entity.ToTable("tbl_NhaCungCap");

            entity.Property(e => e.IdNhaCungCap).HasColumnName("ID_NhaCungCap");
            entity.Property(e => e.ISoLuongSanPham).HasColumnName("iSoLuongSanPham");
            entity.Property(e => e.SDiaChi)
                .HasMaxLength(300)
                .HasColumnName("sDiaChi");
            entity.Property(e => e.STenNhaCungCap)
                .HasMaxLength(300)
                .HasColumnName("sTenNhaCungCap");
        });

        modelBuilder.Entity<TblNhanVien>(entity =>
        {
            entity.HasKey(e => e.IdNhanVien).HasName("PK_NhanVien");

            entity.ToTable("tbl_NhanVien");

            entity.Property(e => e.IdNhanVien).HasColumnName("ID_NhanVien");
            entity.Property(e => e.IdQuyenHan).HasColumnName("ID_QuyenHan");
            entity.Property(e => e.SEmail)
                .HasMaxLength(50)
                .HasColumnName("sEmail");
            entity.Property(e => e.SHoTen)
                .HasMaxLength(150)
                .HasColumnName("sHoTen");
            entity.Property(e => e.SPassword)
                .HasMaxLength(50)
                .HasColumnName("sPassword");
            entity.Property(e => e.SSdt)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("sSDT");

            entity.HasOne(d => d.IdQuyenHanNavigation).WithMany(p => p.TblNhanViens)
                .HasForeignKey(d => d.IdQuyenHan)
                .HasConstraintName("FK_NhanVien_QuyenHan");
        });

        modelBuilder.Entity<TblQuyenHan>(entity =>
        {
            entity.HasKey(e => e.IdQuyenHan).HasName("PK_QuyenHan");

            entity.ToTable("tbl_QuyenHan");

            entity.Property(e => e.IdQuyenHan).HasColumnName("ID_QuyenHan");
            entity.Property(e => e.IMucDoSuDung).HasColumnName("iMucDoSuDung");
            entity.Property(e => e.SMoTa)
                .HasMaxLength(50)
                .HasColumnName("sMoTa");
            entity.Property(e => e.STenQuyenHan)
                .HasMaxLength(50)
                .HasColumnName("sTenQuyenHan");
        });

        modelBuilder.Entity<TblSanPham>(entity =>
        {
            entity.HasKey(e => e.IdSanPham).HasName("PK_SanPham");

            entity.ToTable("tbl_SanPham");

            entity.Property(e => e.IdSanPham).HasColumnName("ID_SanPham");
            entity.Property(e => e.Alias).HasMaxLength(255);
            entity.Property(e => e.BTrangThai).HasColumnName("bTrangThai");
            entity.Property(e => e.DNgaySua)
                .HasColumnType("datetime")
                .HasColumnName("dNgaySua");
            entity.Property(e => e.DNgayTao)
                .HasColumnType("datetime")
                .HasColumnName("dNgayTao");
            entity.Property(e => e.FGiaTien).HasColumnName("fGiaTien");
            entity.Property(e => e.ISoLuongTonKho).HasColumnName("iSoLuongTonKho");
            entity.Property(e => e.IdDanhMuc).HasColumnName("ID_DanhMuc");
            entity.Property(e => e.IdNhaCungCap).HasColumnName("ID_NhaCungCap");
            entity.Property(e => e.SHinhAnh)
                .HasMaxLength(255)
                .HasColumnName("sHinhAnh");
            entity.Property(e => e.SMoTa)
                .HasMaxLength(255)
                .HasColumnName("sMoTa");
            entity.Property(e => e.SMoTaChiTiet).HasColumnName("sMoTaChiTiet");
            entity.Property(e => e.STenSanPham)
                .HasMaxLength(255)
                .HasColumnName("sTenSanPham");

            entity.HasOne(d => d.IdDanhMucNavigation).WithMany(p => p.TblSanPhams)
                .HasForeignKey(d => d.IdDanhMuc)
                .HasConstraintName("FK_SanPham_DanhMuc");

            entity.HasOne(d => d.IdNhaCungCapNavigation).WithMany(p => p.TblSanPhams)
                .HasForeignKey(d => d.IdNhaCungCap)
                .HasConstraintName("FK__tbl_SanPh__ID_Nh__5DCAEF64");
        });

        modelBuilder.Entity<TblTrangThaiDonHang>(entity =>
        {
            entity.HasKey(e => e.IdTrangThai).HasName("PK_TrangThaiDonHang");

            entity.ToTable("tbl_TrangThaiDonHang");

            entity.Property(e => e.IdTrangThai).HasColumnName("ID_TrangThai");
            entity.Property(e => e.SMoTa).HasColumnName("sMoTa");
            entity.Property(e => e.STrangThai)
                .HasMaxLength(50)
                .HasColumnName("sTrangThai");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
