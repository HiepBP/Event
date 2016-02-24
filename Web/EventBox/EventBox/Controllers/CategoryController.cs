using AttributeRouting;
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
    [RoutePrefix("Categories")]
    public class CategoryController : Controller
    {
        [Route("GetAll")]
        public ActionResult GetAll()
        {
            string api = ContentManager.APIUrl + "api/Categories/GetAll";
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(api);
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream rebut = httpResponse.GetResponseStream();
            StreamReader readStream = new StreamReader(rebut, Encoding.UTF8);
            string info = readStream.ReadToEnd();
            var arr = JsonConvert.DeserializeObject<JArray>(info);
            Category c = new Category();
            List<Category> Categories = new List<Category>();
            foreach (JObject i in arr)
            {
                int ID = (int)i["ID"];
                string Name = (string)i["Name"];
                c = new Category
                {
                    ID = ID,
                    Name = Name
                };
                Categories.Add(c);
            }

            ViewData["Categories"] = Categories;
            return View("ViewCategories");
        }


        [Route("Search")]
        public ActionResult SearchEvent(int categoryID)
        {
            string api = ContentManager.APIUrl + "api/Events/GetByCategoryPaging?categoryID=" + categoryID + "&page=1&pageSize=12";
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(api);
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            var Pagination = httpWebResponse.Headers["X-Pagination"];
            JObject json = JObject.Parse(Pagination);
            ViewData["PrevPage"] = Server.UrlEncode((string)json["PrevPageLink"]);
            ViewData["NextPage"] = Server.UrlEncode((string)json["NextPageLink"]);
            ViewData["FirstPage"] = Server.UrlEncode((string)json["FirstPageLink"]);
            ViewData["LastPage"] = Server.UrlEncode((string)json["LastPageLink"]);
            Stream stream = httpWebResponse.GetResponseStream();
            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
            string info = streamReader.ReadToEnd();
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

            return View("~/Views/Category/SearchEvent.cshtml");
        }


        [Route("SearchPaging")]
        public ActionResult SearchEventPaging(string url)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(Server.UrlDecode(url));
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            var Pagination = httpWebResponse.Headers["X-Pagination"];
            JObject json = JObject.Parse(Pagination);
            ViewData["PrevPage"] = Server.UrlEncode((string)json["PrevPageLink"]);
            ViewData["NextPage"] = Server.UrlEncode((string)json["NextPageLink"]);
            ViewData["FirstPage"] = Server.UrlEncode((string)json["FirstPageLink"]);
            ViewData["LastPage"] = Server.UrlEncode((string)json["LastPageLink"]);
            Stream stream = httpWebResponse.GetResponseStream();
            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
            string info = streamReader.ReadToEnd();
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

            return View("~/Views/Category/SearchEvent.cshtml");
        }
    }
}
