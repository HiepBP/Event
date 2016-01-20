//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace YTicket.API2.Models
{
    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
    using System.Runtime.Serialization;
    public partial class Event
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Event()
        {
            this.EventUsers = new HashSet<EventUser>();
            this.Categories = new HashSet<Category>();
        }
    
        public int ID { get; set; }
        public string Name { get; set; }
        public string Info { get; set; }
        public System.DateTime Time { get; set; }
        public string Place { get; set; }
        public Nullable<int> MaxAttendance { get; set; }
        public Nullable<int> RequireAttendance { get; set; }
        public Nullable<int> Vote { get; set; }
        public Nullable<decimal> Price { get; set; }
        
        [JsonIgnore]
        [IgnoreDataMember]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EventUser> EventUsers { get; set; }

        [JsonIgnore]
        [IgnoreDataMember]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Category> Categories { get; set; }
    }
}