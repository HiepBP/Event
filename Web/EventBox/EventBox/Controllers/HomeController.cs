using AttributeRouting.Web.Mvc;
using EventBox.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace EventBox.Controllers
{
    public class HomeController : Controller
    {
        [Route("Index/Home")]
        public ViewResult Index()
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/GetAllPaging?page=1&pageSize=9");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream rebut = httpResponse.GetResponseStream();
            StreamReader readStream = new StreamReader(rebut, Encoding.UTF8);
            string info = readStream.ReadToEnd();
            var arr = JsonConvert.DeserializeObject<JArray>(info);
            Event e = new Event();
            List<Event> events = new List<Event>();
            foreach (JObject i in arr)
            {
                int ID = (int)i["ID"];
                string Name = (string)i["Name"];
                System.DateTime Time = (System.DateTime)i["Time"];
                string Place = (string)i["Place"];
                e = new Event(ID, Name, Time, Place);
                events.Add(e);
            }
            ViewData["Events"] = events;
            return View();
        }
    }
}
