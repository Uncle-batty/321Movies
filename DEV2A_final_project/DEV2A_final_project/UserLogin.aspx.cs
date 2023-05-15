﻿using System;
using System.Collections.Generic;
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
            //Validaters
            DBMethods newUser = new DBMethods();
            FirstName = tb_Fname.Text;
            LastName = tb_Lname.Text;
            DateOfBirth = Convert.ToString(tb_DOB.Text);
            Email = tb_Email.Text;
            Password = tb_UserPassword.Text;

            bool state = newUser.addUser(FirstName, LastName, Email, Password, DateOfBirth);
            if (state)
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                lbl_personalInfoState.Text = "Registeration successful";
            }
            else
            {               
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Registeration failed";
            }


        }

        public void btn_NewPaymentsClick(object sender, EventArgs e)
        {
            //validaters 
            DBMethods newUserPayments = new DBMethods();
            //subsriptionLevel = Convert.ToInt32(dd_Pricing.SelectedValue);
            
            
            

            cardNumber = tb_CardNumber.Text;
            ExpiryDate = tb_expDate.Text;
            CVV = tb_CVV.Text;
            subsriptionLevel = Convert.ToUInt16(dd_Pricing.SelectedItem.Text);

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