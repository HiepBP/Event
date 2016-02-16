using System;
using System.Collections.Generic;

namespace YTicket.API2.Models.DTO
{
    public class EventDTO
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public System.DateTime Time { get; set; }
        public string Place { get; set; }
        public string Image { get; set; }
    }

    public class EventDetailDTO
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Info { get; set; }
        public System.DateTime Time { get; set; }
        public string Place { get; set; }
        public Nullable<int> MaxAttendance { get; set; }
        public Nullable<int> RequireAttendance { get; set; }
        public Nullable<int> Vote { get; set; }
        public Nullable<decimal> Price { get; set; }
        public string Image { get; set; }
        public List<Category> Categories { get; set; }
    }
}