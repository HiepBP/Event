using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YTicket.API2.Models;

namespace YTicket.API2.Respositories
{
    public class EventUserRespository :
        GenericRespository<EventEntities, EventUser>, IEventUserRespository
    {
    }

    public interface IEventUserRespository : IGenericRespository<EventUser>
    {

    }
}