using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminPlanFree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set the list as the GridView's data source
                int freeplan = 1;
                GridView2.DataSource = DBMethods2.readUsersByCatergory(freeplan);
                GridView2.DataBind();
            }

        }
        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {


            int rowIndex = GridView2.SelectedIndex;


            string userId = GridView2.Rows[rowIndex].Cells[1].Text;
            string userEmail = GridView2.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(userId + ":" + userEmail + " :to be deleted");

            Session["UserId"] = userId;
            Session["userEmail"] = userEmail;
            Response.Redirect("AdminBlockUser.aspx");

        }
        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the index of the selected row
            int rowIndex = e.RowIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);
            // Assuming your GridView is bound to a data source like a DataTable or a database, you can retrieve the necessary data from the data source.
            // For example, you can use the GridView's DataKeys collection to get the unique identifier of the record.

            // Get the unique identifier of the record
            //string recordId = GridView1.DataKeys[rowIndex].Value.ToString();
            string userId = GridView2.Rows[rowIndex].Cells[1].Text;
            string userName = GridView2.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(userId + ":" + userName + " :to be deleted");

            Session["UserId"] = userId;
            Session["userName"] = userName;
            Response.Redirect("AdminBlockUser.aspx");

        }
    }

}