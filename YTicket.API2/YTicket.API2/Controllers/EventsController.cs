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
    [RoutePrefix("api/Events")]
    public class EventsController : ApiController
    {
        private EventEntities db = new EventEntities();
        private IEventService _service;

        public EventsController()
        {
            _service = new EventService(new ModelStateWrapper(this.ModelState),
                new EventRespository(), new CategoryRespository(), new UserRespository(),
                new NotificationRespository());
        }

        public EventsController(IEventService service)
        {
            _service = service;
        }

        /// <summary>
        /// Returns all events with paging and newest first.
        /// Event Collection contains basic DTO: ID, Name, Time, Place, Image.
        /// </summary>
        /// <param name="page">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetAllPaging", Name = "GetAllPagingRoute")]
        public IQueryable<EventDTO> GetAllPaging(int page, int pageSize)
        {
            var list = _service.GetAllPaging(page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetAllPagingRoute", new { page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetAllPagingRoute", new { page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetAllPagingRoute", new { page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetAllPagingRoute", new { page = totalPages, pageSize = pageSize }) : "";

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

        /// <summary>
        /// Returns all events that match name keyword with paging and newest first.
        /// Event Collection contains basic DTO: ID, Name, Time, Place, Image.
        /// </summary>
        /// <param name="name">keyword user to search</param>
        /// <param name="pageNumber">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetByNamePaging", Name = "GetByNamePagingRoute")]
        public IQueryable<EventDTO> GetByNamePaging(string name, int page, int pageSize)
        {
            var list = _service.GetByNamePaging(name, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetByNamePagingRoute", new { name = name, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetByNamePagingRoute", new { name = name, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetByNamePagingRoute", new { name = name, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetByNamePagingRoute", new { name = name, page = totalPages, pageSize = pageSize }) : "";

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

        /// <summary>
        /// Returns all events of the requited category with paging and newest first.
        /// Event Collection contains basic DTO: ID, Name, Time, Place, Image.
        /// </summary>
        /// <param name="categoryID">id of category</param>
        /// <param name="pageNumber">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetByCategoryPaging", Name = "GetByCategoryPagingRoute")]
        public IQueryable<EventDTO> GetByCategoryPaging(int categoryID, int page, int pageSize)
        {
            var list = _service.GetByCategoryPaging(categoryID, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetByCategoryPagingRoute", new { categoryID = categoryID, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetByCategoryPagingRoute", new { categoryID = categoryID, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetByCategoryPagingRoute", new { categoryID = categoryID, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetByCategoryPagingRoute", new { categoryID = categoryID, page = totalPages, pageSize = pageSize }) : "";

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

        /// <summary>
        /// Returns all events created by the required user with paging and newest first.
        /// Event Collection contains basic DTO: ID, Name, Time, Place, Image.
        /// </summary>
        /// <param name="userID">id of user</param>
        /// <param name="pageNumber">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetByUserPaging", Name = "GetByUserPagingRoute")]
        public IQueryable<EventDTO> GetByUserPaging(int userID, int pageNumber, int pageSize)
        {
            // TODO
            return Queryable.AsQueryable(_service.GetByUserPaging(userID, pageNumber, pageSize));
        }

        /// <summary>
        /// Returns all events of the requited category that match name keyword 
        /// with paging and newest first.
        /// Event Collection contains basic DTO: ID, Name, Time, Place, Image.
        /// </summary>
        /// <param name="name">name keyword</param>
        /// <param name="categoryID">id of category</param>
        /// <param name="pageNumber">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetByNameCategoryPaging", Name = "GetByNameCategoryPagingRoute")]
        public IQueryable<EventDTO> GetByNameCategoryPaging(string name, int categoryID, int page, int pageSize)
        {
            var list = _service.GetByNameCategoryPaging(name, categoryID, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetByNameCategoryPagingRoute", new { name = name, categoryID = categoryID, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetByNameCategoryPagingRoute", new { name = name, categoryID = categoryID, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetByNameCategoryPagingRoute", new { name = name, categoryID = categoryID, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetByNameCategoryPagingRoute", new { name = name, categoryID = categoryID, page = totalPages, pageSize = pageSize }) : "";

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

        /// <summary>
        /// Returns all users that going to the required event.
        /// User Collection contains basic DTO: ID, Username, Image.
        /// </summary>
        /// <param name="id">id of event</param>
        /// <param name="page">page number</param>
        /// <param name="pageSize">items per page</param>
        /// <returns></returns>
        [Route("GetJoinedUserPaging", Name = "GetJoinedUserPagingRoute")]
        public IQueryable<UserDTO> GetJoinedUserPaging(int id, int page, int pageSize)
        {
            var list = _service.GetJoinedUserPaging(id, page, pageSize);

            if (list != null)
            {
                var totalCount = _service.GetTotalResults();
                var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                var urlHelper = new UrlHelper(Request);
                var prevLink = page > 1 ? urlHelper.Link("GetJoinedUserPagingRoute", new { id = id, page = page - 1, pageSize = pageSize }) : "";
                var nextLink = page < totalPages - 1 ? urlHelper.Link("GetJoinedUserPagingRoute", new { id = id, page = page + 1, pageSize = pageSize }) : "";
                var firstLink = page != 1 ? urlHelper.Link("GetJoinedUserPagingRoute", new { id = id, page = 1, pageSize = pageSize }) : "";
                var lastLink = page != totalPages ? urlHelper.Link("GetJoinedUserPagingRoute", new { id = id, page = totalPages, pageSize = pageSize }) : "";

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

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Returns an object to show if the user joined the event or not.
        /// The object contains: Status (true, false), Action (Leave event, Join event).
        /// </summary>
        /// <param name="id">id of event</param>
        /// <returns></returns>
        [Authorize]
        [Route("GetEventUserStatus", Name = "GetEventUserStatusRoute")]
        public async Task<IHttpActionResult> GetEventUserStatus(int id)
        {
            var urlHelper = new UrlHelper(Request);
            var model = new
            {
                Status = false,
                Action = ""
            };
            if (await _service.GetEventUserStatusAsync(id, User.Identity.Name))
            {
                model = new
                {
                    Status = true,
                    Action = urlHelper.Link("LeaveEventRoute", new { id = id})
                };
            }
            else
            {
                model = new
                {
                    Status = false,
                    Action = urlHelper.Link("JoinEventRoute", new { id = id })
                };
            }
            return Ok(model);
        }

        /// <summary>
        /// Returns an individual Event.
        /// Event contains detail DTO: ID, Name, Info, Time, Place, MaxAttendance, 
        /// RequiredAttendance, Vote, Price, Image, Categories.
        /// </summary>
        /// <param name="id">id of event</param>
        /// <returns></returns>
        [Route("GetEventDetail")]
        public async Task<IHttpActionResult> GetEventDetail(int id)
        {
            var @event = await _service.GetEventDetailAsync(id);
            if (@event == null)
            {
                return NotFound();
            }

            return Ok(@event);
        }

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Updates an individual Event.
        /// Event contains detail DTO: ID, Name, Info, Time, Place, MaxAttendance, 
        /// RequiredAttendance, Vote, Price, Image, Categories.
        /// </summary>
        /// <param name="id">id of Event</param>
        /// <param name="event">the event object</param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(Event))]
        [HttpPut]
        [Route("UpdateEvent", Name = "UpdateEventRoute")]
        public async Task<IHttpActionResult> UpdateEvent(int id, Event @event)
        {
            if (id != @event.ID)
            {
                return BadRequest();
            }

            if (! await _service.UpdateEventAsync(@event, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Create a new Event.
        /// Event contains detail DTO: Name, Info, Time, Place, MaxAttendance, 
        /// RequiredAttendance, Vote, Price, Image, Categories.
        /// </summary>
        /// <param name="event">the event object</param>
        /// <returns></returns>
        [Authorize]
        [ResponseType(typeof(Event))]
        [HttpPost]
        [Route("CreateEvent", Name = "CreateEventRoute")]
        public async Task<IHttpActionResult> CreateEvent(Event @event)
        {
            if (! await _service.CreateEventAsync(@event, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }
            return CreatedAtRoute("CreateEventRoute", new { id = @event.ID }, @event);
        }

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Deletes an individual Event.
        /// </summary>
        /// <param name="id">id of event</param>
        /// <returns></returns>
        [Authorize]
        [HttpDelete]
        [Route("DeleteEvent", Name = "DeleteEventRoute")]
        public async Task<IHttpActionResult> DeleteEvent(int id)
        {
            if(! await _service.DeleteEventAsync(id, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }

            return Ok();
        }

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Adds current user to event.
        /// </summary>
        /// <param name="id">id of event</param>
        /// <returns></returns>
        [Authorize]
        [HttpPut]
        [Route("JoinEvent", Name = "JoinEventRoute")]
        public async Task<IHttpActionResult> JoinEvent(int id)
        {
            if (! await _service.JoinEventAsync(id, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }
            return Ok();
        }

        /// <summary>
        /// Authorize action, the request header need bearer authorization token.
        /// Remove current user from event.
        /// </summary>
        /// <param name="id">id of event</param>
        /// <returns></returns>
        [Authorize]
        [HttpPut]
        [Route("LeaveEvent", Name = "LeaveEventRoute")]
        public async Task<IHttpActionResult> LeaveEvent(int id)
        {
            if (!await _service.LeaveEventAsync(id, User.Identity.Name))
            {
                return BadRequest(ModelState);
            }
            return Ok();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool EventExists(int id)
        {
            return db.Events.Count(e => e.ID == id) > 0;
        }
    }
}