using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YTicket.API2.Models.DTO
{
    public class UserDTO
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Image { get; set; }
    }

    public class UserDetailDTO
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