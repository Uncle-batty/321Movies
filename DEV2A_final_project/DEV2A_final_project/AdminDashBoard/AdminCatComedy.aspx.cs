using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminComedyCat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                int commedy = 2;
                GridView1.DataSource = DBMethods2.readAllMoviesByCatergory(commedy);
                GridView1.DataBind();
            }

        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int rowIndex = e.NewEditIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);

            string movieID = GridView1.Rows[rowIndex].Cells[1].Text;
            string movieTitle = GridView1.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieTitle);

            Session["movieTitleEdit"] = movieTitle;
            Session["movieIdEdit"] = movieID;

            Response.Redirect("AdminEditMovies.aspx");
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the index of the selected row
            int rowIndex = e.RowIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);

            // Get the unique identifier of the record
            //string recordId = GridView1.DataKeys[rowIndex].Value.ToString();
            string movieID = GridView1.Rows[rowIndex].Cells[1].Text;
            string movieTitle = GridView1.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieTitle);

            Session["movieTitle"] = movieTitle;
            Session["movieId"] = movieID;

            Response.Redirect("AdminDeleteMovies.aspx");

        }
    }
}