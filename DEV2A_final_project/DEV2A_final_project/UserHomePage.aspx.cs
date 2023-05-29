using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace DEV2A_final_project
{
    
    [Serializable]
    public partial class UserHomePage : System.Web.UI.Page
    {
        public string descrip { get; set; }
        public static string movietitle = "";


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
               
                while (dr.Read())
                {
                    descrip = dr[7].ToString();

                    if (descrip.Count() > 105)
                    {
                        descrip = descrip.Insert(97, "...");
                        descrip = descrip.Remove(100, descrip.Count() - 101);
                    }
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 4.ToString() + ".jpg",
                        Description = descrip,

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
                    descrip = dr[7].ToString();

                    if (descrip.Count() > 105)
                    {
                        descrip = descrip.Insert(97, "...");
                        descrip = descrip.Remove(100, descrip.Count() - 101);
                    }
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 10.ToString() + ".jpg",
                        Description = descrip,

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
                    descrip = dr[7].ToString();

                    if (descrip.Count() > 105)
                    {
                        descrip = descrip.Insert(97, "...");
                        descrip = descrip.Remove(100, descrip.Count() - 101);
                    }
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 3.ToString() + ".jpg",
                        Description = descrip,

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
                    descrip = dr[7].ToString();

                    if (descrip.Count() > 105)
                    {
                        descrip = descrip.Insert(97, "...");
                        descrip = descrip.Remove(100, descrip.Count() - 101);
                    }
                    cards.Add(new Card
                    {
                        Title = dr[1].ToString(),
                        ImageUrl = "assets/Movies/movie" + 1.ToString() + ".jpg",
                        Description = descrip,

                    });


                }

                // Bind the list of cards to the Repeater control
                rptCards4.DataSource = cards;
                rptCards4.DataBind();
            }
        }

        

        [WebMethod]
        public static void HandleWatchButtonClick(string title)
        {
            System.Diagnostics.Debug.WriteLine("HandleWatchButtonClick called with title: " + title);
            movietitle = title;

        }
      public void btnwatch(object sender, EventArgs e)
        {
            string movie = ht.Value;
            Response.Redirect("WatchMovie.aspx?Title=" + movie);
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