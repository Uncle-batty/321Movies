using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static DEV2A_final_project.UserHomePage;

namespace DEV2A_final_project
{
    public partial class WatchMovie : System.Web.UI.Page
    {


        public string movieTitle;

        [WebMethod]
        public void HandleWatchButtonClick(string title)
        {
            movieTitle = title;
            

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            DBMethods db = new DBMethods();
            SqlDataReader dr = db.MoreInfo(movieTitle);
            while (dr.Read())
            {
                lbltitle.Text = dr[2].ToString();



            }
            
        }
    }
}