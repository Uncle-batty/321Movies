using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Services.Description;
using System.Diagnostics;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Linq.Expressions;
using System.IO;
using System.Data.Common;
using System.Configuration;
using System.Runtime.InteropServices.WindowsRuntime;

namespace DEV2A_final_project
{
    public class DBMethods2
    {
        public static  string  connectionString = "Data Source=.;Initial Catalog=Movies321;Integrated Security=True";
        public static Guid userID;
        public static Guid paymentID;
        public bool addUser(string firstName, string lastName, string email, string password, string userDOB)
        {
            bool registered = false;
            

            try
            {
                SqlConnection conn = new SqlConnection(connectionString);
                string storedProcedure = "userSignUp_st";
                userID = Guid.NewGuid();
                SqlCommand cmd = new SqlCommand(storedProcedure, conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", userID.ToString());
                cmd.Parameters.AddWithValue("@Fname", firstName);
                cmd.Parameters.AddWithValue("@Lname", lastName);
                cmd.Parameters.AddWithValue("@SubId", 1);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@User_DOB", userDOB);
                cmd.Parameters.AddWithValue("@Datelastpaid", DateTime.Now);
                conn.Open();
                int execution = cmd.ExecuteNonQuery();
                if (execution > 0)
                {
                    registered = true;
                }
                else
                {
                    registered = false;
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                registered = false;
            }
            return registered;
        }
     
        public static bool InsertMovies(string movieId,string movieTitle, string runtime, string releaseYear, string trailerLink, string ratings, int ageRating, int views,string shortDescription, string DirectorName, string DirectorLastName, int DirectorId)
        {
                    int c = 1;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        try
                        {
                            connection.Open();

                            string query = "INSERT INTO Movies (MovieID,MovieTitle, Runtime,Release_Year,TrailerLink,Ratings, AgeRating,Views,ShortDiscription,DirectorID,CatergoryID) VALUES (@movieID,@movieTitle, @Runtime, @ReleaseYear, @TrailerLink, @Ratings, @AgeRating,@views,@ShortDescription,@directorID,@catergoryId)";

                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                command.Parameters.AddWithValue("@movieID", movieId);
                                command.Parameters.AddWithValue("@movieTitle", movieTitle);
                                command.Parameters.AddWithValue("@Runtime", runtime);
                                command.Parameters.AddWithValue("@ReleaseYear", releaseYear);
                                command.Parameters.AddWithValue("@TrailerLink", trailerLink);
                                command.Parameters.AddWithValue("@Ratings", ratings);
                                command.Parameters.AddWithValue("@AgeRating", ageRating);
                                command.Parameters.AddWithValue("@ShortDescription", shortDescription);
                                command.Parameters.AddWithValue("@catergoryId", c);
                                command.Parameters.AddWithValue("@directorID", DirectorId);
                                command.Parameters.AddWithValue("@views", views);
                                command.ExecuteNonQuery();
                                Debug.WriteLine("Movie inserted successfully.");
                                return true;
                            }
                          
                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine("Error inserting movie: " + ex.Message);
                            return false;
                        }
        
                    }
                    
        }
        public static bool UpdateMovie(string movieId,string newTrailerLink, string newRatings, string newViews, string newShortDescription,int catergory_id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    string query = "UPDATE Movies SET TrailerLink = @newTrailerLink, Ratings = @newRatings,Views = @newViews, ShortDiscription = @newShortDescription ,CatergoryID=@newCatergoryId WHERE MovieID =" + movieId;

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                       // command.Parameters.AddWithValue("@newMovieTitle", newMovieTitle);
                        command.Parameters.AddWithValue("@newTrailerLink", newTrailerLink);
                        command.Parameters.AddWithValue("@newRatings", newRatings);                       
                        command.Parameters.AddWithValue("@newViews", newViews);
                        command.Parameters.AddWithValue("@newShortDescription", newShortDescription);
                        command.Parameters.AddWithValue("@newCatergoryId", catergory_id);
                        //command.Parameters.AddWithValue("@newDirectorId", newDirectorId);
                        //command.Parameters.AddWithValue("@movieId", movieId);

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Debug.WriteLine("Movie updated successfully.");
                            return true;
                        }
                        else
                        {
                            Debug.WriteLine("No rows updated. Movie with ID " + movieId + " not found.");
                            return false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error updating movie: " + ex.Message);
                    return false;
                }
            }
        }


        public static bool InsertDirectors(string DirectorName, string DirectorLastName, int DirectorId)
        {


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    string query = "INSERT INTO Directors (DirectorID,DirectorFName,DirectorLName) VALUES (@directorID, @directorFName,@directorLName)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@directorFName", DirectorName);
                        command.Parameters.AddWithValue("@directorLName",DirectorLastName );
                        command.Parameters.AddWithValue("@directorID", DirectorId);
                        command.ExecuteNonQuery();
                        Debug.WriteLine("Director inserted successfully.");
                        return true;
                    }
                 
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error inserting user: " + ex.Message);
                    return false;
                }
            }
        }
        public static bool InsertInvoice(string invoive_iD,string dateSent, string payby, string userId)
        {


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    string query = "INSERT INTO Invoices (InvoiceID,Date,PayBy,UserID) VALUES (@invoiceId,@date, @payby,@userid)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@invoiceId", invoive_iD);
                        command.Parameters.AddWithValue("@date", dateSent);
                        command.Parameters.AddWithValue("@payby", payby);
                        command.Parameters.AddWithValue("@userid", userId);
                        command.ExecuteNonQuery();
                        Debug.WriteLine("invoice inserted successfully.");
                        return true;
                    }

                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error inserting Invoice: " + ex.Message);
                    return false;
                }
            }
        }
        public static bool DeleteMovie(int movieId)
        {
        
            using (SqlConnection connection = new SqlConnection(connectionString))
        {
            try
            {
                connection.Open();

                string query = "DELETE FROM Movies WHERE MovieId = @MovieId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@MovieId", movieId);

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        System.Diagnostics.Debug.WriteLine("Movie deleted successfully.");
                        return true;
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("No movie found with the provided ID.");
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error deleting movie: " + ex.Message);
                return false;
            }
        }
    }

        public static bool DeleteUser(string userId)
        {
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    string query = "DELETE FROM Users WHERE UserId = @userId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@userId", userId);

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            System.Diagnostics.Debug.WriteLine("User deleted successfully.");
                            return true;
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("No User found with the provided ID.");
                            return false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error deleting user: " + ex.Message);
                    return false;
                }
            }
        }
        public bool emailExists(string email)
        {
            bool exists = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string cmdText = $"Select * from Users where Email = '{email}' ";

            try
            {
                SqlDataReader dataReader;
                using (SqlCommand cmd = new SqlCommand(cmdText, conn))
                {
                    conn.Open();
                    dataReader = cmd.ExecuteReader();
                    if (dataReader.Read())
                    {
                        exists = true;
                    }
                    else
                    {
                        exists = false;
                        dataReader.Close();
                    }
                    conn.Close();
                }
            }
            catch { }
            return exists;
        }
        public bool addUserPayments( string cardNumber, string ExpDate, string CVV, int subscriptionLevel)
        {
            bool paymentAdded = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string storedProcedure = "AddUserPayments_st";
            string cmdText = "update Users set SubID = " + subscriptionLevel + " where UserId = " + userID.ToString() + "";
            



            //Adds Users payment information
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(storedProcedure, conn);
                paymentID = Guid.NewGuid();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PaymentId",paymentID.ToString());
                cmd.Parameters.AddWithValue("@cardNumber", cardNumber);
                cmd.Parameters.AddWithValue("@ExpDate", ExpDate);
                cmd.Parameters.AddWithValue("@CVV", CVV);
                cmd.Parameters.AddWithValue("@UserID", userID.ToString());
                int execution = cmd.ExecuteNonQuery();
                if (execution > 0)
                {
                    paymentAdded = true;

                }
                else
                {
                    paymentAdded = false;
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                paymentAdded = false;
            }

            return paymentAdded;
        }
        public bool userSignIn(string email, string password)
        {
            bool userSignedIn = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string commandText = $"select * from Users where Email = '{email}' and Password = {password}";
            SqlDataReader dataReader;
            try
            {
               
                using (SqlCommand cmd = new SqlCommand(commandText, conn))
                {
                    conn.Open();
                    dataReader = cmd.ExecuteReader();                
                    if (dataReader.Read())
                    {
                        userSignedIn = true;
                    }
                    else
                    {
                        userSignedIn = false;
                        dataReader.Close();
                    }
                    conn.Close();
                }
            }
            catch (Exception e)
            {
                userSignedIn=false;
            }  

            return userSignedIn;
        }
        public bool adminSignIn(string email, string password)
        {
            bool userSignedIn = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string commandText = $"select * from Admin where email = '{email}' and Password = {password}";
            try
            {
                SqlDataReader dataReader;
                using (SqlCommand cmd = new SqlCommand(commandText, conn))
                {
                    conn.Open();
                    dataReader = cmd.ExecuteReader();
                    if (dataReader.Read())
                    {
                        userSignedIn = true;                   
                    }
                    else
                    {
                        userSignedIn = false;
                        dataReader.Close();
                    }
                    conn.Close();
                }
            }
            catch (Exception e)
            {
                userSignedIn = false;
            }
            return userSignedIn;
        }

        public static string GenerateUnique4DigitNumber()
        {
            Random rand = new Random();
            string number = rand.Next(1000, 10000).ToString();

            // Check if the number has already been used
            while (IsNumberUsed(number))
            {
                number = rand.Next(1000, 10000).ToString();
            }

            // Save the number as used
            SaveNumber(number);

            return number;
        }

        private static bool IsNumberUsed(string number)
        {
            // Implement your own logic here to check if the number has already been used
            // This could involve checking a database or file to see if the number exists
            // You could also store the used numbers in a HashSet or other data structure
            // In this example, we'll always return false to simulate a new number being generated every time
            return false;
        }

        private static void SaveNumber(string number)
        {
            // Implement your own logic here to save the number as used
            // This could involve writing the number to a database or file, or adding it to a HashSet or other data structure
            // In this example, we'll just write the number to the console to simulate saving it
            Console.WriteLine($"Saving number {number}");
        }

        public static bool validEmail(string email)
        {
            var valid = true;

            try
            {
                var emailAddress = new MailAddress(email);
            }
            catch
            {
                valid = false;
            }
            return valid;
        }

        public static string encrypt(string password)
        {
            using (MD5CryptoServiceProvider mD5 = new MD5CryptoServiceProvider())
            {
                UTF8Encoding uTF8 = new UTF8Encoding();
                byte[] data = mD5.ComputeHash(uTF8.GetBytes(password));
                return Convert.ToBase64String(data);
            }
        }

        public  SqlDataReader MovieListbyCat(int catagory)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT * FROM Movies where CatergoryID = '" + catagory + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }
        public static SqlDataReader readAllMovies()
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;
            //Data Source=DESKTOP-CN5GIIC\RAPUDI;Initial Catalog=Movies3213;Integrated Security=True
            conn.Open();
            string SQL = "select MovieID,MovieTitle,Release_Year  from Movies;";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }
        public  static SqlDataReader readAllUsers()
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();    
            string SQL = "SELECT UserID ,Email,Fname,SubID,User_DOB,Datelastpaid FROM Users;";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }
        public static SqlDataReader readAllMoviesByCatergory(int catergoryId)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "select MovieID,MovieTitle,Release_Year  from Movies where Movies.CatergoryID="+catergoryId.ToString()+" ;";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }
        public static SqlDataReader readUsersByCatergory(int catergoryId)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT UserID ,Email,Fname,SubID,User_DOB,Datelastpaid FROM Users where SubID=" + catergoryId.ToString() + " ;";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }
        public static SqlDataReader readPaymets()
        {
            //string a = "select Users.Email,Users.Lname,InvoiceID,Invoices.Date,Subscription_level.Name,Subscription_level.Price from Invoices join Users on Users.UserId=Invoices.UserID join Subscription_level on  Subscription_level.Sub_ID=Users.SubID;";
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "select Users.Email,Users.Lname,InvoiceID,Invoices.Date,Subscription_level.Name,Subscription_level.Price from Invoices join Users on Users.UserId=Invoices.UserID join Subscription_level on  Subscription_level.Sub_ID=Users.SubID;";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();
            return reader;
        }

        public static SqlDataReader lookup(string term)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;
            //Data Source=DESKTOP-CN5GIIC\RAPUDI;Initial Catalog=Movies3213;Integrated Security=True
            conn.Open();
            string SQL = "select MovieID,MovieTitle,Release_Year  from Movies where MovieTitle like '%" + term+"%';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            return reader;
        }





































    }
}