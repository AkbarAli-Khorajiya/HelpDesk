<%@ Page Title="" Language="C#" MasterPageFile="~/Agent/agent.Master" AutoEventWireup="true"
    CodeBehind="agentAssignedTicket.aspx.cs" Inherits="MiniProject.Agent.agentAssignedTicket" %>

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

            .dlTable 
            {
                height: 65%;
                border-radius:5px;
                border: 1px solid #ccc;
                padding:5px;
                display:grid;
                br {
                    display: none;
                }
            }

            .assign-button {
                background-color: black;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
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
        <h2>
            Assigned Tickets</h2>
        <div class="filterData">
            <div class="search-bar">
                <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" placeholder="Search tickets..."
                    OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            </div>
            <div class="filter-bar">
                <asp:DropDownList ID="ddlPriority" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPriority_SelectedIndexChanged">
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
                            <%# Eval("customer") %>
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
</asp:Content>
