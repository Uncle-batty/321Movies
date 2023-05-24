using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

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
                DBMethods db = new DBMethods();
                SqlDataReader dr = db.MovieListbyCat(2);
                List<Card> cards = new List<Card>();
                while(dr.Read())
                {
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString() ,
                        ImageUrl = "assets/Movies/movie" + 1.ToString() + ".jpg",
                        Description = dr[7].ToString(),
                        
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
                DBMethods db = new DBMethods();
                SqlDataReader dr = db.MovieListbyCat(1);
                List<Card> cards = new List<Card>();
                while (dr.Read())
                {
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 1.ToString() + ".jpg",
                        Description = dr[7].ToString()

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
                DBMethods db = new DBMethods();
                SqlDataReader dr = db.MovieListbyCat(6);
                List<Card> cards = new List<Card>();
                while (dr.Read())
                {
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 1.ToString() + ".jpg",
                        Description = dr[7].ToString()

                    });
                }

                // Bind the list of cards to the Repeater control
                rptCards3.DataSource = cards;
                rptCards3.DataBind();
            }

            //card 4 

            if (!IsPostBack)
            {
                // Create a list of 100 cards with similar content
                DBMethods db = new DBMethods();
                SqlDataReader dr = db.MovieListbyCat(5);
                List<Card> cards = new List<Card>();
                while (dr.Read())
                {
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 1.ToString() + ".jpg",
                        Description = dr[7].ToString()

                    });
                }

                // Bind the list of cards to the Repeater control
                rptCards4.DataSource = cards;
                rptCards4.DataBind();
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