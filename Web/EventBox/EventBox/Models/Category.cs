using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventBox.Models
{
    public class Category
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public static bool operator == (Category a, Category b)
        {
            return a.ID == b.ID;
        }

        public static bool operator !=(Category a, Category b)
        {
            return !(a == b);
        }

        public override bool Equals(System.Object obj)
        {
            // If parameter is null return false.
            if (obj == null)
            {
                return false;
            }

            // If parameter cannot be cast to Point return false.
            Category p = obj as Category;
            if ((System.Object)p == null)
            {
                return false;
            }

            // Return true if the fields match:
            return this.ID == p.ID;
        }
    }
}