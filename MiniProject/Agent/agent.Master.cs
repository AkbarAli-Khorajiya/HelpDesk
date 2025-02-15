﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MiniProject.Agent
{
    public partial class agent : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClearPageCache();
            if (Session["agentName"] != null)
            {
                lblUserName.Text = Session["agentName"].ToString();
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }
        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("../Login.aspx");
        }
        private void ClearPageCache()
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            Response.AppendHeader("Pragma", "no-cache");
        }
    }
}