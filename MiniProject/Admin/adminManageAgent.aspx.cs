using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using TaskManagement.config;

namespace MiniProject.Admin
{
    public partial class adminManageAgent : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminName"] != null)
            {
                if (!IsPostBack)
                {
                    getAllAgents("0");
                    getDepartment();
                    getFormDepartment();
                }
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }
        public void getAllAgents(string depar_Id)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            DataSet ds = new DataSet();
            if (depar_Id == "0")
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT a.id, d.dep_name AS department, u.username AS agentname, u.password, u.email FROM agents AS a INNER JOIN users AS u ON a.user_Id = u.id INNER JOIN department AS d ON a.department_Id = d.id", conn);
                sda.Fill(ds);

            }
            else
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT a.id, d.dep_name AS department, u.username AS agentname, u.password, u.email FROM agents AS a INNER JOIN users AS u ON a.user_Id = u.id INNER JOIN department AS d ON a.department_Id = d.id WHERE  (d.id = "+depar_Id+")", conn);
                sda.Fill(ds);
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblNoData.Visible = false;
                dlAgents.DataSource = ds;
                dlAgents.DataBind();
            }
            else
            {
                lblNoData.Visible = true;
                dlAgents.DataSource = ds;
                dlAgents.DataBind();
            }
            
        }
        public void getDepartment()
        {
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM department", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            ddlDepartment.DataSource = sdr;
            ddlDepartment.DataTextField = "dep_name";
            ddlDepartment.DataValueField = "id";
            ddlDepartment.DataBind();
        }
        public void getFormDepartment()
        {
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            
            SqlCommand cmd = new SqlCommand("SELECT * FROM department", conn);
            SqlDataReader sdr = cmd.ExecuteReader();

            ddlFormDepartment.DataSource = sdr;
            ddlFormDepartment.DataTextField = "dep_name";
            ddlFormDepartment.DataValueField = "id";
            ddlFormDepartment.DataBind();
            conn.Close();
        }

        protected void addAgent_Click(object sender, EventArgs e)
        {
            EmailService email = new EmailService();
            email.SendEmail(txtEmail.Text.ToString(), "HelpDesk : Your login credential", "You are now agent of HelpDesk<br>Resgister with below password<br>Password:" + txtPassword.Text + "<br>Department:" + ddlDepartment.SelectedItem);                            

            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT * FROM agents AS a INNER JOIN users AS u ON a.user_Id = u.id WHERE (u.email = '"+txtEmail.Text+"')",conn);
            SqlDataReader sdrCheck = cmd.ExecuteReader();
            if (!sdrCheck.Read() && sdrCheck.HasRows == false)
            {
                using (SqlCommand cmdUser = new SqlCommand("INSERT INTO users (username, password, email, role) VALUES (@Name, @Password, @Email, 2)", conn))
                {
                    cmdUser.Parameters.AddWithValue("@Name", txtName.Text);
                    cmdUser.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmdUser.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmdUser.ExecuteNonQuery();
                }
                SqlCommand cmdGetUser = new SqlCommand("SELECT id FROM users WHERE email = @Email", conn);
                cmdGetUser.Parameters.AddWithValue("@Email", txtEmail.Text);
                SqlDataReader sdr = cmdGetUser.ExecuteReader();
                if (sdr.Read())
                {
                    int userId = int.Parse(sdr["id"].ToString());
                    conn.Close();
                    conn.Open();
                    using (SqlCommand cmdAgents = new SqlCommand("INSERT INTO agents (department_Id, user_Id) VALUES (@DepartmentId, @UserId)", conn))
                    {
                        cmdAgents.Parameters.AddWithValue("@DepartmentId", ddlFormDepartment.SelectedValue);
                        cmdAgents.Parameters.AddWithValue("@UserId",userId);
                        if (cmdAgents.ExecuteNonQuery() > 0)
                        {
                            Response.Redirect("adminManageAgent.aspx");
                        }
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('This Agent is already present')</script>");
            }
            
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Write("<script>alert('This Agent is already present')</script>");
        }

        protected void ddlDepartment_SelectedIndexChanged1(object sender, EventArgs e)
        {
            getAllAgents(ddlDepartment.SelectedValue);
        }
    }
}