using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Http.Routing;
using YTicket.API2.DTO;
using YTicket.API2.Models;
using YTicket.API2.Respositories;
using YTicket.API2.Services;

namespace YTicket.API2.Controllers
{
    [RoutePrefix("api/Categories")]
    public class CategoriesController : ApiController
    {
        private EventEntities db = new EventEntities();
        private ICategoryService _service;

        public CategoriesController()
        {
            _service = new CategoryService(new CategoryRespository());
        }

        public CategoriesController(ICategoryService service)
        {
            _service = service;
        }

        [Route("GetAllPaging", Name = "GetAllCategoryPagingRoute")]
        public IQueryable<CategoryDTO> GetAllPaging(int page, int pageSize)
        {
            var list = _service.GetAllPaging(page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetAllCategoryPagingRoute", new { page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetAllCategoryPagingRoute", new { page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetAllCategoryPagingRoute", new { page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetAllCategoryPagingRoute", new { page = totalPages, pageSize = pageSize }) : "";

                var paginationHeader = new
                {
                    TotalCount = totalCount,
                    TotalPages = totalPages,
                    PrevPageLink = prevLink,
                    NextPageLink = nextLink,
                    FirstPageLink = firstLink,
                    LastPageLink = lastLink
                };

                System.Web.HttpContext.Current.Response.Headers.Add("X-Pagination",
                    Newtonsoft.Json.JsonConvert.SerializeObject(paginationHeader));
            }

            return Queryable.AsQueryable(list);
        }

        [Route("GetByNamePaging", Name = "GetCategoryByNamePagingRoute")]
        public IQueryable<CategoryDTO> GetByNamePaging(string name, int page, int pageSize)
        {
            var list = _service.GetByNamePaging(name, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetCategoryByNamePagingRoute", new { name = name, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetCategoryByNamePagingRoute", new { name = name, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetCategoryByNamePagingRoute", new { name = name, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetCategoryByNamePagingRoute", new { name = name, page = totalPages, pageSize = pageSize }) : "";

                var paginationHeader = new
                {
                    TotalCount = totalCount,
                    TotalPages = totalPages,
                    PrevPageLink = prevLink,
                    NextPageLink = nextLink,
                    FirstPageLink = firstLink,
                    LastPageLink = lastLink
                };

                System.Web.HttpContext.Current.Response.Headers.Add("X-Pagination",
                    Newtonsoft.Json.JsonConvert.SerializeObject(paginationHeader));
            }

            return Queryable.AsQueryable(list);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CategoryExists(int id)
        {
            return db.Categories.Count(e => e.ID == id) > 0;
        }
    }
}