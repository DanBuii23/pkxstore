using System;
using System.Collections.Generic;

namespace PKX_DATN.Models;

public partial class TblNhanVien
{
    public int IdNhanVien { get; set; }

    public string? SSdt { get; set; }

    public string? SEmail { get; set; }

    public string? SPassword { get; set; }

    public string? SHoTen { get; set; }

    public int? IdQuyenHan { get; set; }

    public virtual TblQuyenHan? IdQuyenHanNavigation { get; set; }
}
