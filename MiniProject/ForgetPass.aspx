<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPass.aspx.cs" Inherits="MiniProject.webConfig.ForgetPass" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forget Password</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .container {
          display: flex;
          justify-content: center;
          align-items: center;
          min-height: 100vh;
          background-color: #f5f5f5;
          font-family: system-ui, -apple-system, sans-serif;
        }

        .card {
          width: 100%;
          max-width: 300px;
          height:fit-content;
          padding: 1.5rem;
          background-color: white;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          /*text-align: center;*/
        }

        .icon {
          margin: 0 auto;
          width:80px;
          height:80px;
          border-radius: 50%;
        }
        .icon-wrapper
        {
            display: flex
;
    justify-content: center;
}
            }

        .title 
        {
          text-align: center;            
          font-size: 1.5rem;
          font-weight: 600;
          color: #333;
          margin-bottom: 1rem;
        }

        .description {
          color: #666;
          font-size: 0.875rem;
          margin-bottom: 1.5rem;
        }

        .form {
          display: flex;
          flex-direction: column;
          gap: 10px;
        }

        .input {
          width: 100%;
          padding: 0.75rem;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 0.875rem;
          box-sizing: border-box;
        }
        .label
        {
            text-align:center
            }

        .input:focus {
          outline: none;
          border-color: #22c55e;
          box-shadow: 0 0 0 2px rgba(34, 197, 94, 0.1);
        }

        .error-message {
          color: #dc2626;
          font-size: 0.75rem;
          margin: 0;
          text-align: left;
          display:none;
        }

        .submit-button {
          background-color: #333;
          color: white;
          padding: 0.75rem;
          border: none;
          border-radius: 4px;
          font-size: 0.875rem;
          cursor: pointer;
          font-weight: 500;
          margin-top: 0.5rem;
          transition: background-color 0.2s;
        }

        .submit-button:hover {
          background-color: #333333be;
        }

        .back-link {
          display: flex;
          justify-content:center;
          margin-top: 1.5rem;
          color: #666;
          font-size: 0.875rem;
          text-decoration: none;
          transition: color 0.2s;
        }

        .back-link:hover {
          color: #333;
        }
        .resend
        {
            background: #fff;
            outline: none;
            border: none;
            text-align: right;
            color: #0000ffd6;
            cursor: pointer;
        }
        #msgError{
            .lblMessage {
                background: red;
                color: #fff;
                border-radius: 5px;
                padding: 5px;
            }
       }
       #msgError1{
            .lblMessage {
                background: red;
                color: #fff;
                border-radius: 5px;
                padding: 5px;
            }
       }
       #msgError2{
            .lblMessage {
                background: red;
                color: #fff;
                border-radius: 5px;
                padding: 5px;
            }
       }
        @media (max-width: 640px) {
          .card {
            margin: 1rem;
            padding: 1.5rem;
          }
        }
      }
      
    </style>
    <script>
        setTimeout(function () {
            $(".lblMessage").hide();
        }, 2500)
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:MultiView ActiveViewIndex="0" ID="mvForget" runat="server">
        <asp:View runat="server">
            <div class="container">
                <div class="card">
                    <div id="msgError" runat="server">
                    </div>
                    <div class="icon-wrapper">
                        <img src="./assets/alert.jpg" alt="Forgot Password Icon" class="icon" />
                    </div>
                    <h1 class="title" style="text-align: center">
                        Forgot Password</h1>
                    <p class="description" style="text-align: center">
                        Enter your email and we&apos;ll send you a OTP to reset your password.</p>
                    <div class="form">
                        <asp:TextBox runat="server" ID="txtEmail" TextMode="Email" placeholder="xyz@gmail.com"
                            CssClass="input" />
                        <asp:Label CssClass="error-message" Text="We cannot find your email." runat="server" />
                        <asp:Button ID="sendOtp" Text="Send" runat="server" CssClass="submit-button" OnClick="sendOtp_Click" />
                    </div>
                    <a href="/Login.aspx" class="back-link">← Back to Login</a>
                </div>
            </div>
        </asp:View>
        <asp:View ID="View1" runat="server">
            <div class="container">
                <div class="card">
                    <div id="msgError1" runat="server">
                    </div>
                    <h1 class="title" style="text-align: center; margin-top: 0px !important">
                        Forgot Password</h1>
                    <p class="description" style="text-align: center;">
                        Please enter the verification OTP code we send.</p>
                    <div class="form">
                        <asp:TextBox ID="txtOtp" runat="server" placeholder="Enter 6 digit password" CssClass="input" />
                        <asp:Label ID="Label1" CssClass="error-message" Text="We cannot find your email."
                            runat="server" />
                        <asp:Button ID="btnVerify" Text="Verify" runat="server" CssClass="submit-button"
                            OnClick="btnVerify_Click" />
                    </div>
                    <a href="/Login.aspx" class="back-link">← Back to Login</a>
                </div>
            </div>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="container">
                <div class="card">
                    <div id="msgError2" runat="server">
                    </div>
                    <h1 class="title" style="text-align: center; margin-top: 0px !important">
                        Change Password</h1>
                    <div class="form">
                        <div>
                            New Password</div>
                        <asp:TextBox ID="txtPass" runat="server" placeholder="Enter new password" CssClass="input" />
                        <asp:Label ID="lblPass" CssClass="error-message" runat="server" />
                        <div>
                            Confirm Password</div>
                        <asp:TextBox ID="txtConPass" runat="server" placeholder="Enter confirm password"
                            CssClass="input" />
                        <asp:Label ID="lblConPass" CssClass="error-message" runat="server" />
                        <asp:Button ID="btnChangePass" Text="Change Password" runat="server" CssClass="submit-button"
                            OnClick="btnChangePass_Click" />
                    </div>
                    <a href="/Login.aspx" class="back-link">← Back to Login</a>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>
    </form>
</body>
</html>
