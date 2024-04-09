using AspNetCoreHero.ToastNotification.Abstractions;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using PKX_DATN.Extension;
using PKX_DATN.Helpper;
using PKX_DATN.Models;
using PKX_DATN.ModelViews;

namespace PKX_DATN.Controllers
{
    [Authorize]
    public class TaikhoanController : Controller
    {
        private readonly WebPkxContext _context;
        public INotyfService _notyfService { get; }


        public TaikhoanController(WebPkxContext context, INotyfService notyfService)
        {
            _context = context;
            _notyfService = notyfService;
        }
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ValidatePhone(string Phone)
        {
            try
            {
                var khachhang = _context.TblKhachHangs.AsNoTracking().SingleOrDefault(x => x.SSdt.ToLower() == Phone);
                if (khachhang != null)
                    return Json(data: "Số điện thoại:" + Phone + "đã được sử dụng");
                return Json(data: true);

            }
            catch
            {
                return Json(data: true);
            }
        }
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ValidateEmail(string Email)
        {
            try
            {
                var khachhang = _context.TblKhachHangs.AsNoTracking().SingleOrDefault(x => x.SEmail.ToLower() == Email);
                if (khachhang != null)
                    return Json(data: "Email:" + Email + "đã được sử dụng");
                return Json(data: true);

            }
            catch
            {
                return Json(data: true);
            }
        }

        [Route("tai-khoan-cua-toi.html", Name = "Dashboard")]
        public IActionResult Dashboard()
        {
            //var cart = HttpContext.Session.Get<List<CartItem>>("GioHang");
            var taikhoanID = HttpContext.Session.GetString("CustomerId");
            if (taikhoanID != null)
            {
                var khachhang = _context.TblKhachHangs.AsNoTracking().SingleOrDefault(x => x.IdKhachHang == Convert.ToInt32(taikhoanID));
                if (khachhang != null)
                {
                    var lsDonHang = _context.TblDonHangs
                        .Include(x => x.IdTrangThai)
                        .Include(x => x.IdKhachHang)
                        .AsNoTracking()
                        .Where(x => x.IdKhachHang == khachhang.IdKhachHang)
                        .OrderByDescending(x => x.DNgayTao).ToList();
                    ViewBag.DonHang = lsDonHang;
                    return View(khachhang);
                }
            }
            //ViewBag.GioHang = cart;
            return RedirectToAction("Login");
        }
        [HttpGet]
        [AllowAnonymous]
        [Route("dang-ky.html", Name = "DangKy")]
        public IActionResult DangKyTaiKhoan()
        {
            return View();
        }
        [HttpPost]
        [AllowAnonymous]
        [Route("dang-ky.html", Name = "DangKy")]
        public async Task<IActionResult> DangKyTaiKhoan(RegisterVM taikhoan)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string salt = Utilities.GetRandomKey();
                    TblKhachHang khachhang = new TblKhachHang
                    {
                        STenKhachHang = taikhoan.FullName,
                        SSdt = taikhoan.Phone.Trim().ToLower(),
                        SEmail = taikhoan.Email.Trim().ToLower(),
                        SPassword = taikhoan.Password.Trim(),
                    };
                    try
                    {
                        _context.Add(khachhang);
                        await _context.SaveChangesAsync();
                        //Luu Session Makh
                        HttpContext.Session.SetString("CustomerId", khachhang.IdKhachHang.ToString());
                        var taikhoanID = HttpContext.Session.GetString("CustomerId");
                        //Identity
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name, khachhang.STenKhachHang),
                            new Claim("CustomerId", khachhang.IdKhachHang.ToString())
                        };
                        ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, "Login");
                        ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
                        await HttpContext.SignInAsync(claimsPrincipal);
                        return RedirectToAction("Dashboard", "Accounts");
                    }
                    catch
                    {
                        return View(taikhoan);
                    }
                }
                else
                {
                    return View(taikhoan);
                }
            }
            catch
            {
                return View(taikhoan);
            }
        }

        [AllowAnonymous]
        [Route("dang-nhap.html", Name = "DangNhap")]
        public IActionResult Login(string returnUrl = null)
        {
            var taikhoanID = HttpContext.Session.GetString("CustomerId");
            if (taikhoanID != null)
            {

                return RedirectToAction("Dashboard", "Accounts");

            }
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("dang-nhap.html", Name = "DangNhap")]
        public async Task<IActionResult> Login(DangNhap customer, string returnUrl = null)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    bool isEmail = Utilities.IsValidEmail(customer.UserName);
                    if (!isEmail) return View(customer);
                    var khachhang = _context.TblKhachHangs.AsNoTracking().SingleOrDefault(x => x.SEmail.Trim() == customer.UserName);
                    if (khachhang == null) return RedirectToAction("DangKyTaiKhoan");
                    string pass = customer.sPassword.Trim();
                    if (khachhang.SPassword != pass)
                    {
                        _notyfService.Success("Thông tin đăng nhập chưa chính xác");
                        return View(customer);
                    }
                    //luu session Makh
                    HttpContext.Session.SetString("CustomerId", khachhang.IdKhachHang.ToString());
                    var taikhoanID = HttpContext.Session.GetString("CustomerId");
                    //Identity
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, khachhang.STenKhachHang),
                        new Claim("CustomerId", khachhang.IdKhachHang.ToString())
                    };
                    ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, "login");
                    ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
                    await HttpContext.SignInAsync(claimsPrincipal);
                    _notyfService.Success("Đăng nhập thành công");
                    return RedirectToAction("Dashboard", "Accounts");
                }
            }
            catch
            {
                return RedirectToAction("DangKyTaiKhoan", "Accounts");
            }
            return View(customer);
        }
        [HttpGet]
        [Route("dang-xuat.html", Name = "Logout")]
        public IActionResult Logout()
        {
            HttpContext.SignOutAsync();
            HttpContext.Session.Remove("CustomerId");
            return RedirectToAction("Index", "Home");
        }
        [HttpPost]
        public IActionResult ChangePassword(DoiMatKhau model)
        {
            try
            {
                var taikhoanID = HttpContext.Session.GetString("CustomerId");
                if (taikhoanID == null)
                {
                    return RedirectToAction("Login", "Accounts");
                }
                if (ModelState.IsValid)
                {
                    var taikhoan = _context.TblKhachHangs.Find(Convert.ToInt32(taikhoanID));
                    if (taikhoan == null) return RedirectToAction("Login", "Accounts");

                    var pass = model.PasswordNow.Trim();
                    if (pass == taikhoan.SPassword)
                    {
                        string passnew = model.Password.Trim();
                        taikhoan.SPassword = passnew;
                        _context.Update(taikhoan);
                        _context.SaveChanges();
                        _notyfService.Success("Thay mật khẩu thành công");
                        return RedirectToAction("Dashboard", "Accounts");
                    }
                }
                return RedirectToAction("Dashboard", "Accounts");
            }
            catch
            {
                _notyfService.Success("Thay mật khẩu không thành công");
                return RedirectToAction("Dashboard", "Accounts");
            }
            _notyfService.Success("Thay mật khẩu không thành công");
            return RedirectToAction("Dashboard", "Accounts");
        }
        //public List<CartItem> GioHang
        //{
        //    get
        //    {
        //        var gh = HttpContext.Session.Get<List<CartItem>>("GioHang");
        //        if (gh == default(List<CartItem>))
        //        {
        //            gh = new List<CartItem>();
        //        }
        //        return gh;
        //    }
        //}
    }
}
