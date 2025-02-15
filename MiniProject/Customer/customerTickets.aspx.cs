using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Services;
using TaskManagement.config;

namespace MiniProject.Customer
{
    public partial class customerTickets : System.Web.UI.Page
    {
        static string ticketPriority = "All";
        public string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customerRole"] != null && int.Parse(Session["customerRole"].ToString()) == 3)
            {
                if (!IsPostBack)
                {
                    getAllAssignedTickets("All", "");
                    bindDepartment();
                }
            }
        }
        public void getAllAssignedTickets(string searchPriority, string search)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            string query = "SELECT t.id, t.title, t.description,t.status, t.priority, t.created_at, d.dep_name AS department, aname.username AS assignee FROM tickets AS t INNER JOIN agents AS a ON t.agent_Id = a.id  INNER JOIN users AS aname ON a.user_Id = aname.id INNER JOIN department AS d ON a.department_Id = d.id WHERE (t.customer_Id = " + int.Parse(Session["customerId"].ToString()) + ") ";
            if (searchPriority != "All" && search == "")
            {
                query += " and t.priority = @Priority";
            }
            else if (searchPriority != "All" && search != "")
            {
                query += " and t.priority = @Priority and t.title like '%'+@title+'%' and aname.username like '%'+@assignee+'%' and t.status like '%'+@status+'%' and d.dep_name like '%'+@department+'%'";

            }
            else if (searchPriority == "All" && search != "")
            {
                query += " and (t.title like '%'+@title+'%' or t.priority like '%'+@Priority+'%' or aname.username like '%'+@assignee+'%' or t.status like '%'+@status+'%' or d.dep_name like '%'+@department+'%')";

            }
            SqlDataAdapter sda = new SqlDataAdapter(query, conn);
            if (searchPriority != "All" && search == "")
            {
                sda.SelectCommand.Parameters.AddWithValue("@Priority", searchPriority);

            }
            else if (searchPriority != "All" && search != "")
            {
                sda.SelectCommand.Parameters.AddWithValue("@Priority", searchPriority);
                sda.SelectCommand.Parameters.AddWithValue("@title", search);
                sda.SelectCommand.Parameters.AddWithValue("@assignee", search);
                sda.SelectCommand.Parameters.AddWithValue("@status", search);
                sda.SelectCommand.Parameters.AddWithValue("@department", search);
            }
            else if (searchPriority == "All" && search != "")
            {
                sda.SelectCommand.Parameters.AddWithValue("@Priority", search);
                sda.SelectCommand.Parameters.AddWithValue("@title", search);
                sda.SelectCommand.Parameters.AddWithValue("@assignee", search);
                sda.SelectCommand.Parameters.AddWithValue("@status", search);
                sda.SelectCommand.Parameters.AddWithValue("@department", search);
            }
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblNoData.Visible = false;
                dlTickets.DataSource = ds;
                dlTickets.DataBind();
            }
            else
            {
                lblNoData.Visible = true;
                dlTickets.DataSource = ds;
                dlTickets.DataBind();
            }
            

        }

        protected void ddlPriority_SelectedIndexChanged(object sender, EventArgs e)
        {
            ticketPriority = ddlPriority.SelectedValue;
            getAllAssignedTickets(ticketPriority, "");
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            getAllAssignedTickets(ticketPriority, txtSearch.Text);

        }

        public void bindDepartment()
        {
            SqlConnection conn = new SqlConnection(connectionString);
            SqlDataAdapter sda = new SqlDataAdapter("Select * from department", conn);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            ddlFormDepartment.DataSource = ds;
            ddlFormDepartment.DataValueField = "id";
            ddlFormDepartment.DataTextField = "dep_name";
            ddlFormDepartment.DataBind();
            
        }
        [WebMethod]
        public static string sendTicketData(string title, string description, string department, string priority)
        {
            EmailService email = new EmailService();
            string customerName = HttpContext.Current.Session["customerName"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);
            string query = "INSERT INTO tickets (title, description, status, priority, created_at, customer_Id, agent_Id) VALUES (@title, @description, 'Open', @Priority, @created_at, @customer_Id, @agent_Id)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@title", title);
            cmd.Parameters.AddWithValue("@description", description);
            cmd.Parameters.AddWithValue("@Priority", priority);
            cmd.Parameters.AddWithValue("@created_at", DateTime.Now);
            cmd.Parameters.AddWithValue("@customer_Id", int.Parse(HttpContext.Current.Session["customerId"].ToString()));
            conn.Open();
            SqlCommand cmdGetAgent = new SqlCommand("SELECT id, department_Id, user_Id FROM agents WHERE (department_Id = " + int.Parse(department) + ")", conn);
            SqlDataReader sdrAgent = cmdGetAgent.ExecuteReader();
            int agentId = 0;
            int ticketCount = int.MaxValue;
            while(sdrAgent.Read())
            {
                SqlCommand cmdGetTicketCount = new SqlCommand("SELECT t.agent_Id as agentId, COUNT(*) AS TicketCount FROM tickets AS t INNER JOIN agents AS a ON t.agent_Id = a.id INNER JOIN department AS d ON a.department_Id = d.id WHERE  (d.id = "+int.Parse(department)+") AND (a.id = "+sdrAgent["id"]+") GROUP BY t.agent_Id", conn);
                SqlDataReader sdrTicketCount = cmdGetTicketCount.ExecuteReader();
                if(sdrTicketCount.Read())
                {
                    if(int.Parse(sdrTicketCount["TicketCount"].ToString()) < ticketCount)
                    {
                        agentId = int.Parse(sdrTicketCount["agentId"].ToString());
                        ticketCount = int.Parse(sdrTicketCount["TicketCount"].ToString());
                    }
                }
                else
                {
                    agentId = int.Parse(sdrAgent["id"].ToString());
                    break;
                }
            }
            cmd.Parameters.AddWithValue("@agent_Id", agentId);

            if (agentId == 0)
            {
                return "failed";
            }
            else
            {
                if (cmd.ExecuteNonQuery() > 0)
                {
                    SqlCommand cmdSendEmail = new SqlCommand("SELECT a.id, u.email FROM agents AS a INNER JOIN users AS u ON a.user_Id = u.id WHERE  (a.id = " + agentId + ")", conn);
                    SqlDataReader sdr = cmdSendEmail.ExecuteReader();
                    sdr.Read();
                    email.SendEmail(sdr["email"].ToString(), "HelpDesk :" + title, "New Ticket cerated by <b>" + customerName + "</b><br><br><b>Description:</b> " + description + "<br><b>Priotity</b> : " + priority + "");
                    return "success";
                }
                else
                {
                    return "failed";
                }
                conn.Close();
            }
        }
    }
}