using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventBox.Models
{
    public class Event
    {
        public Event(int id, string name, System.DateTime time, string place,string image)
        {
            ID = id;
            Name = name;
            Time = time;
            Place = place;
            Image = image;
        }

        public Event()
        {

        }

        public int ID { get; set; }
        public string Name { get; set; }
        public System.DateTime Time { get; set; }
        public string Place { get; set; }
        public string Image { get; set; }
    }

    public class EventDetail
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