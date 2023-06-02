using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static DEV2A_final_project.AdminDashBoard.AdminDashboard1;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set the list as the GridView's data source
                DateTime currentDate = DateTime.Now;
              
                GridView2.DataSource = DBMethods2.readAllUsers();
                GridView2.DataBind();
                

            }

        }
        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
           

            int rowIndex = GridView2.SelectedIndex;
            
         
            string userId = GridView2.Rows[rowIndex].Cells[1].Text;
            string userEmail = GridView2.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(userId + ":" + userEmail + " :to be deleted");

            Session["UserId"] = userId;
            Session["userEmail"] = userEmail;
            Response.Redirect("AdminBlockUser.aspx");
            
           foreach(GridViewRow row in GridView2.Rows)
           {
                Debug.WriteLine(row.Cells[6].Text);
                
           }
        }
        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the index of the selected row
            int rowIndex = e.RowIndex;
            System.Diagnostics.Debug.WriteLine(rowIndex);
            // Assuming your GridView is bound to a data source like a DataTable or a database, you can retrieve the necessary data from the data source.
            // For example, you can use the GridView's DataKeys collection to get the unique identifier of the record.

            // Get the unique identifier of the record
            //string recordId = GridView1.DataKeys[rowIndex].Value.ToString();
            string userId = GridView2.Rows[rowIndex].Cells[1].Text;
            string userName = GridView2.Rows[rowIndex].Cells[2].Text;
            System.Diagnostics.Debug.WriteLine(userId + ":" + userName + " :to be deleted");

            Session["UserId"] = userId;
            Session["userName"] = userName;
            Response.Redirect("AdminBlockUser.aspx");
         
        }
        protected void Generate_Click(object sender, EventArgs e)
        {
           // Debug.WriteLine("Click Click Click ");
            string format = "M,d,yyyy";
            string format2 = "MM/dd/yyyy";
            DateTime endDate;
            DateTime C = DateTime.Now;
            List<string> lst_emails = new List<string> { };
            foreach (GridViewRow row in GridView2.Rows)
            {
                //Debug.WriteLine(row.Cells[6].Text.Split(' ')[0].Replace('/',',') +" "+ currentDate);
                string dateString = row.Cells[6].Text.Split(' ')[0].Replace('/', ',');
                DateTime date;
                Guid g;
                if (DateTime.TryParseExact(dateString, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out date))
                {
                    //Debug.WriteLine("Parsed date: {0}", date.ToString("yyyy-MM-dd"));
                    string dd = date.ToString("MM/dd/yyyy");
                    Debug.WriteLine(dd + " : " + " : " + C);
                    if (DateTime.TryParseExact(dd, format2, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDate))
                    {
                        DateTime currentDate2 = DateTime.Now;

                        TimeSpan duration = currentDate2 - endDate;
                        int numberOfDays = (int)duration.TotalDays;

                        Debug.WriteLine("Number of days between the current date and {0}: {1}", endDate.ToString(format), numberOfDays);
                        if (numberOfDays == 4 || numberOfDays == 4 || numberOfDays == 3)
                        {
                            lst_emails.Add(row.Cells[2].Text);
                            g = Guid.NewGuid();
                            DBMethods2.InsertInvoice(g.ToString(),currentDate2.ToString(), currentDate2.AddDays(3).ToString(), row.Cells[1].Text);
                        }
                    }
                    else 
                    {
                        Debug.WriteLine("Invalid date format 1.");
                    }


                }
                else
                {
                    Debug.WriteLine("Invalid date format.3 ");
                }
                //string dateString = row.Cells[6].Text.Split(' ')[0].Replace('/', ',');


            }
            Session["list_Emails"] = lst_emails;
            Response.Redirect("AdminUploadInvoices.aspx");
            //DBMethods2.InsertInvoice(C,, GridView2.Rows[rowIndex].Cells[1].Text)
        }

    }
}