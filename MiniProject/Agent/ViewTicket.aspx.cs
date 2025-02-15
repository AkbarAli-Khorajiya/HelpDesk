using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using TaskManagement.config;

namespace MiniProject.Agent
{
    public partial class ViewTicket : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        static string ticketStatus = "";
        static int id;
        static string customerEmail = "";
        static string ticketTitle = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["agentName"] != null)
            {
                id = int.Parse(Request.Params["id"]);
                getTicketDetail(id);
                ddlStatusChange.Text = ticketStatus;
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
            
        }
        public void getTicketDetail(int ticketId) 
        {
            string cssClass = string.Empty;
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT t.id, t.title, t.description, t.status, t.priority,t.created_at, c.username AS customer, c.password, c.email, c.role FROM tickets AS t INNER JOIN users AS c ON t.customer_Id = c.id WHERE (t.agent_Id =  " + int.Parse(Session["agentId"].ToString()) + ") AND (t.id = " + ticketId + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblTicketId.Text = "Ticket ID: "+sdr["id"].ToString();
                lblTicketTitle.Text = sdr["title"].ToString();
                string status = sdr["status"].ToString();
                ticketStatus = status;
                switch (status)
                {
                    case "In-Progress":
                        cssClass = "status-InProgress";
                        break;
                    case "Closed":
                        cssClass = "status-Closed";
                        break;
                    case "Open":
                        cssClass = "status-Open";
                        break;
                }
                customerEmail += sdr["email"].ToString();
                lblStatusValue.CssClass = cssClass;
                lblDescription.Text = sdr["description"].ToString();

                lblName.Text = sdr["customer"].ToString();
                lblEmail.Text = sdr["email"].ToString();
                lblTicketIdValue.Text = sdr["id"].ToString();
                lblTicketRaised.Text = sdr["created_at"].ToString();
                lblStatusValue.Text = sdr["status"].ToString();
                lblPriority.Text = sdr["priority"].ToString();
            }
            conn.Close();
        }
        [WebMethod]
        public static string UpdateStatus(string status, string ticket_Id)
        {
            EmailService email = new EmailService();

            string result;
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("UPDATE tickets SET status = @status WHERE id = @ticketId", conn);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@ticketId", int.Parse(ticket_Id.ToString()));
            conn.Open();
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                result = "success";
                email.SendEmail(customerEmail, "HelpDesk(Ticket ID " + id + ") : Status Updated ", "Dear Customer,<br><br>Your ticket status updated.");
            }
            else
            {
                result = "failed";
            }
            conn.Close();
            return result;
        }
    }
}