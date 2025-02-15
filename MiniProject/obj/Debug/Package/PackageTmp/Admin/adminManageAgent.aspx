<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true"
    CodeBehind="adminManageAgent.aspx.cs" Inherits="MiniProject.Admin.adminManageAgent" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            .agent {
                flex: 1;
                padding: 0px 20px;
            }

            .filter-bar,
            .addBtn {
                margin-bottom: 20px;
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
                align-items: center;
                justify-content: space-between;
            }

            .status-open {
                color: white;
                background-color: red;
                padding: 5px 10px;
                border-radius: 3px;
            }

            .status-in-progress {
                color: white;
                background-color: orange;
                padding: 5px 10px;
                border-radius: 3px;
            }

            .status-closed {
                color: white;
                background-color: green;
                padding: 5px 10px;
                border-radius: 3px;
            }

            .dlTable {
                display: grid;
                height: 65%;
                overflow-y: auto;
                border-radius: 5px;
                border: 1px solid #ccc;
                padding: 5px;

                br {
                    display: none;
                }
            }

            .no-data {
                text-align: center;
                font-size: 1.6em;
                color: red;
                margin: 20px 0;
            }

            .addBtn {
                padding: 10px 15px;
                box-sizing: border-box;
                border: 1.5px solid #afa9a9;
                border-radius: 5px;
                cursor: pointer;
                background: #000;
                color: #fff;
                font-size: 15px;
                transition: all 0.3s ease-in-out;
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .addBtn:hover {
                background: #fff;
                color: #000;
                border: 1px solid #000;
            }

            .create-main-container {
                position: absolute;
                width: 100vw;
                background: #2c2c2c6b;
                padding: 0px 20px;
                right: 0;
                height: 100vh;
                z-index: 999;
                display: none;
                justify-content: center;
                align-items: center;
            }

            .create-container {
                width: 370px;
                height: fit-content;
                border-radius: 10px;
                background: #fff;
                padding: 0px 15px 15px 15px;

                h1 {
                    border-bottom: 1px solid #ccc;
                    font-size: 22px;
                    padding-bottom: 5px;
                }
            }

            .inp-group {
                display: flex;
                justify-content: space-between;
                flex-direction: column;
                gap: 3px;
                margin: 10px 0px;
            }

            .label {
                font-size: 14px;
            }

            .crossBtn {
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

            .crossBtn:hover {
                transform: scale(1.1);
            }

            .input {
                padding: 8px;
                outline: none;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .btnContainer {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
                padding: 10px 0px 0px 0px;
                border-top: 1px solid #ccc;

                .resetFormBtn {
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

                .addFormBtn {
                    background: #333;
                    padding: 5px 10px;
                    border-radius: 5px;
                    border: none;
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

            .lblMessage {
                .msg {
                    display: flex;
                    justify-content: flex-start;
                    align-items: center;
                    padding: 5px;
                    background: red;
                    margin-top: 10px;
                    border-radius: 5px;
                    color: #fff;
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
        </style>
        <script>
            function addFormOpen() {
                document.getElementById("createForm").style.display = 'flex';
                //document.getElementById("agentContent").style.display = 'none';
            }
            function closeCreateForm() {
                document.getElementById("createForm").style.display = 'none';
                const cl = document.getElementsByClassName("input")
                for (let index = 0; index < cl.length - 1; index++) {
                    cl[index].value = "";
                }
                $(".lblMessage").html("");
            }

        </script>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="agent" id="agentContent">
            <h2>Agents</h2>
            <div class="filterData">
                <div class="filter-bar">
                    <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged1">
                    </asp:DropDownList>
                </div>
                <div class="addBtn" onclick="addFormOpen()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewbox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                        class="lucide lucide-circle-plus mr-2 h-4 w-4">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M8 12h8"></path>
                        <path d="M12 8v8"></path>
                    </svg>
                    Add New Agent
                </div>
            </div>
            <div class="dlTable">
                <asp:DataList ID="dlAgents" runat="server" RepeatLayout="Flow">
                    <HeaderTemplate>
                        <table cellspacing="0">
                            <thead>
                                <tr>
                                    <th>
                                        ID
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Email
                                    </th>
                                    <th>
                                        Password
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
                                <%# ((DataListItem)Container).ItemIndex + 1 %>
                            </td>
                            <td>
                                <%# Eval("agentname") %>
                            </td>
                            <td>
                                <%# Eval("email") %>
                            </td>
                            <td>
                                <%# Eval("password") %>
                            </td>
                            <td>
                                <%# Eval("department") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:DataList>
                <asp:Label Text="No Agent Found" ID="lblNoData" CssClass="no-data" runat="server" />
            </div>
        </div>
        <%-- //Add Agents--%>
            <div class="create-main-container" id="createForm">
                <div class="create-container">
                    <asp:Label Text="" CssClass="lblMessage" ID="lblMessage" runat="server" />
                    <h3 class="crossBtn" onclick="closeCreateForm()">
                        x</h3>
                    <h1>
                        Add Agent</h1>
                    <div class="inp-group">
                        <asp:Label Text="Name" CssClass="label" ID="lblName" runat="server" />
                        <asp:TextBox runat="server" placeholder="Enter name" CssClass="input" ID="txtName" />
                    </div>
                    <div class="inp-group">
                        <asp:Label Text="Email" CssClass="label" ID="lblEmail" runat="server" />
                        <asp:TextBox runat="server" placeholder="Enter email" CssClass="input" ID="txtEmail" />
                    </div>
                    <div class="inp-group">
                        <asp:Label Text="Password" CssClass="label" ID="lblPassword" runat="server" />
                        <asp:TextBox runat="server" placeholder="Enter password" CssClass="input" ID="txtPassword" />
                    </div>
                    <div class="inp-group">
                        <asp:Label Text="Confirm Password" CssClass="label" ID="lblConPassword" runat="server" />
                        <asp:TextBox runat="server" placeholder="Enter confirm password" CssClass="input"
                            ID="txtConPassword" />
                    </div>
                    <div class="inp-group">
                        <asp:Label Text="Department" CssClass="label" ID="lblDepartment" runat="server" />
                        <asp:DropDownList ID="ddlFormDepartment" runat="server" CssClass="input">
                        </asp:DropDownList>
                    </div>
                    <div class="btnContainer">
                        <input type="reset" name="reset" value="Reset" class="resetFormBtn" />
                        <asp:Button ID="addAgent" CssClass="addFormBtn" Text="Save" runat="server"
                            OnClick="addAgent_Click" />
                    </div>
                </div>
            </div>
    </asp:Content>