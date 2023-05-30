using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static DEV2A_final_project.AdminDashBoard.AdminDashboard1;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set the list as the GridView's data source
                GridView2.DataSource = DBMethods.readAllMovies();
                GridView2.DataBind();
            }

        }
        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row index
            int selectedIndex = GridView2.SelectedIndex;
            System.Diagnostics.Debug.WriteLine(selectedIndex);
            // Retrieve the data from the selected row
            //int movieID = Convert.ToInt32(GridView1.DataKeys[selectedIndex].Value);
            string movieName = GridView2.Rows[selectedIndex].Cells[1].Text;
            string movieTitle = GridView2.Rows[selectedIndex].Cells[2].Text;

            // Perform any further processing with the selected data
            // ...
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
            Response.Redirect("AdminDeleteUsers.aspx");
         
        }
    }
}