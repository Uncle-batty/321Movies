using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminAddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["UserId"] 
            //Session["userEmail"]

            user_id.Value = Session["UserId"].ToString();
            user_email.Value = Session["userEmail"].ToString();


        }

        protected void Generate_Invoice_Click(object sender, EventArgs e)
        {
        }

        protected void Block_User_Click(object sender, EventArgs e)
        {

            if (DBMethods2.DeleteUser(user_id.Value = Session["UserId"].ToString()))
            {
                Response.Redirect("AdminSuccess.aspx");
            }
            else
            {
                Response.Redirect("AdminUnsucessful.aspx");
            }
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminUsers.aspx");
        }
    }
}