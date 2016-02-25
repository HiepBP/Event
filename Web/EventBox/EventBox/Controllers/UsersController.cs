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
    [RoutePrefix("Users")]
    public class UsersController : Controller
    {
        /// <summary>
        /// Create new user
        /// </summary>
        /// <param name="email">email of user</param>
        /// <param name="password">register password</param>
        /// <param name="confirmpassword">confirm password</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Register")]
        public ActionResult Register(string email, string password, string confirmpassword)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "/api/Account/Register");
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "POST";
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = "{\"Email\":\"" + email + "\"," +
                              "\"Password\":\"" + password + "\"," +
                              "\"ConfirmPassword\":\"" + confirmpassword + "\"}";

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
                            Response.StatusCode = (int)HttpStatusCode.OK;
                        }
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
                            Response.StatusCode = (int)HttpStatusCode.BadRequest;
                            return Json(error);
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                    }
                }
            }
            return Content("");
        }


        /// <summary>
        /// Login
        /// </summary>
        /// <param name="email">email of user</param>
        /// <param name="password">login password</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Login")]
        public ActionResult Login(string email, string password)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "Token");
            httpWebRequest.ContentType = "application/x-www-form-urlencoded";
            httpWebRequest.Method = "POST";
            var json = "grant_type=password" +
                              "&username=" + email +
                              "&password=" + password;
            var data = Encoding.ASCII.GetBytes(json);
            httpWebRequest.ContentLength = data.Length;
            using (var streamWriter = httpWebRequest.GetRequestStream())
            {
                streamWriter.Write(data, 0, data.Length);
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
                            JObject token = JsonConvert.DeserializeObject<JObject>(result);
                            httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/GetCurrentUserDetail");
                            httpWebRequest.Accept = "application/json";
                            httpWebRequest.Method = "GET";
                            httpWebRequest.Headers["Authorization"] = "Bearer " + (string)token["access_token"];
                            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                            Stream stream = httpWebResponse.GetResponseStream();
                            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
                            string info = streamReader.ReadToEnd();
                            var UserDetail = JsonConvert.DeserializeObject<JObject>(info);
                            Session["Token"] = (string)token["access_token"];
                            Session["Username"] = email;
                            Session["CurrentUserID"] = (int)UserDetail["ID"];
                            Response.StatusCode = (int)HttpStatusCode.OK;
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
                            Response.StatusCode = (int)HttpStatusCode.BadRequest;
                            return Json(error);
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                        TempData["StatusCode"] = (int)errorResponse.StatusCode;
                    }
                }
            }
            return Content("");
        }

        /// <summary>
        /// Logout / Clear session
        /// </summary>
        /// <returns></returns>
        [Route("Logout")]
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Home", "Index", new { area = "" });
        }

        /// <summary>
        /// Not use now
        /// </summary>
        [Route("Token")]
        public void Token(string token, string username)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/GetCurrentUserDetail");
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "GET";
            httpWebRequest.Headers["Authorization"] = "Bearer " + token;
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream stream = httpWebResponse.GetResponseStream();
            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
            string info = streamReader.ReadToEnd();
            var UserDetail = JsonConvert.DeserializeObject<JObject>(info);
            Session["CurrentUserID"] = (int)UserDetail["ID"];
            Session["Token"] = token;
            Session["Username"] = username;
        }

        /// <summary>
        /// Get detail of user base on user's id
        /// </summary>
        /// <param name="id">User's id</param>
        /// <returns></returns>
        [Route("Detail")]
        public ActionResult Detail(int id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/GetUserDetail?id=" + id);
            httpWebRequest.Method = "GET";
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
                            JObject user = JsonConvert.DeserializeObject<JObject>(result);
                            UserDetail ud = new UserDetail();
                            ud.ID = (int)user["ID"];
                            ud.Username = (string)user["Username"];
                            ud.Email = (string)user["Email"];
                            JToken token = user["Address"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                ud.Address = (string)user["Address"];
                            }
                            token = user["Phone"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                ud.Phone = (string)user["Phone"];
                            }
                            token = user["Image"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                ud.Image = (string)user["Image"];
                            }
                            else
                            {
                                ud.Image = "";
                            }
                            token = user["Categories"];
                            if (token != null && token.Type != JTokenType.Null)
                            {
                                ud.Categories = user["Categories"].ToObject<List<Category>>();
                            }
                            ViewData["UserDetail"] = ud;
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
            return View("~/Views/User/UserDetail.cshtml");
        }

        /// <summary>
        /// Redirect to the update user page
        /// </summary>
        /// <param name="id">User's ID</param>
        /// <param name="username">User's username</param>
        /// <param name="email">User's email</param>
        /// <param name="address">User's address</param>
        /// <param name="phone">User's phone</param>
        /// <param name="image">User's image</param>
        /// <returns></returns>
        [HttpGet]
        [Route("Update")]
        public ActionResult Update(int id, string username, string email, string address, string phone, string image)
        {
            UserDetail ud = new UserDetail();
            ud.ID = id;
            ud.Username = username;
            ud.Email = email;
            ud.Address = address;
            ud.Phone = phone;
            ud.Image = image;
            ViewData["UpdateUser"] = ud;
            return View("~/Views/User/EditUser.cshtml");
        }

        /// <summary>
        /// Update current user
        /// Need authozation in header
        /// </summary>
        /// <param name="id">User's ID</param>
        /// <param name="username">User's update username</param>
        /// <param name="email">User's email</param>
        /// <param name="address">User's update address</param>
        /// <param name="phone">User's update phone</param>
        /// <param name="image">User's update image</param>
        /// <param name="oldValueImage">User's current image</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Update")]
        public ActionResult Update(int id, string username, string email, string address, string phone, HttpPostedFileBase image, string oldValueImage)
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

            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/UpdateUser?id=" + id);
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "PUT";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = "";
                if (ImageUrl == "")
                {
                    ImageUrl = oldValueImage;
                }
                json = "{\"ID\":\"" + id + "\"," +
                              "\"Username\":\"" + username + "\"," +
                              "\"Email\":\"" + email + "\"," +
                              "\"Address\":\"" + address + "\"," +
                              "\"Phone\":\"" + phone + "\"," +
                              "\"Image\":\"" + ImageUrl + "\"}";
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

        /// <summary>
        /// Redirect to change current user's password page
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("ChangePassword")]
        public ActionResult ChangePassword()
        {
            return View("~/Views/User/ChangePassword.cshtml");
        }

        /// <summary>
        /// Change password of current user
        /// Need authozation in header
        /// </summary>
        /// <param name="oldPassword">Current password</param>
        /// <param name="newPassword">New password</param>
        /// <param name="confirmPassword">Confirm new password</param>
        /// <returns></returns>
        [HttpPost]
        [Route("ChangePassword")]
        public ActionResult ChangePassword(string oldPassword, string newPassword, string confirmPassword)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Account/ChangePassword");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "POST";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = "{\"OldPassword\":\"" + oldPassword + "\"," +
                              "\"NewPassword\":\"" + newPassword + "\"," +
                              "\"ConfirmPassword\":\"" + confirmPassword + "\"}";
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
                            Response.StatusCode = (int)HttpStatusCode.OK;
                        }
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
                            Response.StatusCode = (int)HttpStatusCode.BadRequest;
                            return Json(error);
                            //TODO: use JSON.net to parse this string and look at the error message
                        }
                    }
                }
            }
            return Content("");
        }

        /// <summary>
        /// Update current user
        /// Need authozation in header
        /// </summary>
        /// <param name="id">User's ID</param>
        /// <param name="username">User's update username</param>
        /// <param name="email">User's email</param>
        /// <param name="address">User's update address</param>
        /// <param name="phone">User's update phone</param>
        /// <param name="image">User's update image</param>
        /// <param name="oldValueImage">User's current image</param>
        /// <returns></returns>
        [Route("Notification")]
        public ActionResult GetNotification()
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(ContentManager.APIUrl + "api/Users/GetNotification");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.MediaType = "application/json";
            httpWebRequest.Accept = "application/json";
            httpWebRequest.Method = "GET";
            httpWebRequest.Headers["Authorization"] = "Bearer " + Session["Token"];
            var httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            Stream stream = httpWebResponse.GetResponseStream();
            StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
            string info = streamReader.ReadToEnd();
            var JArray = JsonConvert.DeserializeObject<JArray>(info);
            List<Notification> Notifications = new List<Notification>();
            foreach (var JObject in JArray)
            {
                Notification Noti = new Notification();
                Noti.ID = (int)JObject["ID"];
                Noti.Information = (string)JObject["Information"];
                Noti.New = (bool)JObject["New"];
                Notifications.Add(Noti);
            }
            ViewData["Notifications"] = Notifications;
            return View();
        }
    }
}
