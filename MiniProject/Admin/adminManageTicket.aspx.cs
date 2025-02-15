using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace MiniProject.Admin
{
    public partial class adminManageTicket : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminName"] != null)
            {
                if (!IsPostBack)
                {
                    getAllTickets("All");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
           
        }
        public void getAllTickets(string searchPriority)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            string query = "SELECT t.id, t.title, c.username AS customer, t.status, t.priority, t.created_at, u.username AS assignedTo, d.dep_name AS department FROM tickets AS t INNER JOIN agents AS a ON t.agent_Id = a.id INNER JOIN users AS u ON a.user_Id = u.id INNER JOIN department AS d ON a.department_Id = d.id INNER JOIN users AS c ON t.customer_Id = c.id"; 
            if (searchPriority != "All") 
            {
                query += " WHERE t.priority = @Priority"; 
            } 
            SqlDataAdapter sda = new SqlDataAdapter(query, conn); 
            if (searchPriority != "All") 
            { 
                sda.SelectCommand.Parameters.AddWithValue("@Priority", searchPriority);
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
            getAllTickets(ddlPriority.SelectedValue);
        }
    }
}