using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YTicket.API2.DTO
{
    public class NotificationDTO
    {
        public int ID { get; set; }
        public string Information { get; set; }
        public bool New { get; set; }
    }
}