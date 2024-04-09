using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PKX_DATN.Models;

namespace PKX_DATN.Controllers
{
    public class TimKiemController : Controller
    {
        private readonly WebPkxContext _context;
        public TimKiemController(WebPkxContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult FindProduct(string keyword)
        {
            List<TblSanPham> ls = new List<TblSanPham>();
            if (string.IsNullOrEmpty(keyword) || keyword.Length < 1)
            {
                return PartialView("ListProductsSearchPartial", null);
            }
            ls = _context.TblSanPhams
                .AsNoTracking()
                .Include(a => a.IdDanhMuc)
                .Where(x => x.STenSanPham.Contains(keyword))
                .OrderByDescending(x => x.STenSanPham)
                .Take(10)
                .ToList();
            if (ls == null)
            {
                return PartialView("ListProductsSearchPartial", null);
            }
            else
            {
                return PartialView("ListProductsSearchPartial", ls);
            }
        }
    }
}
