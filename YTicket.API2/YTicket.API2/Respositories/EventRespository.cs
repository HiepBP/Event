using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Utils;

namespace YTicket.API2.Respositories
{
    public class EventRespository :
        GenericRespository<EventEntities, Event>, IEventRespository
    {
        private static int TotalResults;

        public IEnumerable<EventDTO> GetAllPaging(int pageNumber, int pageSize)
        {
            var events = Context.Events.Select(p => new EventDTO
            {
                ID = p.ID,
                Name = p.Name,
                Place = p.Place,
                Time = p.Time,
                Image = p.Image
            })
            .OrderByDescending(o => o.ID);

            TotalResults = events.Count();

            return events.ToPagedList(pageNumber, pageSize);
        }

        public IEnumerable<EventDTO> GetByCategoryPaging(Category category, int pageNumber, int pageSize)
        {
            var events = Context.Events.Where(p => p.Categories.Any(i => i.ID == category.ID))
                .Select(p => new EventDTO
                {
                    ID = p.ID,
                    Name = p.Name,
                    Place = p.Place,
                    Time = p.Time,
                    Image = p.Image
                })
                .OrderByDescending(o => o.ID);

            TotalResults = events.Count();

            return events.ToPagedList(pageNumber, pageSize);
        }

        public IEnumerable<EventDTO> GetByNameCategoryPaging(string name, Category category, int pageNumber, int pageSize)
        {
            var events = Context.Events
                .Where(p => p.Name.Contains(name) && p.Categories.Any(i => i.ID == category.ID))
                .Select(p => new EventDTO
                {
                    ID = p.ID,
                    Name = p.Name,
                    Place = p.Place,
                    Time = p.Time,
                    Image = p.Image
                })
                .OrderByDescending(o => o.ID);

            TotalResults = events.Count();

            return events.ToPagedList(pageNumber, pageSize);
        }

        public IEnumerable<EventDTO> GetByNamePaging(string name, int pageNumber, int pageSize)
        {
            var events = Context.Events.Where(p => p.Name.Contains(name))
                .Select(p => new EventDTO
                {
                    ID = p.ID,
                    Name = p.Name,
                    Time = p.Time,
                    Place = p.Place,
                    Image = p.Image
                })
                .OrderByDescending(o => o.ID);

            TotalResults = events.Count();

            return events.ToPagedList(pageNumber, pageSize);
        }

        public IEnumerable<EventDTO> GetByUserPaging(User user, int pageNumber, int pageSize)
        {
            var events = Context.Events
                .Where(p => p.EventUsers.Any(e => e.UserID == user.ID && e.RoleID == 1))
               .Select(p => new EventDTO
               {
                   ID = p.ID,
                   Name = p.Name,
                   Place = p.Place,
                   Time = p.Time,
                   Image = p.Image
               })
               .OrderByDescending(o => o.ID);

            TotalResults = events.Count();

            return events.ToPagedList(pageNumber, pageSize);
        }

        public int GetTotalResults()
        {
            return TotalResults;
        }

        public User GetMaster(Event @event)
        {
            var e = this.Get(@event.ID);
            if (e == null)
                return null;

            foreach (var item in e.EventUsers)
            {
                if (item.RoleID == 1)
                {
                    return Context.Users.Find(item.UserID);
                }
            }

            return null;
        }

        public Event CreateEvent(Event @event, User user)
        {
            ICollection<Category> categories = new List<Category>();
            foreach (var item in @event.Categories)
            {
                var category = Context.Categories.Find(item.ID);
                categories.Add(category);
            }

            @event.Categories = categories;

            EventUser eu = new EventUser
            {
                UserID = user.ID,
                RoleID = 1
            };

            @event.EventUsers.Add(eu);

            return this.Add(@event);
        }

        public Event UpdateEvent(Event @event)
        {
            ICollection<Category> categories = new List<Category>();
            foreach (var item in @event.Categories)
            {
                var category = Context.Categories.Find(item.ID);
                categories.Add(category);
            }

            @event.Categories = categories;

            var newEvent = this.Update(@event, @event.ID);

            // Deattach removed categories
            for (int i = newEvent.Categories.Count - 1 ; i >= 0; i--)
            {
                var item = newEvent.Categories.ElementAt(i);
                if (!categories.Contains(item))
                {
                    newEvent.Categories.Remove(item);
                }
            }

            // Attach new categories
            foreach (var item in categories)
            {
                if (!newEvent.Categories.Contains(item))
                {
                    newEvent.Categories.Add(item);
                }
            }

            // save modified event
            Context.Entry(newEvent).State = EntityState.Modified;
            Context.SaveChanges();
            return newEvent;
        }

        public void DeleteEvent(Event @event)
        {
            // explicity delete
            for (int i = @event.Categories.Count() -1; i >= 0; i--)
            {
                var category = @event.Categories.ElementAt(i);
                @event.Categories.Remove(category);
            }

            this.Delete(@event);
        }

        public void JoinEvent(Event @event, User user)
        {
            EventUser eu = new EventUser
            {
                UserID = user.ID,
                RoleID = 3,
                EventID = @event.ID
            };

            @event.EventUsers.Add(eu);

            this.Update(@event, @event.ID);
        }

        public void LeaveEvent(Event @event, User user)
        {
            for (int i = @event.EventUsers.Count() - 1; i >= 0; i--)
            {
                var eu = @event.EventUsers.ElementAt(i);
                if (eu.UserID == user.ID)
                {
                    @event.EventUsers.Remove(eu);
                }
            }

            this.Update(@event, @event.ID);
        }
    }

    public interface IEventRespository : IGenericRespository<Event>
    {
        IEnumerable<EventDTO> GetAllPaging(int pageNumber,int pageSize);
        IEnumerable<EventDTO> GetByNamePaging(string name, int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByCategoryPaging(Category category , int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByUserPaging(User user, int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByNameCategoryPaging(string name, Category category, int pageNumber, int pageSize);
        User GetMaster(Event @event);
        Event CreateEvent(Event @event, User user);
        Event UpdateEvent(Event @event);
        void DeleteEvent(Event @event);
        void JoinEvent(Event @event, User user);
        void LeaveEvent(Event @event, User user);
        int GetTotalResults();
    }
}