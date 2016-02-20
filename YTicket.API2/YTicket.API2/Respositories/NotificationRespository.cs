using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using YTicket.API2.DTO;
using YTicket.API2.Models;

namespace YTicket.API2.Respositories
{
    public class NotificationRespository :
        GenericRespository<EventEntities, Notification>, INotificationRespository
    {
        public Notification CreateNotification(User user, string message)
        {
            var u = Context.Users.Find(user.ID);
            if (u == null)
                return null;

            Notification noti = new Notification
            {
                Information = message,
                UserID = user.ID,
                New = true
            };

            return this.Add(noti);
        }

        public async Task<Notification> CreateNotificationAsync(User user, string message)
        {
            var u = await Context.Users.FindAsync(user.ID);
            if (u == null)
                return null;

            Notification noti = new Notification
            {
                Information = message,
                UserID = user.ID,
                New = true
            };

            return await this.AddAsync(noti);
        }

        public IEnumerable<NotificationDTO> GetAllByUser(User user)
        {
            var notifications = Context.Notifications.Where(p => p.UserID == user.ID)
                .Select(p => new NotificationDTO
                {
                    ID = p.ID,
                    Information = p.Information,
                    New = p.New
                })
            .OrderByDescending(o => o.ID);

            return notifications;
        }
    }

    public interface INotificationRespository : IGenericRespository<Notification>
    {
        IEnumerable<NotificationDTO> GetAllByUser(User user);
        Notification CreateNotification(User user, string message);
        Task<Notification> CreateNotificationAsync(User user, string message);
    }
}