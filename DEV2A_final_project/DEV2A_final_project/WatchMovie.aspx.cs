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
        protected void Page_Load(object sender, EventArgs e)
        {
            string title = Request.QueryString["title"];
            DBMethods db = new DBMethods();
            SqlDataReader dr = db.MoreInfo(title);
            while (dr.Read())
            {
                lbltitle.Text = dr[0].ToString();
                lbldesc.Text = dr[6].ToString();
                lblrating.Text = dr[4].ToString();
                lblage.Text = dr[5].ToString();
                lblruntime.Text = dr[2].ToString();
            }


        }
    }
}