<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="MiniProject.Registration" %>

<!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SignUp</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                overflow: hidden;
            }
            h2
            {
                border-bottom: 1px solid #ccc;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .registration-form {
                background-color: white;
                width: 350px;
                margin: 0 auto;
                padding: 5px 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 15px;
                width:100%;
            }

            .form-label {
                display: block;
                margin-bottom: 5px;
                font-size: 14px;
                display: flex;
                justify-content: space-between;
            }

            .form-control {
                width: 92%;
                padding: 0.75rem;
                font-size: 0.875rem;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .validator {
                color: red;
                font-size: 12px;
            }

            .submit-btn {
                background-color: #333;
                color: white;
                padding: 10px;
                border: none;
                text-align: center;
                border-radius: 4px;
                cursor: pointer;
                margin-top: 20px;
            }

            .submit-btn:hover {
                background-color: #333333be;
            }

            .msgError{
                #lblMessage {
                    background: red;
                    color: #fff;
                    border-radius: 5px;
                    padding: 5px;
                }
            }
        </style>
    <script>
        $(document).ready(function () {
            $("#btnRegister").click(function () {
                let username = $("#txtUsername").val();
                let email = $("#txtEmail").val();
                let password = $("#txtPassword").val();
                let confirmPassword = $("#txtConfirmPassword").val();
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (username == "") {
                    $("#msgName").text("Please enter your name");
                    return false;
                }
                let result = emailRegex.test(email);
                console.log(result);
                if (email == "") {
                    $("#msgName").text("");
                    $("#msgEmail").text("Please enter your email");
                    return false;
                }
                if(result == 0) {
                    $("#msgEmail").text("");
                    $("#msgEmail").text("Invalid email format.");
                    return false;
                } else {
                    $("#msgEmail").text(""); 
                }
                if (password == "") {
                    $("#msgEmail").text("");
                    $("#msgPassword").text("Please enter your password");
                    return false;
                }
                if (confirmPassword == "") {
                    $("#msgPassword").text("");
                    $("#msgConfirmPassword").text("Please enter your confirm password");
                    return false;
                }
                if (password != confirmPassword) {
                    $("#msgConfirmPassword").text("");
                    $("#msgConfirmPassword").text("Password must be same");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "Registration.aspx/RegisterUser",
                    data: JSON.stringify({ username: username, email: email, password: password }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "User already exists") {
                            $(".msgError").html('<div id="lblMessage">User already exists</div>')
                            // $("#lblMessage").text("");
                        } else if (response.d == "Success") {
                            window.location.href = "Login.aspx";
                        } else {
                            $("#lblMessage").text("Data Not Saved");
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="registration-form">
        <div class="msgError">
        </div>
        <h2>
            SignUp</h2>
        <div class="form-group">
            <div class="form-label" id="lblUsername">
                Name <span style="color: red; font-size: 13px;" id="msgName"></span>
            </div>
            <input id="txtUsername" placeholder="Enter name" type="text" class="form-control" />
        </div>
        <div class="form-group">
            <div class="form-label" id="lblEmail">
                Email <span style="color: red; font-size: 13px;" id="msgEmail"></span>
            </div>
            <input id="txtEmail" type="email" placeholder="Enter email" class="form-control" />
        </div>
        <div class="form-group">
            <div class="form-label" id="lblPassword">
                Password <span style="color: red; font-size: 13px;" id="msgPassword"></span>
            </div>
            <input id="txtPassword" type="password" placeholder="Enter password" class="form-control" />
        </div>
        <div class="form-group">
            <div class="form-label" id="lblConfirmPassword">
                Confirm Password <span style="color: red; font-size: 13px;" id="msgConfirmPassword">
                </span>
            </div>
            <input id="txtConfirmPassword" type="password" placeholder="Enter confirm password" class="form-control" />
        </div>
        <div class="form-group">
            <div class="form-group">
                <div id="btnRegister" class="submit-btn">
                    Register
                </div>
            </div>
            <p style="text-align: right; font-size: 13px; text-align:center; margin:20px auto;">
                Do you have an Account? <a href="Login.aspx" style="text-decoration: none; color: rgb(73, 73, 204)">
                    LogIn</a>
            </p>
        </div>
    </form>
</body>
</html>
