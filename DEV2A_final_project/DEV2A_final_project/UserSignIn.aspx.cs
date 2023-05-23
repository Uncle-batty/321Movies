using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class UserSignIn : System.Web.UI.Page
    {
        public string userEmail = "";
        public string userPassword = "";
        public string adminEmail = "";
        public string adminPassword = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void btn_UserSignIn_Click(object sender, EventArgs e)
        {
            DBMethods userSingIn = new DBMethods();
            //Validators
            userEmail = tb_UserEmail.Text;
            userPassword = tb_UserPassword.Text;

            if (userSingIn.userSignIn(userEmail, userPassword))
            {
                Response.Redirect("UserHomePage.aspx");
            }
            else
            {
                lbl_SignInState.ForeColor = System.Drawing.Color.Red;
                lbl_SignInState.Text = "Failed to Sign in";
            }
        }

        public void btn_AdminSignIn_Click(object sender, EventArgs e)
        {
            DBMethods adminSingIn = new DBMethods();
            //Validators
            adminEmail = tb_AdminUsername.Text;
            adminPassword = tb_AdminPassword.Text;

            if (adminSingIn.adminSignIn(adminEmail, adminPassword))
            {
                Response.Redirect("UserHomePage.aspx");
            }
            else
            {
                lbl_SignInState.ForeColor = System.Drawing.Color.Red;
                lbl_SignInState.Text = "Failed to Sign in";
            }
        }
    }
}