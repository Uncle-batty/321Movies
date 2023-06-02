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
                //DBMethods.RefreshTable();
                // Set the list as the GridView's data source
                GridView1.DataSource = DBMethods2.readAllMovies();
                GridView1.DataBind();
            }
            else if (IsPostBack)
            {
                GridView1.DataSource = DBMethods2.readAllUsers();
            }
        }public void viewUsers()
        {
            
                
                GridView1.DataSource = DBMethods2.readAllUsers();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
              
        }
        public void btnlookup(object sender, EventArgs e)
        {
            GridView1.DataSource = DBMethods2.lookup(Lu.Value.ToString());
            GridView1.DataBind();
        }
        public void viewMovies()
        {
           
                
                GridView1.DataSource = DBMethods2.readAllMovies();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
           
        }
        protected void Movies_Click(object sender, EventArgs e)
        {
                
                GridView1.DataSource = DBMethods2.readAllMovies();
                GridView1.DataBind();
                System.Diagnostics.Debug.WriteLine("Executed users view ");
              
        }
        protected void Users_Click(object sender, EventArgs e)
        {
          
                
                GridView1.DataSource = DBMethods2.readAllUsers();
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
            System.Diagnostics.Debug.WriteLine(movieTitle );

            Session["movieTitle"] = movieTitle;
            Session["movieId"] = movieID;

            Response.Redirect("AdminDeleteMovies.aspx"); 
         
        }

       

        
    }
}