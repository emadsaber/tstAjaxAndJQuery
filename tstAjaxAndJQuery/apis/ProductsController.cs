using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;
using tstAjaxAndJQuery.Models;

namespace tstAjaxAndJQuery.apis
{
    public class ProductsController : ApiController
    {
        private List<Product> _db = new List<Product>()
        {
            new Product() {Id = 1, Name = "Cheese", Price = 300.0, Quantity = 170},
            new Product() {Id = 2, Name = "Bread", Price = 150.0, Quantity = 1500},
            new Product() {Id = 3, Name = "Milk", Price = 200.0, Quantity = 120},
            new Product() {Id = 4, Name = "Jam", Price = 600.0, Quantity = 350},
            new Product() {Id = 5, Name = "Apple", Price = 4000.0, Quantity = 12},
        };

        [HttpGet]
        public string GetAllProducts()
        {
            return new JavaScriptSerializer().Serialize(_db);
        }

        [HttpGet]
        public string GetProduct(int id)
        {
            return new JavaScriptSerializer().Serialize(_db.First(item => item.Id == id));
        }


    }
}
