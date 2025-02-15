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
    public partial class adminManageUser : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminName"] != null)
            {
                if (!IsPostBack)
                {
                    getAllUsers("0");
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }
        public void getAllUsers(string search)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            DataSet ds = new DataSet();
            if (search == "0")
            {
                SqlDataAdapter sda = new SqlDataAdapter("Select * from users where role = 3", conn);
                sda.Fill(ds);
            }
            else
            {
                SqlDataAdapter sda = new SqlDataAdapter("Select * from users where role = 3 and (username like '%" + search + "%' or email like '%" + search + "%')", conn);
                sda.Fill(ds);
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblNoData.Visible = false;
                dlUsers.DataSource = ds;
                dlUsers.DataBind();
            }
            else
            {
                lblNoData.Visible = true;
                dlUsers.DataSource = ds;
                dlUsers.DataBind();
            }
            
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            getAllUsers(txtSearch.Text);
        }
    }
}