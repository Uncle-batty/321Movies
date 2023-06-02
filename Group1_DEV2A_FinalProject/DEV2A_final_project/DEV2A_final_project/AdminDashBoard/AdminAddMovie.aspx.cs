using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminAddMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard1.aspx");
        }
        protected void btn_AddMovie_Click(object sender, EventArgs e)
        {   //s(string movieId,string movieTitle, string runtime, string releaseYear, string trailerLink, string ratings, string ageRating, string shortDescription, string DirectorName, string DirectorLastName, string DirectorId)
            
            //DBMethods.InsertDirectors(directorName.Value, directorLastName.Value, int.Parse(directorId.Value));
            //DBMethods.InsertMovies(moviId.Value, movieTitle.Value, runTime.Value, releaseYear.Value, trailerLink.Value, ratings.Value, int.Parse(Ageratings.Value), int.Parse(Views.Value),MovieDescription.Value, directorName.Value, directorLastName.Value, int.Parse(directorId.Value));
            
            if(DBMethods2.InsertDirectors(directorName.Value, directorLastName.Value, int.Parse(directorId.Value)) && DBMethods2.InsertMovies(moviId.Value, movieTitle.Value, runTime.Value, releaseYear.Value, trailerLink.Value, ratings.Value, int.Parse(Ageratings.Value), int.Parse(Views.Value), MovieDescription.Value, directorName.Value, directorLastName.Value, int.Parse(directorId.Value)))
            {
                Response.Redirect("AdminSuccess.aspx");
            }
            else
            {
                Response.Redirect("AdminUnsucessful.aspx");
            }
        }
    }
}