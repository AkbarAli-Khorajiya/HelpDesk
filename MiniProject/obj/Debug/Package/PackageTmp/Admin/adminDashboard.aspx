<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true"
    CodeBehind="adminDashboard.aspx.cs" Inherits="MiniProject.Admin.adminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard
        {
            flex: 1;
            padding: 0px 20px;
        }
        
        .header
        {
            margin-bottom: 20px;
        }
        
        .dashboard-card
        {
            display: flex;
            flex-wrap: wrap-reverse;
            gap: 0px;
            column-gap: 20px;
            justify-content: space-between;
        }
        
        .card
        {
            flex: 1 22%;
            background-color: #f9f9f9;
            box-shadow: 0px 0px 10px #bbbbbb69;
            border-radius: 5px;
            padding: 40px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #bbbbbb61;
        }
        
        .card h3
        {
            margin-bottom: 10px;
            font-size: 1.3em;
        }
        
        .card .total
        {
            font-size: 2.3em;
            font-weight: 600;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard">
        <h2>Dashboard</h2>
        <div class="dashboard-card">
            <div class="card">
                <h3>
                    In Progress Tickets</h3>
                <asp:Label ID="lblInProgressTicket" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            <div class="card">
                <h3>
                    Open Tickets</h3>
                <asp:Label ID="lblOpenTicket" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            <div class="card">
                <h3>
                    Closed Tickets</h3>
                <asp:Label ID="lblClosedTicket" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            <div class="card">
                <h3>
                    Total Departments</h3>
                <asp:Label ID="lblTotalDepartments" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            
            <div class="card">
                <h3>
                    Total Agents</h3>
                <asp:Label ID="lblTotalAgent" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            
            <div class="card">
                <h3>
                    Total Customers</h3>
                <asp:Label ID="lblTotalCustomer" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            <div class="card">
                <h3>
                    Total Tickets</h3>
                <asp:Label ID="lblTotalTicket" CssClass="total" runat="server" Text="0"></asp:Label>
            </div>
            
        </div>
    </div>
</asp:Content>
