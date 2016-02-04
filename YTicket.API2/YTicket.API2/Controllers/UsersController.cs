using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Http.Routing;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Respositories;
using YTicket.API2.Services;

namespace YTicket.API2.Controllers
{
    [RoutePrefix("api/Users")]
    public class UsersController : ApiController
    {
        private EventEntities db = new EventEntities();
        private IUserService _service;

        public UsersController()
        {
            _service = new UserService(new ModelStateWrapper(this.ModelState),
                new UserRespository(), new CategoryRespository());
        }
        
        public UsersController(IUserService service)
        {
            _service = service;
        }

        [Route("GetAllPaging", Name = "GetAllUserPagingRoute")]
        public IQueryable<UserDTO> GetAllPaging(int page, int pageSize)
        {
            var list = _service.GetAllPaging(page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetAllUserPagingRoute", new { page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetAllUserPagingRoute", new { page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetAllUserPagingRoute", new { page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetAllUserPagingRoute", new { page = totalPages, pageSize = pageSize }) : "";

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

        [Route("GetByNamePaging", Name = "GetUserByNamePagingRoute")]
        public IQueryable<UserDTO> GetByNamePaging(string name, int page, int pageSize)
        {
            var list = _service.GetByNamePaging(name, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetUserByNamePagingRoute", new { name = name, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetUserByNamePagingRoute", new { name = name, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetUserByNamePagingRoute", new { name = name, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetUserByNamePagingRoute", new { name = name, page = totalPages, pageSize = pageSize }) : "";

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

        [Route("GetUserDetail")]
        public async Task<IHttpActionResult> GetUserDetail(int id)
        {
            var user = _service.GetUserDetail(id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [Authorize]
        [ResponseType(typeof(Event))]
        [HttpPut]
        [Route("UpdateUser", Name = "UpdateUserRoute")]
        public async Task<IHttpActionResult> UpdateUser(int id, User user)
        {
            if (id != user.ID)
            {
                return BadRequest();
            }

            if (!_service.UpdateUser(user, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool UserExists(int id)
        {
            return db.Users.Count(e => e.ID == id) > 0;
        }
    }
}