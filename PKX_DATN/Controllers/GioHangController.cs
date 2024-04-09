using AspNetCoreHero.ToastNotification.Abstractions;

using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebShop.Extension;
using WebShop.Models;
using WebShop.ModelViews;

namespace WebShop.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly webshopContext _context;
        public INotyfService _notyfService { get; }


        public ShoppingCartController(webshopContext context, INotyfService notyfService)
        {
            _context = context;
            _notyfService = notyfService;
        }

        public List<CartItem> GioHang
        {
            get
            {
                var gh = HttpContext.Session.Get<List<CartItem>>("GioHang");
                if (gh == default(List<CartItem>))
                {
                    gh = new List<CartItem>();
                }
                return gh;
            }
        }

        [HttpPost]
        [Route("api/cart/add")]
        public IActionResult AddToCart(int productID, int? amount)
        {
            List<CartItem> gioHang = GioHang;
            try
            {
                //them sp vao gio hang
                CartItem item = GioHang.SingleOrDefault(p => p.product.ProductId == productID);
                if (item != null)//da co --> capnhat so luong
                {
                    if (amount.HasValue)
                    {
                        item.amount = amount.Value;
                    }
                    else
                    {
                        item.amount++;
                    }

                }
                else
                {
                    Product hh = _context.Products.SingleOrDefault(p => p.ProductId == productID);
                    item = new CartItem
                    {
                        amount = amount.HasValue ? amount.Value : 1,
                        product = hh
                    };
                    gioHang.Add(item);//them vao gio
                }
                //luu lai Session
                HttpContext.Session.Set<List<CartItem>>("GioHang", gioHang);
                _notyfService.Success("Thêm sản phẩm thành công");
                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }

        [HttpPost]
        [Route("api/cart/update")]
        public IActionResult UpdateCart(int productId, int? amount)
        {
            var cart = HttpContext.Session.Get<List<CartItem>>("GioHang") ?? new List<CartItem>();

            var itemToUpdate = cart.SingleOrDefault(item => item.product.ProductId == productId);
            if (itemToUpdate != null)
            {
                if (itemToUpdate != null && amount.HasValue)
                {
                    if (amount == 0)
                    {
                        cart.Remove(itemToUpdate);
                    }
                    itemToUpdate.amount = amount.Value;
                }
            }

            HttpContext.Session.Set<List<CartItem>>("GioHang", cart);

            return Json(new { success = true });
        }


        [HttpPost]
        [Route("api/cart/remove")]
        public ActionResult Remove(int productID)
        {
            try
            {
                var cart = HttpContext.Session.Get<List<CartItem>>("GioHang") ?? new List<CartItem>();

                var itemToUpdate = cart.SingleOrDefault(item => item.product.ProductId == productID);
                if (itemToUpdate != null)
                {
                    cart.Remove(itemToUpdate);
                }
                // luu lai session
                HttpContext.Session.Set<List<CartItem>>("GioHang", cart);
                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }
        [Route("cart.html", Name = "Cart")]
        public IActionResult Index()
        {
            return View(GioHang);
        }
    }
}
