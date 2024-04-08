using System;
using System.Collections.Generic;

namespace PKX_DATN.Models;

public partial class TblKhachHang
{
    public TblKhachHang() 
    {
        TblDonHangs = new HashSet<TblDonHang>();
    }
    public int IdKhachHang { get; set; }

    public string? STenKhachHang { get; set; }

    public string? SDiaChi { get; set; }

    public string? SEmail { get; set; }

    public string? SSdt { get; set; }

    public string? SPassword { get; set; }

    public virtual ICollection<TblDonHang> TblDonHangs { get; set; } = new List<TblDonHang>();
}
