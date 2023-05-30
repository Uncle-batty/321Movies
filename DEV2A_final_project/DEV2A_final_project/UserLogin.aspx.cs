using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class UserLogin : System.Web.UI.Page
    {

        //Personal Information
        string FirstName = "";
        string LastName = "";
        string DateOfBirth = "";
        string Email = "";
        string Password = "";

        //Payment information
        int subsriptionLevel = 0;
        string cardNumber = "";
        string ExpiryDate = "";
        string CVV = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        public void btn_NextClick(object sender, EventArgs e)
        {
            DBMethods newUser = new DBMethods();
            bool flag = false;

            if (tb_Fname.Text != "" && tb_Lname.Text != "" && tb_Email.Text != "" && tb_UserPassword.Text != "" && tb_UserPassword2.Text != "" && tb_DOB.Text != "")
            {
                if (!tb_Fname.Text.All(char.IsLetter) || !tb_Lname.Text.All(char.IsLetter))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "First name and last name should only contain letters!";
                    flag = true;
                }
                else if ( tb_UserPassword.Text != tb_UserPassword2.Text)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Please make sure passwords are the same!";
                    flag = true;
                }
                
                else if (!DBMethods.validEmail(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "This is an invalid email!";
                    flag=true;
                }
                else if (newUser.emailExists(tb_Email.Text))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "This email already exists";
                    flag=true;
                }
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in all fields!";
                flag = true;
            }
            


            if (!flag)
            {
                FirstName = tb_Fname.Text;
                LastName = tb_Lname.Text;
                DateOfBirth = Convert.ToString(tb_DOB.Text);
                Email = tb_Email.Text;
                Password =DBMethods.encrypt(tb_UserPassword.Text);

                bool state = newUser.addUser(FirstName, LastName, Email, Password, DateOfBirth);
                if (state)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Registeration successful";
                    ClientScript.RegisterStartupScript(this.GetType(), "AutoSelectTab2", "AutoSelectTab2();", true);
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Registeration failed";
                }
            }
            


        }

        public void btn_NewPaymentsClick(object sender, EventArgs e)
        {
            bool flag = false;

            if (tb_CardNumber.Text != "" && tb_CVV.Text != "" && tb_expDate.Text != "")
            {
                if (!tb_expDate.Text.All(char.IsDigit))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Card number should only contain numbers!";
                    flag = true;
                }
                else if (!tb_expDate.Text.All(char.IsDigit))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Expriry date should only contain numbers!";
                    flag = true;
                }
                else if (!tb_CVV.Text.All(char.IsDigit))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "CVV number should only contain numbers!";
                    flag = true;
                }
                else if (tb_CardNumber.Text.Length > 19 )
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Card number is too long!";
                    flag = true;
                }
                else if (tb_CardNumber.Text.Length < 8)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Card Number is too short!";
                    flag = true;
                }
                else if (tb_CVV.Text.Length != 3)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "CVV should have 3 digits";
                    flag = true;
                }
                else if (tb_expDate.Text.Length != 4)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Invalid Expriry date";
                    flag = true;
                }
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Please fill in all fields!";
                flag = true;
            } 
            DBMethods newUserPayments = new DBMethods();



            if (!flag)
            {
                cardNumber = tb_CardNumber.Text;
                ExpiryDate = tb_expDate.Text;
                CVV = tb_CVV.Text;
                subsriptionLevel = Convert.ToInt32(dd_Pricing.SelectedValue);

                bool PaymentDetailsState = newUserPayments.addUserPayments(cardNumber, ExpiryDate, CVV, subsriptionLevel);
                if (PaymentDetailsState)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Payment info updated";
                    Response.Redirect("UserSignIn.aspx");
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Payment info failed";
                }
            }
        
        }       
    }

    
}