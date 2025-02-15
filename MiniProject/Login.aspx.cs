using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Threading;

namespace MiniProject
{
    public partial class Login : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            int checkUser = IsValidUser(email, password);
            if (checkUser == 1)
            {
                setAdminSession(email);
                Response.Redirect("/Admin/adminDashboard.aspx");
            }
            else if (checkUser == 2)
            {
                setAggentSession(email);
                Response.Redirect("/Agent/agentDashboard.aspx");
                
            }
            else if(checkUser == 3)
            {
                setCustomerSession(email);
                Response.Redirect("/Customer/customerDashboard.aspx");

            }
            else
            {

                //Response.Write("Inavlid Credential");
                msgError.InnerHtml = "<div class='lblMessage'>Inavlid Credential</div>";
            }
        }
        private int IsValidUser(string email, string password) 
        {
            //role 1 = Admin
            //role 2 = Agent
            //role 3 = Customer
            using (SqlConnection conn = new SqlConnection(dbConn)) 
            {
                string query = "SELECT * FROM users WHERE email='" + email + "' AND password='"+password+"'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();                
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // If a matching record is found, fetch the role
                    int role = int.Parse(reader["role"].ToString());
                    if (role == 1)
                    {
                        return 1;
                    }
                    else if (role == 2)
                    {
                        return 2;
                    }
                    else if (role == 3)
                    {
                        return 3;
                    }
                    else
                    {
                        return 4;
                    }
                }
                conn.Close();
                return 4;
            } 
            return 4;
        }
        public void setAggentSession(string email)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT a.id, u.username, u.password, u.email, u.role FROM agents AS a INNER JOIN users AS u ON a.user_Id = u.id WHERE (u.email = '"+email+"')", conn); 
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                Session["agentId"] = sdr["id"].ToString();
                Session["agentName"] = sdr["username"].ToString();
                Session["agentEmail"] = sdr["email"].ToString();
                Session["agentRole"] = 2;
            }
            else
            {
                msgError.InnerHtml = "<div class='lblMessage'>Something Went Wrong</div>";
                //Response.Write("Something Went Wrong");
            }

        }
        public void setAdminSession(string email)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT * from users WHERE email = '" + email + "'", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                Session["adminId"] = sdr["id"].ToString();
                Session["adminName"] = sdr["username"].ToString();
                Session["adminEmail"] = sdr["email"].ToString();
                Session["adminRole"] = 1;
            }
            else
            {
                msgError.InnerHtml = "<div class='lblMessage'>Something Went Wrong</div>";
                //Response.Write("Something Went Wrong");
            }

        }
        public void setCustomerSession(string email)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            SqlCommand cmd = new SqlCommand("SELECT * from users WHERE email = '" + email + "'", conn);
            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                Session["customerId"] = sdr["id"].ToString();
                Session["customerName"] = sdr["username"].ToString();
                Session["customerEmail"] = sdr["email"].ToString();
                Session["customerRole"] = 3;
            }
            else
            {
                msgError.InnerHtml= "<div class='lblMessage'>Something Went Wrong</div>";
                //Response.Write("Something Went Wrong");
            }

        }
    }
}