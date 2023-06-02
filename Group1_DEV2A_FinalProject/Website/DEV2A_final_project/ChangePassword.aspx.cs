using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        DBMethods db = new DBMethods();
        string email = string.Empty;
        string password = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_ChangePasswordClick(object sender, EventArgs e)
        {
            bool flag = false;
            if (tb_Email.Text != string.Empty && tb_Password.Text != string.Empty && tb_Password2.Text != string.Empty)
            {
                if (!DBMethods.validEmail(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Invalid email!";
                    flag = true;
                }
                if (!db.emailExists(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Unregistered email!";
                    flag = true;
                }
                if(tb_Password.Text != tb_Password2.Text)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Passwords must be the same";
                    flag = true;
                }
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in all fields";
                flag = true;
            }

            if (!flag)
            {
                email = tb_Email.Text;
                password = tb_Password.Text;

                bool success = db.changePassword(password, email);
                if (success)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Successfully changed password";
                    Response.Redirect("UserSignin.aspx");
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Failed to change passowrd";
                }
            }
        }
    }
}