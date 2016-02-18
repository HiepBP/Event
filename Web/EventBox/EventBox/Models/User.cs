using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventBox.Models
{
    public class User
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Image { get; set; }
    }

    public class UserDetail
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Image { get; set; }
        public List<Category> Categories { get; set; }
    }
}