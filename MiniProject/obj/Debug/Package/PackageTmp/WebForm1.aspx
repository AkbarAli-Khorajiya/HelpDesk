<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="MiniProject.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Support Agent Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .dashboard {
            width: 80%;
            margin: 0 auto;
        }
        .stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .stat-box {
            width: 30%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }
        .filters {
            margin-bottom: 20px;
        }
        .filters label {
            margin-right: 10px;
        }
        .ticket-list {
            width: 100%;
            border-collapse: collapse;
        }
        .ticket-list th, .ticket-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .ticket-list th {
            background-color: #f4f4f4;
        }
        /* Status styles */
        .status-open {
            color: white;
            background-color: red;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .status-in-progress {
            color: white;
            background-color: orange;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .status-closed {
            color: white;
            background-color: green;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <h1>Support Agent Dashboard</h1>
        <div class="stats">
            <div class="stat-box">
                <h2>Open Tickets</h2>
                <p>15</p>
            </div>
            <div class="stat-box">
                <h2>Avg. Response Time</h2>
                <p>2h 15m</p>
            </div>
            <div class="stat-box">
                <h2>Resolved Today</h2>
                <p>7</p>
            </div>
        </div>
        <div class="filters">
            <label for="status-filter">Filter by Status:</label>
            <select id="status-filter">
                <option value="all">All</option>
                <option value="open">Open</option>
                <option value="in-progress">In Progress</option>
                <option value="closed">Closed</option>
            </select>
        </div>
        <h2>Ticket List</h2>
        <table class="ticket-list">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Status</th>
                    <th>Priority</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Cannot access account</td>
                    <td><span class="status-open">Open</span></td>
                    <td>High</td>
                    <td>2023-04-01</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Feature request: Dark mode</td>
                    <td><span class="status-in-progress">In Progress</span></td>
                    <td>Medium</td>
                    <td>2023-04-02</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Bug in checkout process</td>
                    <td><span class="status-closed">Closed</span></td>
                    <td>High</td>
                    <td>2023-04-03</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>