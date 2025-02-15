using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace MiniProject.Admin
{
    public partial class ViewTicket : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        static string ticketStatus = "";
        int id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminName"] != null)
            {
                id = int.Parse(Request.Params["id"]);
                getTicketDetail(id);
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
            SqlCommand cmd = new SqlCommand("SELECT t.id, t.title, t.description, t.status, t.priority, t.created_at, c.username AS customer, c.email,aname.username as assignee FROM tickets AS t INNER JOIN users AS c ON t.customer_Id = c.id INNER JOIN agents AS age ON t.agent_Id = age.id INNER JOIN users AS aname ON age.user_Id = aname.id WHERE (t.id = " + ticketId + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblTicketId.Text = "Ticket ID: " + sdr["id"].ToString();
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
                lblStatusValue.CssClass = cssClass;
                lblDescription.Text = sdr["description"].ToString();
                lblTicketOwner.Text = sdr["assignee"].ToString();
                lblTicketIdValue.Text = sdr["id"].ToString();
                lblName.Text = sdr["customer"].ToString();
                lblEmail.Text = sdr["email"].ToString();
                lblTicketRaised.Text = sdr["created_at"].ToString();
                lblStatusValue.Text = sdr["status"].ToString();
                lblPriority.Text = sdr["priority"].ToString();
            }
            conn.Close();
        }
    }
}