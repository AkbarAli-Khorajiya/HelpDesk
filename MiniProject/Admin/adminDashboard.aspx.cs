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
    public partial class adminDashboard : System.Web.UI.Page
    {
        String dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminName"] != null)
            {
                if (!IsPostBack)
                {
                    getTotalTickets();
                    getTotalAgents();
                    getTotalDepartments();
                    getOpenTickets();
                    getInProgressTickets();
                    getClosedTickets();
                    getTotalCustomers();
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }
        public void getTotalTickets()
        { 
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as TotalTickets  FROM tickets",conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if(sdr.Read())
            {
                lblTotalTicket.Text = sdr["TotalTickets"].ToString();
            }else
	        {
                lblTotalTicket.Text = "0";

	        }
            conn.Close();

        }
        public void getTotalCustomers()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as TotalCustomer from users where role = 3", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblTotalCustomer.Text = sdr["TotalCustomer"].ToString();
            }
            else
            {
                lblTotalCustomer.Text = "0";

            }
            conn.Close();

        }
        public void getTotalAgents()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(DISTINCT user_Id) AS TotalAgents FROM agents", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblTotalAgent.Text = sdr["TotalAgents"].ToString();
            }
            else
            {
                lblTotalAgent.Text = "0";

            }
            conn.Close();

        }
        public void getTotalDepartments()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as TotalDepartments  FROM department", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblTotalDepartments.Text = sdr["TotalDepartments"].ToString();
            }
            else
            {
                lblTotalDepartments.Text = "0";

            }
            conn.Close();

        }
        public void getOpenTickets()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as OpenTickets  FROM tickets WHERE status = 'Open'", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblOpenTicket.Text = sdr["OpenTickets"].ToString();
            }
            else
            {
                lblOpenTicket.Text = "0";

            }
            conn.Close();

        }
        public void getInProgressTickets()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as InProgressTickets  FROM tickets WHERE status = 'In-Progress'", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblInProgressTicket.Text = sdr["InProgressTickets"].ToString();
            }
            else
            {
                lblInProgressTicket.Text = "0";
            }
            conn.Close();

        }
        public void getClosedTickets()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Count(*) as InClosedTickets FROM tickets WHERE status = 'Closed'", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                lblClosedTicket.Text = sdr["InClosedTickets"].ToString();
            }
            else
            {
                lblClosedTicket.Text = "0";
            }
            conn.Close();

        }
    }
}