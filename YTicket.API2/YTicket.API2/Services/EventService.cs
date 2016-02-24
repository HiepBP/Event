using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Respositories;

namespace YTicket.API2.Services
{
    public class EventService : IEventService
    {
        private IEventRespository _respository;
        private ICategoryRespository _categoryRespository;
        private IUserRespository _userRespository;
        private IValidationDictionary _validationDictionary;
        private INotificationRespository _notificationRespository;

        private static int TotalResults;

        public EventService(IValidationDictionary validationDictionary, IEventRespository respository,
            ICategoryRespository categoryRespository, IUserRespository userRespository, 
            INotificationRespository notificationRespository)
        {
            _respository = respository;
            _categoryRespository = categoryRespository;
            _userRespository = userRespository;
            _validationDictionary = validationDictionary;
            _notificationRespository = notificationRespository;
        }

        public IEnumerable<EventDTO> GetAllPaging(int pageNumber, int pageSize)
        {
            var list = _respository.GetAllPaging(pageNumber, pageSize);
            TotalResults = _respository.GetTotalResults();
            return list;
        }

        public IEnumerable<EventDTO> GetByCategoryPaging(int categoryID, int pageNumber, int pageSize)
        {
            Category category = _categoryRespository.Get(categoryID);
            if (category == null)
            {
                return null;
            }
            else
            {
                var list = _respository.GetByCategoryPaging(category, pageNumber, pageSize);
                TotalResults = _respository.GetTotalResults();
                return list;
            }
        }

        public IEnumerable<EventDTO> GetByNameCategoryPaging(string name, int categoryID, int pageNumber, int pageSize)
        {
            Category category = _categoryRespository.Get(categoryID);
            if (category == null)
            {
                return null;
            }
            else
            {
                var list = _respository.GetByNameCategoryPaging(name, category, pageNumber, pageSize);
                TotalResults = _respository.GetTotalResults();
                return list;
            }
        }

        public IEnumerable<EventDTO> GetByNamePaging(string name, int pageNumber, int pageSize)
        {
            var list = _respository.GetByNamePaging(name, pageNumber, pageSize);
            TotalResults = _respository.GetTotalResults();
            return list;
        }

        public IEnumerable<EventDTO> GetByUserPaging(int userID, int pageNumber, int pageSize)
        {
            User user = _userRespository.Get(userID);
            if (user == null)
            {
                return null;
            }
            else
            {
                var list = _respository.GetByUserPaging(user, pageNumber, pageSize);
                TotalResults = _respository.GetTotalResults();
                return list;
            }
        }

        public IEnumerable<UserDTO> GetJoinedUserPaging(int id, int pageNumber, int pageSize)
        {
            var @event = _respository.Get(id);
            if(@event == null)
            {
                return null;
            }
            else
            {
                var list = _userRespository.GetJoinedUserPaging(@event, pageNumber, pageSize);
                TotalResults = _userRespository.GetTotalResults();
                return list;
            }
        }

        public EventDetailDTO GetEventDetail(int id)
        {
            var @event = _respository.Get(id);
            if (@event == null)
            {
                return null;
            }
            else
            {
                return new EventDetailDTO
                {
                    ID = @event.ID,
                    Name = @event.Name,
                    Time = @event.Time,
                    Place = @event.Place,
                    Info = @event.Info,
                    Price = @event.Price,
                    MaxAttendance = @event.MaxAttendance,
                    Categories = @event.Categories.ToList(),
                    RequireAttendance = @event.RequireAttendance,
                    Vote = @event.Vote,
                    Image = @event.Image
                };
            }
        }

        public async Task<EventDetailDTO> GetEventDetailAsync(int id)
        {
            var @event = await _respository.GetAsync(id);
            if (@event == null)
            {
                return null;
            }
            else
            {
                return new EventDetailDTO
                {
                    ID = @event.ID,
                    Name = @event.Name,
                    Time = @event.Time,
                    Place = @event.Place,
                    Info = @event.Info,
                    Price = @event.Price,
                    MaxAttendance = @event.MaxAttendance,
                    Categories = @event.Categories.ToList(),
                    RequireAttendance = @event.RequireAttendance,
                    Vote = @event.Vote,
                    Image = @event.Image
                };
            }
        }

        protected bool ValidateEvent(Event @event)
        {
            // Validate Name
            if (@event.Name.Trim().Length == 0)
                _validationDictionary.AddErrors("Name", "Name cannot be blank.");
            else if (@event.Name.Trim().Length > 50)
                _validationDictionary.AddErrors("Name", "Name cannot exceed 50 characters.");
            // Validate Info
            if (@event.Info.Trim().Length == 0)
                _validationDictionary.AddErrors("Info", "Info cannot be blank.");
            else if (@event.Info.Trim().Length > 150)
                _validationDictionary.AddErrors("Info", "Info cannot exceed 150 characters.");
            // Validate Time
            if (@event.Time == null)
                _validationDictionary.AddErrors("Time", "Time cannot be blank.");
            else if (@event.Time.CompareTo(DateTime.Today.AddDays(1)) < 0)
                _validationDictionary.AddErrors("Time", "Time is not valid.");
            // Validate Place
            if (@event.Place.Trim().Length == 0)
                _validationDictionary.AddErrors("Place", "Place cannot be blank.");
            else if (@event.Place.Trim().Length > 50)
                _validationDictionary.AddErrors("Place", "Place cannot exceed 50 characters.");
            // Validate MaxAttendance
            if (@event.MaxAttendance != null && @event.MaxAttendance < 0)
                _validationDictionary.AddErrors("MaxAttendance", "Max Attendance cannot be negative");
            // Validate RequireAttendance
            if (@event.RequireAttendance != null && @event.RequireAttendance < 0)
                _validationDictionary.AddErrors("RequireAttendance", "Required Attendance cannot be negative");
            // Validate MaxAttendance and RequireAttendance
            if (@event.RequireAttendance != null && @event.MaxAttendance != null
                && @event.MaxAttendance < @event.RequireAttendance)
                _validationDictionary.AddErrors("MaxAttendance", "Max Attendance cannot be less than Required Attendance");
            // Validate Vote
            if (@event.Vote != null && @event.Vote < 0)
                _validationDictionary.AddErrors("Vote", "Vote cannot be negative");
            // Validate Price
            if (@event.Price != null && @event.Price < 0)
                _validationDictionary.AddErrors("Price", "Price cannot be negative");
            // Validate Image

            // Validate Categories
            foreach (var item in @event.Categories)
            {
                var category = _categoryRespository.Get(item.ID);
                if (category == null)
                {
                    _validationDictionary.AddErrors("Categories", "Category is not valid");
                    break;
                }
            }

            return _validationDictionary.IsValid;
        }

        public bool GetEventUserStatus(int id, string username)
        {
            var @event = _respository.Get(id);
            var user = _userRespository.GetByUsername(username);
            foreach (var item in @event.EventUsers)
            {
                if (item.UserID == user.ID)
                    return true;
            }
            return false;
        }

        public async Task<bool> GetEventUserStatusAsync(int id, string username)
        {
            var @event = await _respository.GetAsync(id);
            var user = await _userRespository.GetByUsernameAsync(username);
            foreach (var item in @event.EventUsers)
            {
                if (item.UserID == user.ID)
                    return true;
            }
            return false;
        }

        public bool CreateEvent(Event @event, string username)
        {
            // Validate logic
            if (!ValidateEvent(@event))
                return false;

            // Database logic
            try
            {
                var user = _userRespository.GetByUsername(username);
                _respository.CreateEvent(@event, user);
            }
            catch
            {
                return false;
            }
            return true;
        }

        public async Task<bool> CreateEventAsync(Event @event, string username)
        {
            // Validate logic
            if (!ValidateEvent(@event))
                return false;

            // Database logic
            try
            {
                var user = await _userRespository.GetByUsernameAsync(username);
                await _respository.CreateEventAsync(@event, user);
            }
            catch
            {
                return false;
            }
            return true;
        }

        public bool UpdateEvent(Event @event, string username)
        {
            // Validate not found
            var e = _respository.Get(@event.ID);
            if (e == null)
            {
                _validationDictionary.AddErrors("Event", "Not found");
                return false;
            }

            // Validate authorization
            var user = _respository.GetMaster(@event);
            if (!user.Username.Trim().Equals(username.Trim()))
            {
                _validationDictionary.AddErrors("Authorization", "User does not have permission.");
                return false;
            }

            // Validate logic
            if (!ValidateEvent(@event))
                return false;

            // Database logic
            try
            {
                e = _respository.UpdateEvent(@event);
            }
            catch
            {
                return false;
            }

            //Create notification
            var list = _userRespository.GetJoinedUser(e);
            foreach (var item in list)
            {
                User u = new User
                {
                    ID = item.ID
                };
                _notificationRespository.CreateNotification(u, "Hey guess what!!! " + e.Name + " has been updated, check it out now!");
            }

            return true;
        }

        public async Task<bool> UpdateEventAsync(Event @event, string username)
        {
            // Validate not found
            var e = await _respository.GetAsync(@event.ID);
            if (e == null)
            {
                _validationDictionary.AddErrors("Event", "Not found");
                return false;
            }

            // Validate authorization
            var user = await _respository.GetMasterAsync(@event);
            if (!user.Username.Trim().Equals(username.Trim()))
            {
                _validationDictionary.AddErrors("Authorization", "User does not have permission.");
                return false;
            }

            // Validate logic
            if (!ValidateEvent(@event))
                return false;

            // Database logic
            try
            {
                await _respository.UpdateEventAsync(@event);
            }
            catch
            {
                return false;
            }

            //Create notification
            var list = _userRespository.GetJoinedUser(e);
            foreach (var item in list)
            {
                User u = new User
                {
                    ID = item.ID
                };
                await _notificationRespository.CreateNotificationAsync(u, "Hey guess what!!! " + e.Name + " has been updated, check it out now!");
            }

            return true;
        }

        public bool DeleteEvent(int id, string username)
        {
            // Validate not found
            var @event = _respository.Get(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }

            // Validate authorization
            var user = _respository.GetMaster(@event);
            if (!user.Username.Trim().Equals(username.Trim()))
            {
                _validationDictionary.AddErrors("Authorization", "User does not have permission.");
                return false;
            }

            var l = _userRespository.GetJoinedUser(@event);

            List<User> list = new List<User>();

            foreach (var item in l)
            {
                User u = new User
                {
                    ID = item.ID
                };
                list.Add(u);
            }

            // Database logic
            try
            {
                _respository.DeleteEvent(@event);
            }
            catch
            {
                return false;
            }

            //Create notification
            foreach (var item in list)
            {
                User u = new User
                {
                    ID = item.ID
                };
                _notificationRespository.CreateNotification(u, "It's too bad!!! " + @event.Name + " has been cancelled.");
            }

            return true;
        }

        public async Task<bool> DeleteEventAsync(int id, string username)
        {
            // Validate not found
            var @event = await _respository.GetAsync(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }

            // Validate authorization
            var user = await _respository.GetMasterAsync(@event);
            if (!user.Username.Trim().Equals(username.Trim()))
            {
                _validationDictionary.AddErrors("Authorization", "User does not have permission.");
                return false;
            }

            var l = _userRespository.GetJoinedUser(@event);

            List<User> list = new List<User>();

            foreach (var item in l)
            {
                User u = new User
                {
                    ID = item.ID
                };
                list.Add(u);
            }

            // Database logic
            try
            {
                await _respository.DeleteEventAsync(@event);
            }
            catch
            {
                return false;
            }

            //Create notification
            foreach (var item in list)
            {
                User u = new User
                {
                    ID = item.ID
                };
                _notificationRespository.CreateNotification(u, "It's too bad!!! " + @event.Name + " has been cancelled.");
            }

            return true;
        }

        public bool JoinEvent(int id, string username)
        {
            var @event = _respository.Get(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }
            var user = _userRespository.GetByUsername(username);

            _respository.JoinEvent(@event, user);

            return true;
        }

        public async Task<bool> JoinEventAsync(int id, string username)
        {
            var @event = await _respository.GetAsync(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }
            var user = await _userRespository.GetByUsernameAsync(username);

            await _respository.JoinEventAsync(@event, user);

            return true;
        }

        public bool LeaveEvent(int id, string username)
        {
            var @event = _respository.Get(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }
            var user = _userRespository.GetByUsername(username);

            _respository.LeaveEvent(@event, user);

            return true;
        }

        public async Task<bool> LeaveEventAsync(int id, string username)
        {
            var @event = await _respository.GetAsync(id);
            if (@event == null)
            {
                _validationDictionary.AddErrors("Event", "Not found.");
                return false;
            }
            var user = await _userRespository.GetByUsernameAsync(username);

            await _respository.LeaveEventAsync(@event, user);

            return true;
        }

        public int Count()
        {
            return _respository.Count();
        }

        public int GetTotalResults()
        {
            return TotalResults;
        }

    }

    public interface IEventService
    {
        IEnumerable<EventDTO> GetAllPaging(int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByNamePaging(string name, int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByCategoryPaging(int categoryID, int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByUserPaging(int userID, int pageNumber, int pageSize);
        IEnumerable<EventDTO> GetByNameCategoryPaging(string name, int categoryID, int pageNumber, int pageSize);
        IEnumerable<UserDTO> GetJoinedUserPaging(int id, int pageNumber, int pageSize);
        EventDetailDTO GetEventDetail(int id);
        Task<EventDetailDTO> GetEventDetailAsync(int id);
        bool GetEventUserStatus(int id, string username);
        Task<bool> GetEventUserStatusAsync(int id, string username);
        bool CreateEvent(Event @event, string username);
        Task<bool> CreateEventAsync(Event @event, string username);
        bool UpdateEvent(Event @event, string username);
        Task<bool> UpdateEventAsync(Event @event, string username);
        bool DeleteEvent(int id, string username);
        Task<bool> DeleteEventAsync(int id, string username);
        bool JoinEvent(int id, string username);
        Task<bool> JoinEventAsync(int id, string username);
        bool LeaveEvent(int id, string username);
        Task<bool> LeaveEventAsync(int id, string username);
        int GetTotalResults();
        int Count();
    }
}