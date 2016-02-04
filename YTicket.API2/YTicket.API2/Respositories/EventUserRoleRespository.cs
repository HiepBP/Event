using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YTicket.API2.Models;

namespace YTicket.API2.Respositories
{
    public class EventUserRoleRespository :
        GenericRespository<EventEntities, EventUserRole>, IEventUserRoleRespository
    {
    }

    public interface IEventUserRoleRespository : IGenericRespository<EventUserRole>
    {

    }
}