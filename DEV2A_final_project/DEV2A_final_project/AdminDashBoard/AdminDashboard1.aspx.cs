using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminDashboard1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Create a list of movies
                List<Movie> movies = new List<Movie>()
                 {
               new Movie() { MovieID = 1, MovieName = "The Shawshank", MovieTitle = "Redemption" },
               new Movie() { MovieID = 2, MovieName = "The Godfather", MovieTitle = "Godfather" },
               new Movie() { MovieID = 3, MovieName = "Pulp Fiction", MovieTitle = "Pulp Fiction" }
               // Add more movies as needed
                };

                // Set the list as the GridView's data source
                GridView1.DataSource = DBMethods.readAllMovies();
                GridView1.DataBind();
            }
            else if (IsPostBack)
            {
                GridView1.DataSource = DBMethods.readAllUsers();
            }
        }public void viewUsers()
        {
            
                
                GridView1.DataSource = DBMethods.readAllUsers();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
              
        }
        public void viewMovies()
        {
           
                
                GridView1.DataSource = DBMethods.readAllMovies();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
           
        }
        protected void Movies_Click(object sender, EventArgs e)
        {
                
                GridView1.DataSource = DBMethods.readAllMovies();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
              
        }
        protected void Users_Click(object sender, EventArgs e)
        {
          
                
                GridView1.DataSource = DBMethods.readAllUsers();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
          
        }
        public class Movie
        {
            public int MovieID { get; set; }
            public string MovieName { get; set; }
            public string MovieTitle { get; set; }
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row index
            int selectedIndex = GridView1.SelectedIndex;
            System.Diagnostics.Debug.WriteLine(selectedIndex);
            // Retrieve the data from the selected row
            //int movieID = Convert.ToInt32(GridView1.DataKeys[selectedIndex].Value);
            string movieName = GridView1.Rows[selectedIndex].Cells[1].Text;
            string movieTitle = GridView1.Rows[selectedIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(movieName+" title :" +movieTitle);
            // Perform any further processing with the selected data
            // ...
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1.DataBind(); // Rebind the GridView to enter edit mode
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
            System.Diagnostics.Debug.WriteLine(movieTitle );

            Session["movieTitle"] = movieTitle;
            Session["movieId"] = movieID;

            Response.Redirect("AdminDeleteMovies.aspx"); 
         
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            // Retrieve the stored row index from the session variable
            int rowIndex = (int)Session["RowIndex"];

            // Assuming your GridView is bound to a data source like a DataTable or a database, you can now use the rowIndex to delete the corresponding record.

            // Clear the session variable
            Session.Remove("RowIndex");

            // Refresh the GridView or perform any other necessary actions
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}