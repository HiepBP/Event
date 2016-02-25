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
    [RoutePrefix("Events")]
    public class EventController : Controller
    {

        /// <summary>
        /// Return all the event that match searchValue
        /// </summary>
        /// <param name="searchValue">Name of the event</param>
        /// <returns></returns>
        [Route("Search")]
        public ActionResult SearchEvent(string searchValue)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/GetByNamePaging?name=" + searchValue + "&page=1&pageSize=12");
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

            return View("~/Views/Event/SearchEvent.cshtml");
        }

        /// <summary>
        /// Redirect to next page
        /// </summary>
        /// <param name="url">URL of next page</param>
        /// <returns></returns>
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

            return View("~/Views/Event/SearchEvent.cshtml");
        }

        /// <summary>
        /// Get event detail
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <returns></returns>
        [Route("Detail")]
        public ActionResult Detail(int id)
        {
            //Get event detail
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/GetEventDetail?id=" + id);
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
            ed.Image = (string)eventDetail["Image"];
            JToken token = eventDetail["MaxAttendance"];
            if (token != null && token.Type != JTokenType.Null)
            {
                ed.MaxAttendance = (int)eventDetail["MaxAttendance"];
            }
            token = eventDetail["RequireAttendance"];
            if (token != null && token.Type != JTokenType.Null)
            {
                ed.RequireAttendance = (int)eventDetail["RequireAttendance"];
            }
            token = eventDetail["Vote"];
            if (token != null && token.Type != JTokenType.Null)
            {
                ed.Vote = (int)eventDetail["Vote"];
            }
            token = eventDetail["Price"];
            if (token != null && token.Type != JTokenType.Null)
            {
                ed.Price = (int)eventDetail["Price"];
            }
            token = eventDetail["Categories"];
            if (token != null && token.Type != JTokenType.Null)
            {
                ed.Categories = eventDetail["Categories"].ToObject<List<Category>>();
            }
            ViewData["EventDetail"] = ed;


            //Get joined user
            httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/GetJoinedUserPaging?id=" + id + "&page=1&pageSize=10");
            httpWebRequest.Method = "GET";
            httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            stream = httpWebResponse.GetResponseStream();
            streamReader = new StreamReader(stream, Encoding.UTF8);
            info = streamReader.ReadToEnd();
            var JUser = JsonConvert.DeserializeObject<JArray>(info);
            List<User> users = new List<Models.User>();
            foreach (var item in JUser)
            {
                User user = new User();
                user.ID = (int)item["ID"];
                user.Username = (string)item["Username"];
                users.Add(user);
            }
            ViewData["Users"] = users;


            //Get created User
            httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/GetUserByEvent?eventId=" + ed.ID);
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "GET";
            httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            stream = httpWebResponse.GetResponseStream();
            streamReader = new StreamReader(stream, Encoding.UTF8);
            info = streamReader.ReadToEnd();
            var JCreatedUser = JsonConvert.DeserializeObject<JObject>(info);
            User CreatedUser = new User();
            CreatedUser.ID = (int)JCreatedUser["ID"];
            CreatedUser.Username = (string)JCreatedUser["Username"];
            ViewData["CreatedUser"] = CreatedUser;

            //Check current user status
            httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/GetEventUserStatus?id=" +id);
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "GET";
            if (Session["Token"] != null)
            {
                httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            }
            try
            {
                httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                stream = httpWebResponse.GetResponseStream();
                streamReader = new StreamReader(stream, Encoding.UTF8);
                info = streamReader.ReadToEnd();
                var JObject = JsonConvert.DeserializeObject<JObject>(info);
                ViewData["UserStatus"] = (bool)JObject["Status"];
            }
            catch(WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var errorResponse = (HttpWebResponse)ex.Response)
                    {
                        if(errorResponse.StatusCode == HttpStatusCode.Unauthorized)
                        {
                            ViewData["UserStatus"] = null;
                        }
                    }
                }
            }

            return View("~/Views/Event/EventDetail.cshtml");
        }


        /// <summary>
        /// Redirect to the update event page
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <param name="name">Name of event</param>
        /// <param name="info">Info of event</param>
        /// <param name="time">Time of event</param>
        /// <param name="place">Place of event</param>
        /// <param name="maxAttendance">Max attendance</param>
        /// <param name="requireAttendance">Require attendance</param>
        /// <param name="price">Price of event</param>
        /// <param name="image">Image of event</param>
        /// <param name="categories">Categories of event</param>
        /// <returns></returns>
        [HttpGet]
        [Route("Update")]
        public ActionResult Update(int id, string name, string info, System.DateTime time, string place, Nullable<int> maxAttendance, Nullable<int> requireAttendance, Nullable<decimal> price, string image, int[] categories)
        {
            EventDetail ed = new EventDetail();
            ed.ID = id;
            ed.Name = name;
            ed.Info = info;
            ed.Time = time;
            ed.Place = place;
            ed.MaxAttendance = maxAttendance;
            ed.RequireAttendance = requireAttendance;
            ed.Price = price;
            ed.Image = image;
            List<Category> CategoriesTmp = new List<Category>();
            if (categories != null)
            {
                foreach (var item in categories)
                {
                    Category c = new Category
                    {
                        ID = item,
                        Name = ""
                    };
                    CategoriesTmp.Add(c);
                }
            }
            ed.Categories = CategoriesTmp;
            ViewData["UpdateEvent"] = ed;


            //Get categories
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Categories/GetAll");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream rebut = httpResponse.GetResponseStream();
            StreamReader readStream = new StreamReader(rebut, Encoding.UTF8);
            string tmp = readStream.ReadToEnd();
            var arr = JsonConvert.DeserializeObject<JArray>(tmp);
            List<Category> Categories = new List<Category>();
            foreach (JObject i in arr)
            {
                Category c = new Category();
                c.ID = (int)i["ID"];
                c.Name = (string)i["Name"];
                Categories.Add(c);
            }
            ViewData["Categories"] = Categories;
            ViewData["TimeError"] = TempData["TimeError"];
            ViewData["MaxError"] = TempData["MaxError"];

            return View("~/Views/Event/EditEvent.cshtml");
        }

        /// <summary>
        /// Update event
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <param name="name">Name of event</param>
        /// <param name="info">Info of event</param>
        /// <param name="time">Time of event</param>
        /// <param name="place">Place of event</param>
        /// <param name="maxAttendance">Max attendance</param>
        /// <param name="requireAttendance">Require attendance</param>
        /// <param name="price">Price of event</param>
        /// <param name="image">Image of event</param>
        /// <param name="oldValueImage">Current image of event</param>
        /// <param name="categories">Categories of event</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Update")]
        public ActionResult Update(int id, string name, string info, System.DateTime time, string place, Nullable<int> maxAttendance, Nullable<int> requireAttendance, Nullable<decimal> price, HttpPostedFileBase image, string oldValueImage, int[] categories)
        {
            string ImageUrl = "";
            if (image != null)
            {
                var folderName = "/Content/Upload/Images/";
                var fileName = image.FileName;
                FileStream fileStream;
                using (fileStream = System.IO.File.Create(AppDomain.CurrentDomain.BaseDirectory + folderName + fileName))
                {
                    image.InputStream.CopyTo(fileStream);
                }
                byte[] data;
                using (Stream inputStream = image.InputStream)
                {
                    MemoryStream memoryStream = inputStream as MemoryStream;
                    if (memoryStream == null)
                    {
                        memoryStream = new MemoryStream();
                        inputStream.CopyTo(memoryStream);
                    }
                    data = memoryStream.ToArray();
                }


                using (WebClient uploader = new WebClient())
                {
                    try
                    {
                        byte[] response = uploader.UploadFile(new Uri("http://uploads.im/api?upload"), fileStream.Name);
                        string s = uploader.Encoding.GetString(response);
                        JObject jo = JObject.Parse(s);
                        ImageUrl = (string)(jo["data"])["thumb_url"];
                    }
                    catch (Exception ex)
                    {
                    }
                    finally
                    {
                        System.IO.File.Delete(AppDomain.CurrentDomain.BaseDirectory + folderName + fileName);
                    }
                }
            }

            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/UpdateEvent?id=" + id);
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "PUT";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                if (ImageUrl == "")
                {
                    ImageUrl = oldValueImage;
                }


                EventDetail temp = new EventDetail
                {
                    ID = id,
                    Name = name,
                    Info = info,
                    Time = time,
                    Place = place,
                    MaxAttendance = maxAttendance,
                    RequireAttendance = requireAttendance,
                    Price = price,
                    Image = ImageUrl,
                    Categories = new List<Category>()
                };
                if (categories != null)
                {
                    foreach (var item in categories)
                    {
                        var obj = new Category
                        {
                            ID = item,
                            Name = ""
                        };
                        temp.Categories.Add(obj);
                    }
                }
                string tmp = JsonConvert.SerializeObject(temp);


                streamWriter.Write(tmp);
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
                            var JObject = JsonConvert.DeserializeObject<JObject>(error);
                            var token = JObject["ModelState"]["Time"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                TempData["TimeError"] = (string)(JObject["ModelState"]["Time"][0]);
                            }
                            token = JObject["ModelState"]["MaxAttendance"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                TempData["MaxError"] = (string)(JObject["ModelState"]["MaxAttendance"][0]);
                            }
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }
            if (error == "")
            {
                var arr = JsonConvert.DeserializeObject<JObject>(result);
                return RedirectToAction("Detail", new { id = id });
            }
            else
            {
                return RedirectToAction("Update", new { id = id, name = name, info = info, time = time, place = place, maxAttendance = maxAttendance, requireAttendance = requireAttendance, price = price, image = ImageUrl, categories = categories });
            }
        }

        /// <summary>
        /// Redirect to create new event
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("Create")]
        public ActionResult Create()
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Categories/GetAll");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "GET";
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream rebut = httpResponse.GetResponseStream();
            StreamReader readStream = new StreamReader(rebut, Encoding.UTF8);
            string info = readStream.ReadToEnd();
            var arr = JsonConvert.DeserializeObject<JArray>(info);
            List<Category> Categories = new List<Category>();
            foreach (JObject i in arr)
            {
                Category c = new Category();
                c.ID = (int)i["ID"];
                c.Name = (string)i["Name"];
                Categories.Add(c);
            }
            ViewData["Categories"] = Categories;
            ViewData["TimeError"] = TempData["TimeError"];
            ViewData["MaxError"] = TempData["MaxError"];
            return View("~/Views/Event/AddEvent.cshtml");
        }

        /// <summary>
        /// Create new event
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <param name="name">Name of event</param>
        /// <param name="info">Info of event</param>
        /// <param name="time">Time of event</param>
        /// <param name="place">Place of event</param>
        /// <param name="maxAttendance">Max attendance</param>
        /// <param name="requireAttendance">Require attendance</param>
        /// <param name="price">Price of event</param>
        /// <param name="image">Image of event</param>
        /// <param name="categories">Categories of event</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Create")]
        public ActionResult Create(string name, string info, DateTime time, string place, Nullable<int> maxAttendance, Nullable<int> requireAttendance, Nullable<decimal> price, HttpPostedFileBase image, int[] categories)
        {

            //Test get image
            var folderName = "/Content/Upload/Images/";
            var fileName = image.FileName;
            FileStream fileStream;
            using (fileStream = System.IO.File.Create(AppDomain.CurrentDomain.BaseDirectory + folderName + fileName))
            {
                image.InputStream.CopyTo(fileStream);
            }
            byte[] data;
            string ImageUrl = "";
            using (Stream inputStream = image.InputStream)
            {
                MemoryStream memoryStream = inputStream as MemoryStream;
                if (memoryStream == null)
                {
                    memoryStream = new MemoryStream();
                    inputStream.CopyTo(memoryStream);
                }
                data = memoryStream.ToArray();
            }


            using (WebClient uploader = new WebClient())
            {
                try
                {
                    byte[] response = uploader.UploadFile(new Uri("http://uploads.im/api?upload"), fileStream.Name);
                    string s = uploader.Encoding.GetString(response);
                    JObject jo = JObject.Parse(s);
                    ImageUrl = (string)(jo["data"])["thumb_url"];
                }
                catch (Exception ex)
                {
                }
                finally
                {
                    System.IO.File.Delete(AppDomain.CurrentDomain.BaseDirectory + folderName + fileName);
                }
            }



            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/CreateEvent");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "POST";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                EventDetail temp = new EventDetail
                {
                    Name = name,
                    Info = info,
                    Time = time,
                    Place = place,
                    MaxAttendance = maxAttendance,
                    RequireAttendance = requireAttendance,
                    Price = price,
                    Image = ImageUrl,
                    Categories = new List<Category>()
                };
                if (categories != null)
                {
                    foreach (var item in categories)
                    {
                        var obj = new Category
                        {
                            ID = item,
                            Name = ""
                        };
                        temp.Categories.Add(obj);
                    }
                }
                string tmp = JsonConvert.SerializeObject(temp);

                streamWriter.Write(tmp);
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
                            var JObject = JsonConvert.DeserializeObject<JObject>(error);
                            var token = JObject["ModelState"]["Time"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                TempData["TimeError"] = (string)(JObject["ModelState"]["Time"][0]);
                            }
                            token = JObject["ModelState"]["MaxAttendance"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                TempData["MaxError"] = (string)(JObject["ModelState"]["MaxAttendance"][0]);
                            }
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }
            if (result != "")
            {
                var arr = JsonConvert.DeserializeObject<JObject>(result);
                return RedirectToAction("Detail", new { id = (int)arr["ID"] });
            }
            else
            {
                return RedirectToAction("Create");
            }
        }

        /// <summary>
        /// Delete event base on ID
        /// Need authorization in header
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <returns></returns>
        [HttpGet]
        [Route("Delete")]
        public ActionResult Delete(int id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/DeleteEvent?id=" + id);
            httpWebRequest.Method = "DELETE";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
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

        /// <summary>
        /// Join event base on event id
        /// Need authorization in header
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <returns></returns>
        [Route("Join")]
        public ActionResult JoinEvent(string id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/JoinEvent?id=" + id);
            httpWebRequest.Method = "PUT";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.ContentLength = 0;
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


        /// <summary>
        /// Leave event base on ID
        /// Need authorization in header
        /// </summary>
        /// <param name="id">ID of event</param>
        /// <returns></returns>
        [Route("Leave")]
        public ActionResult LeaveEvent(string id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Events/LeaveEvent?id=" + id);
            httpWebRequest.Method = "PUT";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.ContentLength = 0;
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
    }
}
