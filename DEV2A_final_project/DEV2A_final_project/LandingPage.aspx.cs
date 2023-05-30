using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class LandingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void  btn_UserSignIn(object sender, EventArgs e)
        {
            Response.Redirect("UserSignIn.aspx");
        }

        public void btn_UserLogin(object sender, EventArgs e)
        {
            Response.Redirect("UserLogin.aspx");
        }
    }

    
}