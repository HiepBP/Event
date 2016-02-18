using AttributeRouting;
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
    [RoutePrefix("Users")]
    public class UsersController : Controller
    {
        //
        // GET: /Users/

        [HttpPost]
        [Route("Register")]
        public ActionResult Register(string email, string password, string confirmpassword)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Account/Register");
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


        [HttpPost]
        [Route("Login")]
        public ActionResult Login(string email, string password)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/Token");
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
                            Session["Token"] = (string)token["access_token"];
                            Session["Username"] = email;
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

        [Route("Logout")]
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Home", "Index", new { area = "" });
        }

        [Route("Token")]
        public void Token(string token, string username)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Users/GetCurrentUserDetail");
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

        [Route("Detail")]
        public ActionResult Detail(int id)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/YTicket.API2/api/Users/GetUserDetail?id=" + id);
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
    }
}
