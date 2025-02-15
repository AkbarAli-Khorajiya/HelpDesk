using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace MiniProject.Agent
{
    public partial class agentAssignedTicket : System.Web.UI.Page
    {
        static string ticketPriority = "All";
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["agentRole"] != null && int.Parse(Session["agentRole"].ToString()) == 2)
            {
                if (!IsPostBack)
                {
                    getAllAssignedTickets("All", "");

                }
            }
            
            
        }
        public void getAllAssignedTickets(string searchPriority, string search)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            string query = "SELECT t.id, t.title, t.description, u.username AS customer, t.status, t.priority, t.created_at, d.dep_name AS department FROM tickets AS t INNER JOIN agents AS a ON t.agent_Id = a.id INNER JOIN users AS u ON t.customer_Id = u.id INNER JOIN department AS d ON a.department_Id = d.id WHERE  (a.id =  " + int.Parse(Session["agentId"].ToString()) + ") ";
            if (searchPriority != "All" && search == "")
            {
                query += " and t.priority = @Priority";
            }
            else if (searchPriority != "All" && search != "")
            {
                query += " and t.priority = @Priority and t.title like '%'+@title+'%' and u.username like '%'+@customer+'%' and t.status like '%'+@status+'%' and d.dep_name like '%'+@department+'%'";
 
            }
            else if (searchPriority == "All" && search != "")
            {
                query += " and (t.title like '%'+@title+'%' or t.priority like '%'+@Priority+'%' or u.username like '%'+@customer+'%' or t.status like '%'+@status+'%' or d.dep_name like '%'+@department+'%')";

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
                sda.SelectCommand.Parameters.AddWithValue("@customer", search);
                sda.SelectCommand.Parameters.AddWithValue("@status", search);
                sda.SelectCommand.Parameters.AddWithValue("@department", search); 
            }
            else if (searchPriority == "All" && search != "")
            {
                sda.SelectCommand.Parameters.AddWithValue("@Priority", search);
                sda.SelectCommand.Parameters.AddWithValue("@title", search);
                sda.SelectCommand.Parameters.AddWithValue("@customer", search);
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
            getAllAssignedTickets(ticketPriority,txtSearch.Text);

        }
    }
}