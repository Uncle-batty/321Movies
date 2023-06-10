using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminEditMovies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            moviId.Value = Session["movieIdEdit"].ToString();
            movieTitle.Value = Session["movieTitleEdit"].ToString();
        }

        protected void update_Click(object sender, EventArgs e)
        {
            if(DBMethods2.UpdateMovie(moviId.Value, trailerLink.Value, ratings.Value,Views.Value, MovieDescription.Value, int.Parse(Catergory.Value)))
            {
                Response.Redirect("AdminSuccess.aspx");
            }
            else
            {
                Response.Redirect("AdminUnsucessful.aspx");
            }
          
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard1.aspx");
        }
    }
}