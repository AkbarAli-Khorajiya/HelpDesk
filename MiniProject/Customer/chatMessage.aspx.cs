using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;

namespace MiniProject.Customer
{
    public partial class chatMessage : System.Web.UI.Page
    {
        public static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["customerName"] == null)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        [WebMethod]
        public static string GetMessage(string ticket_Id,string agent_Name)
        {
            string result = "";
            SqlConnection conn = new SqlConnection(dbConn);

            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT con.id, con.ticket_Id, con.message As message, con.user_Id, u.username As sender, con.created_at FROM conversation AS con INNER JOIN users AS u ON con.user_Id = u.id WHERE (con.ticket_Id = "+int.Parse(ticket_Id.ToString())+")", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                string sender = sdr["sender"].ToString();
                string message = sdr["message"].ToString();

                object createdAtObj = sdr["created_at"];
                DateTime createdAt;
                DateTime.TryParse(createdAtObj.ToString(), out createdAt);

                string formattedDate = createdAt.ToString("dd/MM/yyyy");
                string[] formattedTime = createdAt.ToString("HH:mm").Split(':');
                if(formattedTime[0] == "00")
                {
                    formattedTime[0] = "12";
                }
                if (sender == agent_Name)
                {
                    result += "<div class='message'><p>" + message + "</p><p class='timestamp'>" + formattedDate+" "+formattedTime[0]+":"+formattedTime[1] + "</p></div>";
                }
                else
                {
                    result += "<div class='message own'><p>" + message + "</p><p class='timestamp'>" + formattedDate +" "+formattedTime[0]+":"+formattedTime[1] +"</p></div>";
                }
                
            }

            return result;
        }
        [WebMethod]
        public static string SendMessage(string ticket_Id, string message)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO conversation (ticket_Id, message, user_Id, created_at) VALUES (" + int.Parse(ticket_Id) + ", '" + message + "', " + int.Parse(HttpContext.Current.Session["customerId"].ToString()) + ", GETDATE())", conn);
            if (cmd.ExecuteNonQuery() > 0)
            {
                conn.Close();
                return "Data Inserted Successfully";

            }
            else
            {
                conn.Close();
                return "Something went wrong";
            }
        }
    }
}