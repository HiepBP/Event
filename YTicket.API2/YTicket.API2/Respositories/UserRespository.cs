using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Utils;

namespace YTicket.API2.Respositories
{
    public class UserRespository :
        GenericRespository<EventEntities, User>, IUserRespository
    {
        private static int TotalResults;

        public IEnumerable<UserDTO> GetAllPaging(int pageNumber, int pageSize)
        {
            var users = Context.Users.Select(p => new UserDTO
            {
                ID = p.ID,
                Image = p.Image,
                Username = p.Username
            })
            .OrderBy(o => o.ID);

            TotalResults = users.Count();

            return users.ToPagedList(pageNumber, pageSize);
        }

        public User GetByEvent(int eventId)
        {
            throw new NotImplementedException();
        }

        public Task<User> GetByEventAsync(int eventId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<UserDTO> GetByNamePaging(string name, int pageNumber, int pageSize)
        {
            var users = Context.Users.Where(p => p.Username.Contains(name))
                .Select(p => new UserDTO
                {
                    ID = p.ID,
                    Image = p.Image,
                    Username = p.Username
                })
                .OrderBy(o => o.ID);

            TotalResults = users.Count();

            return users.ToPagedList(pageNumber, pageSize);
        }

        public User GetByUsername(string username)
        {
            var user = Context.Users
                .Where(p => p.Username == username)
                .SingleOrDefault();

            return user;
        }

        public async Task<User> GetByUsernameAsync(string username)
        {
            var user = await Context.Users
                .Where(p => p.Username == username)
                .SingleOrDefaultAsync();

            return user;
        }

        public IEnumerable<UserDTO> GetJoinedUser(Event @event)
        {
            var users = Context.Users
                .Where(p => p.EventUsers.Any(i => i.EventID == @event.ID && i.RoleID == 3))
                .Select(p => new UserDTO
                {
                    ID = p.ID,
                    Username = p.Username,
                    Image = p.Image
                })
                .OrderBy(o => o.ID);

            TotalResults = users.Count();

            return users;
        }

        public IEnumerable<UserDTO> GetJoinedUserPaging(Event @event, int pageNumber, int pageSize)
        {
            var users = Context.Users
                .Where(p => p.EventUsers.Any(i => i.EventID == @event.ID && i.RoleID == 3))
                .Select(p => new UserDTO
                {
                    ID = p.ID,
                    Username = p.Username,
                    Image = p.Image
                })
                .OrderBy(o => o.ID);

            TotalResults = users.Count();

            return users.ToPagedList(pageNumber, pageSize);
        }

        public int GetTotalResults()
        {
            return TotalResults;
        }

        public User UpdateUser(User user)
        {
            ICollection<Category> categories = new List<Category>();
            foreach (var item in user.Categories)
            {
                var category = Context.Categories.Find(item.ID);
                categories.Add(category);
            }

            user.Categories = categories;

            var newUser = this.Update(user, user.ID);

            // Deattach removed categories
            for (int i = newUser.Categories.Count - 1; i >= 0; i--)
            {
                var item = newUser.Categories.ElementAt(i);
                if (!categories.Contains(item))
                {
                    newUser.Categories.Remove(item);
                }
            }

            // Attach new categories
            foreach (var item in categories)
            {
                if (!newUser.Categories.Contains(item))
                {
                    newUser.Categories.Add(item);
                }
            }

            // save modified event
            Context.Entry(newUser).State = EntityState.Modified;
            Context.SaveChanges();
            return newUser;
        }

        public async Task<User> UpdateUserAsync(User user)
        {
            ICollection<Category> categories = new List<Category>();
            foreach (var item in user.Categories)
            {
                var category = await Context.Categories.FindAsync(item.ID);
                categories.Add(category);
            }

            user.Categories = categories;

            var newUser = await this.UpdateAsync(user, user.ID);

            // Deattach removed categories
            for (int i = newUser.Categories.Count - 1; i >= 0; i--)
            {
                var item = newUser.Categories.ElementAt(i);
                if (!categories.Contains(item))
                {
                    newUser.Categories.Remove(item);
                }
            }

            // Attach new categories
            foreach (var item in categories)
            {
                if (!newUser.Categories.Contains(item))
                {
                    newUser.Categories.Add(item);
                }
            }

            // save modified event
            Context.Entry(newUser).State = EntityState.Modified;
            await Context.SaveChangesAsync();
            return newUser;
        }
    }

    public interface IUserRespository : IGenericRespository<User>
    {
        IEnumerable<UserDTO> GetAllPaging(int pageNumber, int pageSize);
        IEnumerable<UserDTO> GetByNamePaging(string name, int pageNumber, int pageSize);
        IEnumerable<UserDTO> GetJoinedUser(Event curEvent);
        IEnumerable<UserDTO> GetJoinedUserPaging(Event curEvent, int pageNumber, int pageSize);
        User GetByUsername(string username);
        Task<User> GetByUsernameAsync(string username);
        User UpdateUser(User user);
        Task<User> UpdateUserAsync(User user);
        int GetTotalResults();
    }
}