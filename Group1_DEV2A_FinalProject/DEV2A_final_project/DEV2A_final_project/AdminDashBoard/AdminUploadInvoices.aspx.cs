using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project.AdminDashBoard
{
    public partial class AdminUploadInvoices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView2.DataSource = Session["list_Emails"];
            GridView2.DataBind();
        }
    }
}