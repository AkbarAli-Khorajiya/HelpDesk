<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MiniProject.Login" %>

<!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <style type="text/css">
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: grid;
                place-content: center;
                width: 100%;
                height: 100vh;
            }

            .login-container {
                width: 300px;
                display: flex;
                flex-direction: column;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                p
                {
                font-size: 13px;
                text-align:right;
                }
            }

            h2 {
               border-bottom: 1px solid #ccc;
                padding-bottom: 15px;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="password"] {
                padding: 0.75rem;
                font-size: 0.875rem;
                margin: 10px 0;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                width: 100%;
                padding: 0.75rem;
                margin-top: 10px;
                border: none;
                border-radius: 4px;
                background-color: #333;
                color: white;
                cursor: pointer;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: #333333be;
            }
            #msgError{
                .lblMessage {
                    background: red;
                    color: #fff;
                    border-radius: 5px;
                    padding: 5px;
                }
            }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="login-container">
        <div id="msgError" runat="server">
        </div>
        <h2>
            LogIn</h2>
        <asp:TextBox AutoCompleteType="Email" ID="txtEmail" runat="server" placeholder="Enter email"></asp:TextBox>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
        <p>
            <a href="ForgetPass.aspx" style="text-decoration: none; color: rgb(73, 73, 204)">Forget
                Password?</a></p>
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        <div style="display: flex; justify-content: center; margin-top: 10px">
            <p>
                Don't have an Account? <a href="Registration.aspx" style="text-decoration: none;
                    color: rgb(73, 73, 204)">SignUp</a></p>
        </div>
    </div>
    </form>
</body>
</html>
