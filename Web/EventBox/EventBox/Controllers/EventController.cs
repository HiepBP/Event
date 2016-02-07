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

    public class EventController : Controller
    {

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [Route("SearchEvent")]
        public ActionResult SearchEvent(string name)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/GetByNamePaging?name=" + name + "&page=1&pageSize=9");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
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
                e = new Event(ID, Name, Time, Place);
                events.Add(e);
            }
            ViewData["Events"] = events;

            return View("Index");
        }

        [Route("Detail")]
        public ActionResult Detail(int id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/GetEventDetail?id=" + id);
            httpWebRequest.Method = "GET";
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream stream = httpWebResponse.GetResponseStream();
            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
            string info = streamReader.ReadToEnd();
            var eventDetail = JsonConvert.DeserializeObject<JObject>(info);
            EventDetail ed = new EventDetail();
            ed.ID = (int)eventDetail["ID"];
            ed.Name = (string)eventDetail["Name"];
            ed.Info = (string)eventDetail["Info"];
            ed.Time = (System.DateTime)eventDetail["Time"];
            ed.Place = (string)eventDetail["Place"];
            ed.MaxAttendance = (int)eventDetail["MaxAttendance"];
            ed.RequireAttendance = (int)eventDetail["RequireAttendance"];
            ed.Vote = (int)eventDetail["Vote"];
            ed.Price = (int)eventDetail["Price"];
            ed.Categories = eventDetail["Categories"].ToObject<List<Category>>();
            ViewData["EventDetail"] = ed;

            httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/GetJoinedUserPaging?id=" + id + "&page=1&pageSize=10");
            httpWebRequest.Method = "GET";
            httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            stream = httpWebResponse.GetResponseStream();
            streamReader = new StreamReader(stream, Encoding.UTF8);
            info = streamReader.ReadToEnd();
            var JUser = JsonConvert.DeserializeObject<JArray>(info);
            User user = new User();
            List<User> users = new List<Models.User>();
            foreach (var item in JUser)
            {
                user.ID = (int)item["ID"];
                user.Username = (string)item["Username"];
                user.Image = (byte[])item["Image"];
                users.Add(user);
            }
            ViewData["Users"] = users;

            return View();
        }

        [Route("Update")]
        public ActionResult Update(int id, string name, string info, System.DateTime time, string place, int maxAttendance, int requireAttendance, int vote, double price, string image, string[] categories)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/GetEventDetail?id=" + id);
            httpWebRequest.Method = "PUT";
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = "{\"ID\":\"" + id + "\"," +
                              "\"Name\":\"" + name + "\"," +
                              "\"Info\":\"" + info + "\"," +
                              "\"Time\":\"" + time + "\"," +
                              "\"Place\":\"" + place + "\"," +
                              "\"MaxAttendance\":\"" + maxAttendance + "\"," +
                              "\"RequireAttendance\":\"" + requireAttendance + "\"," +
                              "\"Vote\":\"" + vote + "\"," +
                              "\"Price\":\"" + price + "\"," +
                              "\"Image\":\"" + image + "\"," +
                              "\"Categories\":\"" + categories + "\"}";

                streamWriter.Write(json);
                streamWriter.Flush();
                streamWriter.Close();
            }
            string result = "";
            string error = "";
            try
            {
                using (var httpResponse = httpWebRequest.GetResponse() as HttpWebResponse)
                {
                    if (httpWebRequest.HaveResponse && httpResponse != null)
                    {
                        using (var reader = new StreamReader(httpResponse.GetResponseStream()))
                        {
                            result = reader.ReadToEnd();
                        }
                        TempData["StatusCode"] = (int)httpResponse.StatusCode;
                    }
                }
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var errorResponse = (HttpWebResponse)ex.Response)
                    {
                        using (var reader = new StreamReader(errorResponse.GetResponseStream()))
                        {
                            error = reader.ReadToEnd();
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }

            return RedirectToAction("Detail", new { id = id });
        }

        [Route("Create")]
        public ActionResult Create(string name, string info, System.DateTime time, string place, int maxAttendance, int requireAttendance, int vote, double price, string image, string[] categories)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/CreateEvent");
            httpWebRequest.Method = "POST";
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = "{\"Name\":\"" + name + "\"," +
                              "\"Info\":\"" + info + "\"," +
                              "\"Time\":\"" + time + "\"," +
                              "\"Place\":\"" + place + "\"," +
                              "\"MaxAttendance\":\"" + maxAttendance + "\"," +
                              "\"RequireAttendance\":\"" + requireAttendance + "\"," +
                              "\"Vote\":\"" + vote + "\"," +
                              "\"Price\":\"" + price + "\"," +
                              "\"Image\":\"" + image + "\"," +
                              "\"Categories\":\"" + categories + "\"}";

                streamWriter.Write(json);
                streamWriter.Flush();
                streamWriter.Close();
            }
            string result = "";
            string error = "";
            try
            {
                using (var httpResponse = httpWebRequest.GetResponse() as HttpWebResponse)
                {
                    if (httpWebRequest.HaveResponse && httpResponse != null)
                    {
                        using (var reader = new StreamReader(httpResponse.GetResponseStream()))
                        {
                            result = reader.ReadToEnd();
                        }
                        TempData["StatusCode"] = (int)httpResponse.StatusCode;
                    }
                }
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var errorResponse = (HttpWebResponse)ex.Response)
                    {
                        using (var reader = new StreamReader(errorResponse.GetResponseStream()))
                        {
                            error = reader.ReadToEnd();
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }
            if (result != "")
            {
                var arr = JsonConvert.DeserializeObject<JObject>(info);
                return RedirectToAction("Detail", new { id = (int)arr["ID"] });
            }
            else
            {
                return RedirectToAction("Home", "Index", new { area = "" });
            }
        }

        [Route("Delete")]
        public ActionResult Delete(int id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Events/DeleteEvent?id=" + id);
            httpWebRequest.Method = "DELETE";
            httpWebRequest.Headers["Authorization"] = "bearer" + Session["Token"];
            string result = "";
            string error = "";
            try
            {
                using (var httpResponse = httpWebRequest.GetResponse() as HttpWebResponse)
                {
                    if (httpWebRequest.HaveResponse && httpResponse != null)
                    {
                        using (var reader = new StreamReader(httpResponse.GetResponseStream()))
                        {
                            result = reader.ReadToEnd();
                        }
                        TempData["StatusCode"] = (int)httpResponse.StatusCode;
                    }
                }
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var errorResponse = (HttpWebResponse)ex.Response)
                    {
                        using (var reader = new StreamReader(errorResponse.GetResponseStream()))
                        {
                            error = reader.ReadToEnd();
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }
            return RedirectToAction("Home", "Index", new { area = "" });
        }

    }
}
