using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class EditUserProfile : System.Web.UI.Page
    {
        DBMethods db = new DBMethods();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_BackClick(object sender, EventArgs e)
        {
            Response.Redirect("User Profile.aspx");
            
        }

        protected void btn_FnameSaveClick(object sender, EventArgs e)
        {
            if (tb_Name.Text != "")
            {
                if (db.changeName(tb_Name.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Successfully changed name";
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Failed to change Name";
                }
            }
            else 
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in Your Name";
            }
        }

        protected void btn_LnameSaveClick(object sender, EventArgs e)
        {
            if (tb_Surname.Text != "")
            {
                if (db.changeSurname(tb_Surname.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Successfully changed surname";
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Failed to change surname";
                }
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in Your surname";
            }
        }

        protected void btn_EmailSaveClick(object sender, EventArgs e)
        {
            if (tb_Email.Text != "")
            {
                if (db.changeEmail(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Successfully changed email";
                    Response.Redirect("UserSignIn.aspx");
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Failed to change email";
                }
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in Your email";
            }
        }
    }
}