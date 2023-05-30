using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminDelete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            movieTilte.Text = Session["movieTitle"].ToString();
            movieId.Text = Session["movieId"].ToString();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard1.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        { 
            DBMethods.DeleteMovie(int.Parse(Session["movieId"].ToString()));
            Debug.WriteLine("movie with Id" + Session["movieId"].ToString() + "has been Deleted");
        }
    }
}