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
            


        }

        protected void btn_payment_click(object sender, EventArgs e)
        {
            Response.Redirect("EditPaymentDetails.aspx");
        }
    }
}