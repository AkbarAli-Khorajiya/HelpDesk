using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace MiniProject.Agent
{
    public partial class agentDashboard : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["agentRole"] != null)
            {
                if (int.Parse(Session["agentRole"].ToString()) != 2)
                {
                    Response.Redirect("../Login.aspx");
                }
                else
                {
                    getTotalAssignedTicket();
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
        public void getTotalAssignedTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalTickets FROM tickets WHERE (agent_Id = " + int.Parse(Session["agentId"].ToString()) + ")", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblAssignedTicket.Text = sdr["TotalTickets"].ToString();
            }
            conn.Close();
        }
        public void getTotalOpenTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalTickets FROM tickets WHERE (agent_Id = " + int.Parse(Session["agentId"].ToString()) + ") AND (status = 'Open')", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblOpenTicket.Text = sdr["TotalTickets"].ToString();
            }
            conn.Close();
        }
        public void getTotalClosedTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalTickets FROM tickets WHERE (agent_Id = " + int.Parse(Session["agentId"].ToString()) + ") AND (status = 'Closed')", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblClosedTicket.Text = sdr["TotalTickets"].ToString();
            }
            conn.Close();
        }
        public void getTotalInProgressTicket()
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS TotalTickets FROM tickets WHERE (agent_Id = " + int.Parse(Session["agentId"].ToString()) + ") AND (status = 'In-Progress')", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblInProgressTicket.Text = sdr["TotalTickets"].ToString();
            }
            conn.Close();
        }
    }
}