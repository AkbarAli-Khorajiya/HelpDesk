using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaskManagement.config;
using System.Configuration;
using System.Data.SqlClient;

namespace MiniProject.webConfig
{
    public partial class ForgetPass : System.Web.UI.Page
    {
        public static string otp = "";
        public static string inputEmail = "";
        public static string dbConn = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sendOtp_Click(object sender, EventArgs e)
        {
            if (checkEmailExist(txtEmail.Text))
            {
                Session["email"] = txtEmail.Text;
                EmailService email = new EmailService();
                otp += OTPService.GenerateOTP();
                email.SendEmail(txtEmail.Text, "OTP for Password Reset", "Use OTP " + otp + " to reset your password.");
                mvForget.ActiveViewIndex = 1;
            }
            else
            {
                msgError.InnerHtml = "<div class='lblMessage'>Email not Valid</div>";
            }
            
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            DateTime currentTime = DateTime.Now;
            if (OTPService.VerifyOTP(otp, txtOtp.Text, currentTime))
            {
                mvForget.ActiveViewIndex = 2;
            }
            else
            {
                msgError1.InnerHtml = "<div class='lblMessage'>OTP is incorrect or expired.</div>";
            }

        }
        public bool checkEmailExist(string email)
        {
            SqlConnection conn = new SqlConnection(dbConn);
            conn.Open();
            SqlCommand cmd = new SqlCommand("Select email from users where email = @email ",conn);
            cmd.Parameters.AddWithValue("@email", email);
            SqlDataReader sdr = cmd.ExecuteReader();
            
            if (sdr.Read())
            {
                if (email == sdr["email"].ToString())
	            {
                    conn.Close();
                    return true;
	            }
                else
                {
                    conn.Close();
                    return false;
                }
            }
            else
            {
                return false;
            }

        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            if (txtPass.Text == txtConPass.Text)
            {
                SqlConnection conn = new SqlConnection(dbConn);
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE users set password = @pass where email = @email", conn);
                cmd.Parameters.AddWithValue("@pass", txtPass.Text);
                cmd.Parameters.AddWithValue("@email", Session["email"].ToString());
                if (cmd.ExecuteNonQuery() > 0)
                {
                    conn.Close();
                    Response.Redirect("./Login.aspx");
                }
            }
            else
            {
                msgError2.InnerHtml = "<div class='lblMessage'>Password must be same</div>";
            }
        }
    }
}