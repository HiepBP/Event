using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventBox.Models
{
    public class Notification
    {
        public int ID { get; set; }
        public string Information { get; set; }
        public bool New { get; set; }
    }
}