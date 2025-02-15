using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;

namespace MiniProject
{
    public partial class Registration : System.Web.UI.Page
    {
        static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string RegisterUser(string username, string email, string password)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmdSelect = new SqlCommand("SELECT * FROM users WHERE username = '" + username + "' OR email = '" + email + "'", conn);
            SqlDataReader dr = cmdSelect.ExecuteReader();
            if (dr.HasRows)
            {
                return "User already exists";
            }
            conn.Close();

            string query = "INSERT INTO users (username, email, password, role) VALUES ('" + username + "', '" + email + "', '" + password + "',3)";
            conn.Open();
            SqlCommand cmd = new SqlCommand(query, conn);
            if (cmd.ExecuteNonQuery() > 0)
            {
                return "Success";
            }
            else
            {
                return "Failed";
            }
            conn.Close();

        }
    }
}