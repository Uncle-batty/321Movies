using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class editPaymentDetails : System.Web.UI.Page
    {
        int subsriptionLevel = 0;
        string cardNumber = "";
        string ExpiryDate = "";
        string CVV = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Save_Click(object sender, EventArgs e)
        {
            bool flag = false;

            if (tb_CardNumber.Text != "" && tb_CVV.Text != "" && tb_expDate.Text != "")
            {
                if (!tb_CardNumber.Text.All(char.IsDigit))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Card number should only contain numbers!";
                    flag = true;
                }

                else if (!tb_CVV.Text.All(char.IsDigit))
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "CVV number should only contain numbers!";
                    flag = true;
                }
                else if (tb_CardNumber.Text.Length > 19)
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
                subsriptionLevel = Convert.ToInt32(ddl_SubscriptionLevel.SelectedValue);

                bool PaymentDetailsState = newUserPayments.addUserPayments(cardNumber, ExpiryDate, CVV, subsriptionLevel);
                if (PaymentDetailsState)
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                    lbl_personalInfoState.Text = "Payment info updated";
                    Response.Redirect("User Profile.aspx");
                }
                else
                {
                    lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                    lbl_personalInfoState.Text = "Payment info failed";
                }
            }
        }

        protected void btn_CancelSubscription(object sender, EventArgs e)
        {
            DBMethods newUserPayments = new DBMethods();
            bool paymentDetailsState = newUserPayments.addUserPayments("","","",1);
            if (paymentDetailsState)
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Green;
                lbl_personalInfoState.Text = "Subscription canceled";
                Response.Redirect("User Profile.aspx");
            }
            else
            {
                lbl_personalInfoState.ForeColor = System.Drawing.Color.Red;
                lbl_personalInfoState.Text = "Failed to cancel";
            }
        }
    }
}