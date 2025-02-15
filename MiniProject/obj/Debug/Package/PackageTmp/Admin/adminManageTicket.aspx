<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true"
    CodeBehind="adminManageTicket.aspx.cs" Inherits="MiniProject.Admin.adminManageTicket" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            .ticket {
                flex: 1;
                padding: 0px 20px;
            }

            .search-bar,
            .filter-bar {
                margin-bottom: 20px;
            }

            .search-bar input,
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

            .dlTable {
                height: 65%;
                border-radius: 5px;
                border: 1px solid #ccc;
                padding: 5px;
                display: grid;
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

            .no-data {
                text-align: center;
                font-size: 1.6em;
                color: red;
                margin: 20px 0;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="ticket">
            <h2>
                Tickets</h2>
            <div class="filterData">
                <div class="filter-bar">
                    <asp:DropDownList ID="ddlPriority" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlPriority_SelectedIndexChanged">
                        <asp:ListItem Value="All" Text="-- Filter by Priority --"></asp:ListItem>
                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                        <asp:ListItem Value="Low" Text="Low"></asp:ListItem>
                        <asp:ListItem Value="Medium" Text="Medium"></asp:ListItem>
                        <asp:ListItem Value="High" Text="High"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="dlTable">
                <asp:DataList ID="dlTickets" runat="server" RepeatLayout="Flow" SeparatorStyle-VerticalAlign="Bottom">
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
                                        Customer
                                    </th>
                                    <th>
                                        Status
                                    </th>
                                    <th>
                                        Priority
                                    </th>
                                    <th>
                                        Assign To
                                    </th>
                                    <th>
                                        Department
                                    </th>
                                    <th>
                                        Created Date
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
                                <a href="<%# " ViewTicket.aspx?id="+ Eval(" id")%>">
                                    <%# Eval("title") %>
                                </a>
                            </td>
                            <td>
                                <%# Eval("customer") %>
                            </td>
                            <td>
                                <span
                                    class='<%# Eval("status").ToString().ToLower() == "open" ? "status-open" : 
                                        (Eval("status").ToString().ToLower() == "closed" ? "status-closed" : "status-in-progress") %>'>
                                    <%# Eval("status") %>
                                </span>
                            </td>
                            <td>
                                <%# Eval("priority") %>
                            </td>
                            <td>
                                <%# Eval("assignedTo")%>
                            </td>
                            <td>
                                <%# Eval("department")%>
                            </td>
                            <td>
                                <%# Eval("created_at", "{0:yyyy-MM-dd}" ) %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>

                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:DataList>
                <asp:Label Text="No Tickets Found" ID="lblNoData" CssClass="no-data" runat="server" />
            </div>
        </div>
    </asp:Content>