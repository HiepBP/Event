using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YTicket.API2.Models
{
    public interface IValidationDictionary
    {
        void AddErrors(string key, string errorMessage);
        bool IsValid { get; }
    }
}