<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true"
    CodeBehind="adminManageUser.aspx.cs" Inherits="MiniProject.Admin.adminManageUser" %>

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
                display:none;
                justify-content:center;
                align-items:center;
            }

            .create-container {
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
            .search-bar
            {
                display: flex;
                align-items: center;
                gap: 3px;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="agent" id="agentContent">
        <h2>
            Users</h2>
        <div class="filterData">
            <div class="filter-bar">
                <div class="search-bar">
                    <asp:TextBox ID="txtSearch" TextMode="Search" runat="server" 
                        AutoPostBack="true" placeholder="Search tickets..." 
                        ontextchanged="txtSearch_TextChanged"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="dlTable">
            <asp:DataList ID="dlUsers" runat="server" RepeatLayout="Flow">
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
                            <%# Eval("username") %>
                        </td>
                        <td>
                            <%# Eval("email") %>
                        </td>
                        <td>
                            <%# Eval("password") %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:DataList>
            <asp:Label Text="No Users Found" ID="lblNoData" CssClass="no-data" runat="server" />
        </div>
    </div>
</asp:Content>
