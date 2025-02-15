using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EntranceExamForm
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public string dbConn = ConfigurationManager.ConnectionStrings["dbString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(dbConn))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM EntranceExamData", conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    gridView.DataSource = dt;
                    gridView.DataBind();
                }
            }
        }


        protected void btnAddRow_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)gridView.DataSource;
            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("Id", typeof(int)); // Important: Add the ID column
                dt.Columns.Add("Name", typeof(string));
                dt.Columns.Add("Email", typeof(string));
                dt.Columns.Add("Phone", typeof(string));
                dt.Columns.Add("Marks", typeof(int));
            }

            DataRow newRow = dt.NewRow();
            //  If your ID is an auto-incrementing column in the database, you *don't* need to set it here.
            //  The database will handle it on insertion.  If it's *not* auto-incrementing, you'd
            //  generate a new ID here.
            dt.Rows.Add(newRow);

            gridView.DataSource = dt;
            gridView.DataBind();
        }


        protected void gridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gridView.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void gridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int recordIdToUpdate = int.Parse(gridView.DataKeys[rowIndex].Value.ToString());

                GridViewRow row = gridView.Rows[rowIndex];
                TextBox txtName = (TextBox)row.FindControl("txtName");
                TextBox txtEmail = (TextBox)row.FindControl("txtEmail");
                TextBox txtPhone = (TextBox)row.FindControl("txtPhone");
                TextBox txtMarks = (TextBox)row.FindControl("txtMarks");

                using (SqlConnection conn = new SqlConnection(dbConn))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("UPDATE EntranceExamData SET Name = @Name, Email = @Email, Phone = @Phone, Marks = @Marks WHERE Id = @Id", conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", recordIdToUpdate);
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);

                        // *** Corrected Marks Handling ***
                        int marksValue;
                        if (int.TryParse(txtMarks.Text, out marksValue)) // TryParse is safer
                        {
                            cmd.Parameters.AddWithValue("@Marks", marksValue);
                        }
                        else
                        {
                            lblMessage.Text = "Error: Invalid Marks value. Please enter a number.";
                            return; // Stop the update if Marks is invalid
                        }

                        cmd.ExecuteNonQuery();
                    }
                }

                gridView.EditIndex = -1; // Exit edit mode
                BindGridView();
                lblMessage.Text = "Record updated successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating record: " + ex.Message;
            }
        }

        protected void gridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gridView.EditIndex = -1;
            BindGridView();
        }


        protected void gridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int rowIndex = e.RowIndex;
                int recordIdToDelete = int.Parse(gridView.DataKeys[rowIndex].Value.ToString());

                using (SqlConnection conn = new SqlConnection(dbConn))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM EntranceExamData WHERE Id = @Id", conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", recordIdToDelete);
                        cmd.ExecuteNonQuery();
                    }
                }

                BindGridView();
                lblMessage.Text = "Record deleted successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting record: " + ex.Message;
            }
        }
    }
}