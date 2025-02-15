<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/customer.Master" AutoEventWireup="true"
    CodeBehind="customerTickets.aspx.cs" Inherits="MiniProject.Customer.customerTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
            .ticket {
                flex: 1;
                padding: 0px 20px;
            }

            .search-bar
            {
                display: flex;
                align-items: center;
                gap: 3px;
            }
            .filter-bar {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .search-button
            {
                width: 10%;
                background-color: black;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
            }

            .search-bar input
            {
                flex: 1;
                padding: 10px;
                margin: 10px 0;
                box-sizing: border-box;
                border: 1.5px solid #afa9a9;
                border-radius: 5px;
                }
            .filter-bar select {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                box-sizing: border-box;
                border: 1.5px solid #afa9a9;
                border-radius: 5px;
            }

            table {
                width: 100%;
                border-radius: 5px;
                border-collapse: collapse;
            }

            tbody {
                tr:nth-child(even) {
                    background-color: rgba(184, 184, 184, 0.162);
                }
            }

            thead {
                tr {
                    th {
                        background-color: #000;
                        color: #fff;
                        padding-top: 10px;
                        padding-bottom: 10px;
                    }
                }
            }

            th,
            td {
                border: 1px solid #ddd;
                padding: 8px;
            }

            th {
                background-color: #f2f2f2;
                text-align: left;
            }

            .filterData {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
            }

            .status-open {
                color: white;
                background-color: red;
                padding: 2px 10px;
                width: fit-content;
                display: flex;
                border-radius: 50px;
                align-items: center;
                justify-content: center;
            }

            .status-in-progress {
                color: white;
                background-color: orange;
                padding: 2px 10px;
                width: fit-content;
                display: flex;
                border-radius: 50px;
                align-items: center;
                justify-content: center;
            }

            .status-closed {
                color: white;
                background-color: green;
                padding: 2px 10px;
                width: fit-content;
                display: flex;
                border-radius: 50px;
                align-items: center;
                justify-content: center;
            }

            .dlTable 
            {
                height: 65%;
                border-radius:5px;
                border: 1px solid #ccc;
                padding:5px;
                display:grid;
                overflow-y: auto;
                br {
                    display: none;
                }
            }
            ::-webkit-scrollbar {
                width: 5px;
                /* Width of the scrollbar */
            }

            ::-webkit-scrollbar-track {
                background: #d2d2d280;
                /* Background of the scrollbar track */
            }

            ::-webkit-scrollbar-thumb {
                background: #888;
                /* Color of the scrollbar thumb */
                border-radius: 6px;
                /* Rounded corners */
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #555;
                /* Color of the scrollbar thumb on hover */
            }

            .assign-button {
                background-color: black;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
            }
            .createBtn {
                padding: 8px 10px;
                box-sizing: border-box;
                border: 1.5px solid #afa9a9;
                border-radius: 5px;
                cursor: pointer;
                background: #000;
                color: #fff;
                font-size: 15px;
                width:100%;
                transition: all 0.3s ease-in-out;
                display: flex;
                gap: 8px;
                align-items: center;
            }
            .create-main-container
            {
                position: absolute;
                width: 100vw;
                background: #2c2c2c6b;
                padding: 0px 20px;
                right: 0;
                height: 100vh;
                z-index: 999;
                display:none;
                justify-content:center;
                align-items:center;
            }
            .create-container
            {
                width: 370px;
                height: fit-content;
                border-radius: 10px;
                background: #fff;
                padding: 0px 15px 15px 15px;
                h1
                {
                    border-bottom: 1px solid #ccc;
                    font-size:22px;
                    padding-bottom: 5px;
                }
            }
            
            .inp-group
            {
                display: flex;
                justify-content: space-between;
                flex-direction: column;
                gap:3px;
                margin: 10px 0px ;
            }
            .label
            {
                font-size:14px;
                display: flex;
                justify-content: space-between;
            }
            .crossBtn
            {
                float: right;
                display: flex;
                border: 1px solid #000;
                align-items: center;
                cursor: pointer;
                border-radius: 50%;
                padding: 4px 6px 8px 6px;
                width: 5px;
                height: 5px;
                justify-content: center;
            }
            .crossBtn:hover
            {
                transform:scale(1.1);
            }
            .input
            {
                padding:8px;
                outline:none;
                border-radius: 5px;
                border:1px solid #ccc;
            }
            .btnContainer
            {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
                padding: 10px 0px 0px 0px;
                border-top: 1px solid #ccc;
                .resetFormBtn
                {
                    background: #ccc;
                    padding: 5px 10px;
                    border-radius: 5px;
                    border: none;
                    color: #000;
                    font-size: 16px;
                    height: fit-content;
                    border: 1px solid #ccc;
                    &:hover {
                        background: #fff;
                        color: #000;
                        border: 1px solid #333;
                    }
                }
                .addFormBtn
                {
                    background: #333;
                    padding: 5px 10px;
                    border-radius: 5px;
                    border: none;
                    cursor: pointer;
                    color: #fff;
                    font-size: 16px;
                    border: 1px solid #333;
                    &:hover {
                        background: #fff;
                        color: #000;
                        border: 1px solid #333;
                    }
                }
            }
            .no-data  
            {
                text-align: center; 
                font-size: 1.6em; 
                color: red; 
                margin: 20px 0; 
            }
        </style>
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ticket">
        <h2>Tickets</h2>
        <div class="filterData">
            <div class="search-bar">
                <asp:TextBox ID="txtSearch" TextMode="Search" runat="server" AutoPostBack="true" OnTextChanged="TextBox1_TextChanged" placeholder="Search tickets..."></asp:TextBox>
            </div>
            <div class="filter-bar">
                <asp:DropDownList ID="ddlPriority" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPriority_SelectedIndexChanged">
                    <asp:ListItem Value="All" Text="-- Filter by Priority --"></asp:ListItem>
                    <asp:ListItem Value="All" Text="All"></asp:ListItem>
                    <asp:ListItem Value="Low" Text="Low"></asp:ListItem>
                    <asp:ListItem Value="Medium" Text="Medium"></asp:ListItem>
                    <asp:ListItem Value="High" Text="High"></asp:ListItem>
                </asp:DropDownList>
                <div class="createBtn" onclick="addFormOpen()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-plus mr-2 h-4 w-4">
                            <circle cx="12" cy="12" r="10"></circle>
                            <path d="M8 12h8"></path>
                            <path d="M12 8v8"></path>
                        </svg>
                    Create Ticket
                </div>
            </div>
        </div>
        <div class="dlTable">
            <asp:DataList ID="dlTickets" runat="server" RepeatLayout="Flow">
                <HeaderTemplate>
                    <table cellspacing="0">
                        <thead>
                            <tr>
                                <th>
                                    Ticket ID
                                </th>
                                <th>
                                    Title
                                </th>
                                <th>
                                    Status
                                </th>
                                <th>
                                    Priority
                                </th>
                                <th>
                                    Assignee
                                </th>
                                <th>
                                    Department
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%# Eval("id") %>
                        </td>
                        <td>
                            <a href="<%# "ViewTicket.aspx?id=" + Eval("id") %>">
                                <%# Eval("title") %></a>
                        </td>
                        <td>
                            <span class='<%# Eval("status").ToString().ToLower() == "open" ? "status-open" : 
                                        (Eval("status").ToString().ToLower() == "closed" ? "status-closed" : "status-in-progress") %>'>
                                <%# Eval("status") %>
                            </span>
                        </td>
                        <td>
                            <%# Eval("priority") %>
                        </td>
                        <td>
                            <%# Eval("assignee")%>
                        </td>
                        <td>
                            <%# Eval("department") %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:DataList>
            <asp:Label Text="No Tickets Found" ID="lblNoData" CssClass="no-data" runat="server" />
        </div>
    </div>
    <%--//Create Tickets--%>
    <div class="create-main-container" id="createForm">
        <div class="create-container">
            <h3 class="crossBtn" onclick="closeCreateForm()">x</h3>
            <h1>Create Ticket</h1>
            <div class="inp-group">
                <div class="label" id="lblTicketTitle">
                    Title
                    <span style="color: red; font-size: 13px;" id="msgTitle"></span>
                </div>
                <input type="text" name="txtTicketTitle" class="input"  placeholder="Enter name" id="txtTicketTitle">
            </div>
            <div class="inp-group">
                <div class="label" id="lblDescription">
                    Description
                    <span style="color: red; font-size: 13px;" id="msgDescription"></span>
                </div>
                <textarea rows="5" name="txtDescription" class="input" placeholder="Enter description" id="txtDescription"></textarea>
            </div>
            <div class="inp-group">
                <div class="label" id="lblTicketPriority">
                    Priority
                    <span style="color: red; font-size: 13px;" id="msgPriority"></span>
                </div>
                <select name="ddlTicketPriority" class="input" id="ddlTicketPriority">
                    <option selected="selected" hidden>--Select Priority--</option>
                    <option value="Low">Low</option>
                    <option value="Medium">Medium</option>
                    <option value="High">High</option>
                </select>
            </div>
            <div class="inp-group">
                <div class="label" id="lblDepartment">
                    Department
                    <span style="color: red; font-size: 13px;" id="Department"></span>
                </div>
                <asp:DropDownList ID="ddlFormDepartment" runat="server" CssClass="input">
                </asp:DropDownList>
            </div>
            <div class="btnContainer">
                <input type="reset" name="reset" value="Reset" class="resetFormBtn" />
                <div id="addTicket" class="addFormBtn" >
                    Save
                </div>
            </div>
        </div>
    </div>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            function addFormOpen() {
                document.getElementById("createForm").style.display = 'flex';
            }
            function closeCreateForm() {
                document.getElementById("createForm").style.display = 'none';
                const cl = document.getElementsByClassName("input")
                for (let index = 0; index <cl.length - 2 ; index++) {
                    cl[index].value = "";
                }
                $("#msgTitle").text("");
                $("#msgDescription").text("");
                $("#msgPriority").text("");
            }
            $("#addTicket").click(async function () {
                var title = $("#txtTicketTitle").val();
                var description = $("#txtDescription").val();
                var priority = $("#ddlTicketPriority").val();
                var department = $('#<%= ddlFormDepartment.ClientID %>').val();
                if (title == "" ) {
                    $("#msgTitle").text("Title is required");
                    return;
                }
                else {
                    $("#msgTitle").text("");
                }
                if (description == "") {
                    $("#msgDescription").text("Description is required");
                    return;
                }
                else {
                    $("#msgDescription").text("");
                }
                if (priority == "--Select Priority--") {
                    $("#msgPriority").text("Priority is required");
                    return;
                }
                else {
                    $("#msgPriority").text("");
                }
                                           
                $(".loader").show();

                await $.ajax({
                    type: "POST",
                    url: "customerTickets.aspx/sendTicketData",
                    data: JSON.stringify({ title: title, description: description, priority: priority, department: department }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log(response.d)
                        if (response.d == "success") {
                            closeCreateForm();
                            window.location.reload();
                        }
                        else {
                            $(".loader").fadeOut();
                            alert("Failed to create ticket");
                        }
                    }
                });
            });
        </script>
    
</asp:Content>
