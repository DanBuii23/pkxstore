using System;
using System.Collections.Generic;

namespace PKX_DATN.Models;

public partial class TblNhaCungCap
{
    public TblNhaCungCap() 
    { 
        TblSanPhams = new HashSet<TblSanPham>();
    }  
    public int IdNhaCungCap { get; set; }

    public string STenNhaCungCap { get; set; } = null!;

    public string? SDiaChi { get; set; }

    public int? ISoLuongSanPham { get; set; }

    public virtual ICollection<TblSanPham> TblSanPhams { get; set; } = new List<TblSanPham>();
}
