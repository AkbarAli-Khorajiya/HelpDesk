using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace MiniProject.Customer
{
    public partial class customerDashboard : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customerRole"] != null)
            {
                if (int.Parse(Session["customerRole"].ToString()) != 3)
                {
                    Response.Redirect("../Login.aspx");
                }
                else
                {
                    getTotalCreatedTicket();
                    getTotalOpenTicket();
                    getTotalClosedTicket();
                    getTotalInProgressTicket();
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }

        }
        public void getTotalCreatedTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalTickets FROM tickets WHERE (customer_Id = " + int.Parse(Session["customerId"].ToString()) + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblCreatedTicket.Text = sdr["TotalTickets"].ToString();
            }
            conn.Close();
        }
        public void getTotalOpenTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalOpenTickets FROM tickets where status = 'Open' and (customer_Id = " + int.Parse(Session["customerId"].ToString()) + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblOpenTicket.Text = sdr["TotalOpenTickets"].ToString();
            }
            conn.Close();

        }
        public void getTotalClosedTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalClosedTickets FROM tickets where status = 'Closed' and (customer_Id = " + int.Parse(Session["customerId"].ToString()) + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblClosedTicket.Text = sdr["TotalClosedTickets"].ToString();
            }
            conn.Close();
        }
        public void getTotalInProgressTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalInProgressTickets FROM tickets where status = 'In-Progress' and (customer_Id = " + int.Parse(Session["customerId"].ToString()) + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblInProgressTicket.Text = sdr["TotalInProgressTickets"].ToString();
            }
            conn.Close();
        }
    }
}