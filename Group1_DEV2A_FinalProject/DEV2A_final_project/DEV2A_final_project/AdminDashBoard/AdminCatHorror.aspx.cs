using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminCatHorror : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //DBMethods.RefreshTable();
                // Set the list as the GridView's data source
                int horror = 5;
                GridViewHorror.DataSource = DBMethods2.readAllMoviesByCatergory(horror);
                GridViewHorror.DataBind();
            }
        }
        protected void GridViewHorror_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row index
            int selectedIndex = GridViewHorror.SelectedIndex;
            System.Diagnostics.Debug.WriteLine(selectedIndex);
            // Retrieve the data from the selected row
            //int movieID = Convert.ToInt32(GridView1.DataKeys[selectedIndex].Value);
            string movieName = GridViewHorror.Rows[selectedIndex].Cells[1].Text;
            string movieTitle = GridViewHorror.Rows[selectedIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieName + " title :" + movieTitle);
            // Perform any further processing with the selected data
            // ...
        }
        protected void GridViewHorror_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int rowIndex = e.NewEditIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);

            string movieID = GridViewHorror.Rows[rowIndex].Cells[1].Text;
            string movieTitle = GridViewHorror.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieTitle);

            Session["movieTitleEdit"] = movieTitle;
            Session["movieIdEdit"] = movieID;

            Response.Redirect("AdminEditMovies.aspx");
        }
        protected void GridViewHorror_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the index of the selected row
            int rowIndex = e.RowIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);

            // Get the unique identifier of the record
            //string recordId = GridView1.DataKeys[rowIndex].Value.ToString();
            string movieID = GridViewHorror.Rows[rowIndex].Cells[1].Text;
            string movieTitle = GridViewHorror.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieTitle);

            Session["movieTitle"] = movieTitle;
            Session["movieId"] = movieID;

            Response.Redirect("AdminDeleteMovies.aspx");

        }
    }
}