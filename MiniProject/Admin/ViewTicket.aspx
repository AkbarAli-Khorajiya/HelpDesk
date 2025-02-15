<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true"
    CodeBehind="ViewTicket.aspx.cs" Inherits="MiniProject.Admin.ViewTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
            .main-container {
                margin: 10px;
                display: flex;
                gap: 10px;
                justify-content: space-around;
                height: 90%;
                width: 87% !important;
            }

            .container {
                overflow: auto;
                overflow-x: hidden;
                scrollbar-width: thin;
                background-color: white;
                padding: 20px;
                flex: 1;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .container-conversation {
                overflow: auto;
                overflow-x: hidden;
                scrollbar-width: thin;
                background-color: white;
                padding: 10px;
                flex: 1;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .conversation {
                flex: 1;
                overflow-y: scroll;
                overflow-x: hidden;
                padding: 0px 10px 0px 0px;
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

            .status-Open {
                background-color: #ff0000;
                padding: 4px 7px;
                border-radius: 15px;
                color: #fff;
                width: fit-content;
            }

            .status-InProgress {
                background-color: #ffa500;
                padding: 4px 7px;
                border-radius: 15px;
                color: #fff;
                width: fit-content;
            }

            .status-Closed {
                background-color: #008000;
                padding: 4px 7px;
                border-radius: 15px;
                color: #fff;
                width: fit-content;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: baseline;
                border-bottom: 1px solid #e0e0e0;
                padding-bottom: 10px;
                margin-bottom: 20px;
                gap: 20px;
            }

            .details {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .details div {
                width: 30%;
            }

            .message {
                margin-bottom: 10px;
                background-color: #c5c3c37d;
                padding: 10px 5px 10px 10px;
                width: 70%;
                border-radius: 15px;
                border-bottom-left-radius: 0;
                .timestamp {
                font-size: 0.65em;
                color: #adadad;
            }
            }

            .message p {
                margin: 5px 0;
            }

            .message-text {
                font-size: 13.5px;
            }

            .own {
                background-color: #2d2a2aa5;
                padding: 10px 5px 10px 10px;
                width: 70%;
                color: #fff;
                right: 0%;
                left: 27%;
                position: relative;
                border-radius: 15px;
                border-bottom-right-radius: 0;
                .timestamp {
                    font-size: 0.65em !important;
                    color: #c8c8c8 !important;
                }
            }

            .reply {
                display: flex;
                align-items: center;
                gap: 7px;
                margin-top: 20px;
            }

            .reply .textarea {
                width: 100%;
                height: 35px;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 5px 8px;
                font-size: 14px;
            }

            .reply-btn {
                height: 35px;
                padding: 22.5px 10px;
                background-color: #333;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .main-card {
                background-color: rgb(249, 250, 251);
                border-radius: 8px;
            }

            .sub-main {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            .card {
                display: grid;
                grid-template-columns: 200px 1fr;
                gap: 8px;
            }

            .title {
                color: rgb(107, 114, 128);
                margin-bottom: 10px;
            }

            .line {
                height: 1px;
                background-color: rgb(229, 231, 235);
                margin: 8px 0px;
            }

            .owner {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .user {
                display: flex;
                gap: 5px;
                background: #d2d1d13d;
                align-items: center;
                padding: 1px 10px 1px 0px;
                border-radius: 50px;
            }

            .user-img {
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid #bbbbbb;
                border-radius: 50%;
                width: 25px;
                height: 25px;
                border-radius: 50%;
                overflow: hidden;
            }

            .head-title {
                font-size: 25px;
                margin: 5px 5px 5px 0px;
                font-weight: bold;
                border-bottom: 1px solid #e0e0e0;
                padding-bottom: 10px;
                margin-bottom: 15px;
            }

            .ddlStatusChanged {
                padding: 5px;
                border-radius: 5px;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-container">
        <div class="container">
            <div class="header">
                <h1 style="display: grid;
                grid-template-columns: 200px 1fr;
                gap: 8px;">
                    <asp:Label ID="lblTicketId" runat="server" Style="background-color: #6c6c6c36; padding: 5px;
                        border-radius: 5px; width:fit-content;height:fit-content">
                    </asp:Label>
                    <asp:Label ID="lblTicketTitle" runat="server">
                    </asp:Label>
                </h1>
            </div>
            <div class="main-card">
                <div class="sub-main">
                    <div class="card">
                        <asp:Label ID="lblDescriptionTitle" runat="server" CssClass="title" Text="Description:">
                        </asp:Label>
                        <asp:Label ID="lblDescription" runat="server">
                        </asp:Label>
                    </div>
                    <div class="line">
                    </div>
                    <div class="card">
                        <asp:Label ID="lblNameTitle" runat="server" CssClass="title" Text="Name (Created By):"></asp:Label>
                        <asp:Label ID="lblName" class="lblName" runat="server"></asp:Label>
                        <asp:Label ID="lblEmailTitle" runat="server" CssClass="title" Text="Email (Created By):"></asp:Label>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        <asp:Label ID="lblTicketIdTitle" runat="server" CssClass="title" Text="Ticket ID:">
                        </asp:Label>
                        <asp:Label ID="lblTicketIdValue" class="ticketId" runat="server"></asp:Label>
                        <asp:Label ID="lblTicketRaisedTitle" runat="server" CssClass="title" Text="Ticket Raised Date:"></asp:Label>
                        <asp:Label ID="lblTicketRaised" runat="server"></asp:Label>
                        <asp:Label ID="lblStatusTitle" runat="server" CssClass="title" Text="Ticket Status:">
                        </asp:Label>
                        <asp:Label ID="lblStatusValue" runat="server" CssClass="status-Open"></asp:Label>
                        <asp:Label ID="lblPriorityTitle" runat="server" CssClass="title" Text="Priority:">
                        </asp:Label>
                        <asp:Label ID="lblPriority" runat="server"></asp:Label>
                    </div>
                     <div class="line"></div> 
                     <div class="card" style="width: fit-content !important">
                            <div style="margin-bottom: 8px;">
                                <span class="title">Ticket Owner:</span>
                            </div>
                            <div class="user">
                                <div class="user-img">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewbox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round" class="lucide lucide-user mr-2 h-4 w-4">
                                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                </div>
                                <asp:Label ID="lblTicketOwner" class="lblTicketOwner" runat="server" />
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
