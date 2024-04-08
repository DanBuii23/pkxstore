using System;
using System.Collections.Generic;

namespace PKX_DATN.Models;

public partial class TblQuyenHan
{
    public TblQuyenHan() 
    {
        TblNhanViens = new HashSet<TblNhanVien>();
    }
    public int IdQuyenHan { get; set; }

    public string? STenQuyenHan { get; set; }

    public string? SMoTa { get; set; }

    public int? IMucDoSuDung { get; set; }

    public virtual ICollection<TblNhanVien> TblNhanViens { get; set; } = new List<TblNhanVien>();
}
