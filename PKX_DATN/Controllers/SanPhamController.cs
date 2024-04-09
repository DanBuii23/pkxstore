using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using WebShop.Models;

namespace WebShop.Controllers
{
    public class ProductController : Controller
    {
        private readonly webshopContext _context;

        public ProductController(webshopContext context)
        {
            _context = context;
        }
        [Route("shop.html", Name = "ShopProduct")]
        //public IActionResult Index(int? page)
        //{
        //    try
        //    {
        //        var pageNumber = page == null || page <= 0 ? 1 : page.Value;
        //        var pageSize = 6;
        //        var lsProduct = _context.Products.AsNoTracking()

        //            .OrderByDescending(x => x.DateCreated);
        //        PagedList<Product> models = new PagedList<Product>(lsProduct, pageNumber, pageSize);
        //        ViewBag.CurrentPage = pageNumber;
        //        ViewBag.SanPham = lsProduct;



        //        return View(models);
        //    }
        //    catch
        //    {
        //        return RedirectToAction("Index", "Home");
        //    }


        //}

        public async Task<IActionResult> Index(string currentFilter, string searchString, int? pageNumber)
        {

            ViewData["CurrentFilter"] = searchString;
            if (searchString != null)
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            var p = from s in _context.Products
                    select s;
            if (!String.IsNullOrEmpty(searchString))
            {
                p = p.Where(s => s.ProductName.Contains(searchString)
                                       || s.Price.ToString().Contains(searchString));
            }
            int pageSize = 6;
            return View(await PaginatedList<Product>.CreateAsync(p.AsNoTracking(), pageNumber ?? 1, pageSize));
        }


        [Route("/{CatID}", Name = "ListProduct")]
        public IActionResult List(int CatID, int page = 1)
        {
            try
            {
                var pageSize = 20;
                var danhmuc = _context.Categories.AsNoTracking().SingleOrDefault(x => x.CatId == CatID);
                if (danhmuc != null)
                {
                    var lsTinTuc = _context.Products.AsNoTracking()
                  .Where(x => x.CatId == danhmuc.CatId)
                  .OrderByDescending(x => x.DateCreated);
                    PagedList<Product> models = new PagedList<Product>(lsTinTuc, page, pageSize);
                    ViewBag.CurrentPage = page;
                    ViewBag.CurrentCat = danhmuc;
                    return View(models);
                }
                return RedirectToAction("Index", "Home");


            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }


        }


        [Route("/{Alias}-{id}.html", Name = "ProductDetails")]
        public IActionResult Details(int id)
        {
            try
            {
                var product = _context.Products.Include(x => x.Cat).FirstOrDefault(x => x.ProductId == id);
                if (product == null)
                {
                    return RedirectToAction("Index");
                }

                var lsProduct = _context.Products
                    .AsNoTracking()
                    .Where(x => x.CatId == product.CatId && x.ProductId != id && x.Active == true)
                    .OrderByDescending(x => x.DateCreated)
                    .Take(4)
                    .ToList();
                ViewBag.SanPham = lsProduct;
                return View(product);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }


        }
    }
}
