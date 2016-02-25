using AttributeRouting.Web.Mvc;
using EventBox.Helper;
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
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/GetAllPaging?page=1&pageSize=12");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            var Pagination = httpResponse.Headers["X-Pagination"];
            JObject json = JObject.Parse(Pagination);
            ViewData["PrevPage"] = Server.UrlEncode((string)json["PrevPageLink"]);
            ViewData["NextPage"] = Server.UrlEncode((string)json["NextPageLink"]);
            ViewData["FirstPage"] = Server.UrlEncode((string)json["FirstPageLink"]);
            ViewData["LastPage"] = Server.UrlEncode((string)json["LastPageLink"]);
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
                string Image = (string)i["Image"];
                e = new Event(ID, Name, Time, Place, Image);
                events.Add(e);
            }
            //var tmp = DependencyResolver.Current.GetService<EventBox.Controllers.UsersController>();
            //var result = tmp.GetNotification();
            
            ViewData["Events"] = events;
            return View();
        }


        /// <summary>
        /// Redirect to other page base on url
        /// </summary>
        /// <param name="url">Next page url</param>
        /// <returns></returns>
        [Route("Index/Paging")]
        public ViewResult Paging(string url)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(Server.UrlDecode(url));
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            var Pagination = httpResponse.Headers["X-Pagination"];
            JObject json = JObject.Parse(Pagination);
            ViewData["PrevPage"] = Server.UrlEncode((string)json["PrevPageLink"]);
            ViewData["NextPage"] = Server.UrlEncode((string)json["NextPageLink"]);
            ViewData["FirstPage"] = Server.UrlEncode((string)json["FirstPageLink"]);
            ViewData["LastPage"] = Server.UrlEncode((string)json["LastPageLink"]);
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
                string Image = (string)i["Image"];
                e = new Event(ID, Name, Time, Place, Image);
                events.Add(e);
            }
            ViewData["Events"] = events;
            return View("~/Views/Home/Index.cshtml");
        }
    }
}
