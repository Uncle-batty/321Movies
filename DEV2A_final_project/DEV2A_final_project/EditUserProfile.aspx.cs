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

        protected void btn_SaveClick(object sender, EventArgs e)
        {
            
            bool flag = false;
            if (tb_Name.Text != "" && tb_Email.Text != "" && tb_Surname.Text != "")
            {
                if (!tb_Name.Text.All(char.IsLetter) || !tb_Surname.Text.All(char.IsLetter))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "First name and last name should only contain letters!";
                    flag = true;
                }
                else if (!DBMethods.validEmail(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Invalid Email!";
                    flag = true;
                }
                else if (db.emailExists(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "This email already exists";
                    flag = true;
                }

            }
            

            if (!flag)
            {
                if (db.updateUserProfile(tb_Name.Text, tb_Surname.Text, tb_Email.Text))
                {
                    Response.Redirect("User Profile.aspx");
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Failed to Update";
                    flag = true;
                }
            }
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
    }
}