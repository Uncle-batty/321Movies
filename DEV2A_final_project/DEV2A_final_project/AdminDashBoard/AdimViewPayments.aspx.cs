using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static DEV2A_final_project.AdminDashBoard.AdminDashboard1;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdimViewPayments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                GridView2.DataSource = DBMethods2.readPaymets();
                GridView2.DataBind();

            }
           
        }
    }
}