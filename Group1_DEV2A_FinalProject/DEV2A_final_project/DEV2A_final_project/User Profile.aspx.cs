using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class User_Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DBMethods db = new DBMethods();
            db.GetUser(1);
            db.setUserProfile(db.getUserEmail());

            lbl_Name.Text = DBMethods.UserFname;
            lbl_Surname.Text = DBMethods.UserLname;
            lbl_Email.Text = DBMethods.userEmail;
            int subLevel = DBMethods.userSubId;
            if (subLevel == 1)
            {
                lbl_Subscription.Text = "Free";
            }
            else if (subLevel == 2)
            {
                lbl_Subscription.Text = "Standard";
            }
            else if (subLevel == 3)
            {
                lbl_Subscription.Text = "Premium";
            }


        }

        protected void btn_payment_click(object sender, EventArgs e)
        {
            Response.Redirect("EditPaymentDetails.aspx");
        }
    }
}