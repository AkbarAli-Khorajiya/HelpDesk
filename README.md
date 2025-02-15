# Customer Ticket Management System

## 📌 Overview
The **Customer Ticket Management System** is a web-based application built on **ASP.NET Framework 4.0** with **MS SQL Server**. It facilitates seamless communication between **Customers, Agents, and Admin**, ensuring efficient issue tracking and resolution.

## 🚀 Features
### **1. Admin Panel**
- Manage **Agents** and **Customers**
- View and manage **all tickets**
- Assign tickets to Agents
- Monitor ticket statuses and resolutions

### **2. Agent Panel**
- Access **assigned tickets**
- Update ticket status (In Progress, Resolved, Closed)
- Communicate with customers regarding their tickets

### **3. Customer Panel**
- **Create new tickets**
- View ticket history and status updates
- Receive responses from Agents

## 🏗️ Technology Stack
- **Frontend:** ASP.NET Web Forms
- **Backend:** ASP.NET Framework 4.0
- **Database:** Microsoft SQL Server
- **Authentication:** ASP.NET Identity / Custom Authentication
- **Hosting:** SmarterASP.NET (Optional)

## 🔧 Installation Guide
### **1. Clone the Repository**
```sh
git clone https://github.com/your-repository/customer-ticket-management.git
cd customer-ticket-management
```

### **2. Configure Database**
- Import the provided **SQL script** (`database.sql`) into **MS SQL Server**
- Update the **connection string** in `web.config`:
```xml
<connectionStrings>
    <add name="MyConnectionString" connectionString="Data Source=YOUR_SERVER;Initial Catalog=TicketDB;Integrated Security=True" providerName="System.Data.SqlClient" />
</connectionStrings>
```

### **3. Run the Application**
- Open the solution in **Visual Studio**
- Restore NuGet packages
- Run the application using **IIS Express** or host on **IIS**

## 🔑 User Roles & Access
| Role     | Permissions |
|----------|------------|
| **Admin** | Manage agents, customers, and tickets. View all records. |
| **Agent** | View and update assigned tickets. Communicate with customers. |
| **Customer** | Create new tickets. Track ticket status. |

## 📜 License
This project is licensed under the **MIT License**. Feel free to modify and use it.

## 📞 Support & Contact
For any issues, contact us at [support@yourdomain.com](mailto:support@yourdomain.com).
