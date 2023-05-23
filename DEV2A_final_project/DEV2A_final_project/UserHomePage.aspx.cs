using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DEV2A_final_project
{
    public partial class UserHomePage : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            DBMethods dBMethods = new DBMethods();
            //SqlDataReader DR = dBMethods.

            //card 1
            if (!IsPostBack)
            {
                // Create a list of 100 cards with similar content
                List<Card> cards = new List<Card>();
                for (int i = 1; i <= 20; i++)
                {
                    cards.Add(new Card
                    {
                        Title = "movie" + i,
                        ImageUrl = "assets/Movies/movie" + i + ".jpg",
                        Description = "discription"
                        
                    });
                }

                // Bind the list of cards to the Repeater control
                rptCards1.DataSource = cards;
                rptCards1.DataBind();
            }

            //card 2
            if (!IsPostBack)
            {
                // Create a list of 100 cards with similar content
                List<Card> cards = new List<Card>();
                for (int i = 1; i <= 10; i++)
                {
                    cards.Add(new Card
                    {
                        Title = "movie" + i,
                        ImageUrl = "assets/Movies/movie" + i + ".jpg",
                        Description = "discription"

                    });
                }

                // Bind the list of cards to the Repeater control
                rptCards2.DataSource = cards;
                rptCards2.DataBind();
            }

            //card 3

            if (!IsPostBack)
            {
                // Create a list of 100 cards with similar content
                List<Card> cards = new List<Card>();
                for (int i = 1; i <= 10; i++)
                {
                    cards.Add(new Card
                    {
                        Title = "movie" + i,
                        ImageUrl = "assets/Movies/movie" + i + ".jpg",
                        Description = "discription"

                    });
                }

                // Bind the list of cards to the Repeater control
                rptCards3.DataSource = cards;
                rptCards3.DataBind();
            }
        }

        // Data model for each card
        public class Card
        {
            public string Title { get; set; }
            public string ImageUrl { get; set; }
            public string Description { get; set; }
        }

    }
}