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

namespace DEV2A_final_project
{
    public class DBMethods
    {
        public static string connectionString = "Data Source=KEVSLAPTOP;Initial Catalog=movies321;Integrated Security=True";
        public static Guid userID;
        public static Guid paymentID;

        //Public variables 
        public static string userEmail = "";
        public static string UserFname = "";
        public static string UserLname = "";
        public static int userSubId = 0;
       

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
                    setUserEmail(email);
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
            string cmdText = "update Users set SubID = " + subscriptionLevel + " where UserId = '" + getuserid(userEmail) + "'";
            



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

            try
            {
                conn.Open();
                SqlCommand cmdUpdate = new SqlCommand(cmdText, conn);
                int updateExecution = cmdUpdate.ExecuteNonQuery();
                if (updateExecution > 0)
                {
                    paymentAdded = true;
                    userSubId = subscriptionLevel;
                }
                else
                {
                    paymentAdded = false;
                }
                conn.Close();
            }
            catch { paymentAdded = false; }

            return paymentAdded;
        }
        public bool userSignIn(string email, string password)
        {
            bool userSignedIn = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string commandText = $"select * from Users where Email = '{email}' and Password = '{password}'";
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
                        setUserEmail(email);
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
                        userSignedIn = true;                    }
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

        public  SqlDataReader MovieListbyCat(int catagory,int sub)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT * FROM Movies where CatergoryID = '" + catagory + "' and Subid <= '" +sub + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            
            return reader;
            
        }

        public SqlDataReader MoreInfo(string name)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT MovieTitle,RunTime,Release_Year,TrailerLink,Ratings,AgeRating,ShortDiscription,ImageName FROM Movies where MovieTitle = '" + name + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();


            return reader;

        }

        public SqlDataReader GetUser(int ID )
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString );

            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT * FROM Users where UserId = '" + ID + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();

            
            return reader;
            
        }

        public void updateviews(string title)
        {
            SqlConnection conn = new SqlConnection(connectionString );
            SqlCommand cmd;

            conn.Open();
            string sql = "EXEC UpdateViews '" + title+ "';";

            cmd = new SqlCommand(sql, conn);

            cmd.ExecuteNonQuery();

        }

        public SqlDataReader seeWatchlist(string userId)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd;

            conn.Open();
            string SQL = "EXEC seeWatchlist @UserId = '" + userId + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();


            return reader;
        }

        public SqlDataReader getuserSubid(string useremail)
        {
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd;

            conn.Open();
            string SQL = "EXEC Getusersubid @Username = '" + useremail + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();


            return reader;
        }

        public string getuserid(string userId) 
        {
            string res = "";
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT UserId FROM Users where Email = '" + userId + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();
            while (reader.Read()) 
            {
                res = reader[0].ToString();    
            }

            return res;
        }

        

        public void setUserEmail(string email)
        {
            userEmail = email;
        }

        public string getUserEmail() { return userEmail;} 


        public void setUserProfile(string UserEmail)
        {
            
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT Fname, Lname, SubID  FROM Users where Email = '" + UserEmail + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                UserFname = reader[0].ToString();
                UserLname = reader[1].ToString();
                userSubId =Convert.ToInt32(reader[2]);
                
            }            
        }


        public bool updateUserProfile(string fname, string lname, string email)
        {
            bool success = false;
            SqlConnection conn = new SqlConnection(connectionString);
            
            string cmdText = "update Users set Fname = '" + fname + "', Lname = "+ lname +"', Email = '"+ email +"' where Email = '" + userEmail + "';";

            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(cmdText, conn);
                int execution = cmd.ExecuteNonQuery();  
                if (execution > 0) 
                {
                    success = true;
                }
                else
                {
                    success = false;
                }
            }
            catch { success = false; }

            return success;



        }
        public void addtowatchlist(string userid, string Movieid)
        {
            SqlConnection cnn = new SqlConnection(connectionString);

            string Sql = "EXEC AddtoWatchList @userid = '" + userid + "', @movieid = '" + Movieid + "';";

            cnn.Open();

            SqlCommand cmd = new SqlCommand(Sql, cnn);

            cmd.ExecuteNonQuery();
        }
        public string getmovieID(string movietitle)
        {
            string res = "";
            SqlDataReader reader = null;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd;

            conn.Open();
            string SQL = "SELECT MovieID FROM Movies where MovieTitle = '" + movietitle + "';";
            cmd = new SqlCommand(SQL, conn);

            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                res = reader[0].ToString();
            }

            return res;
        }
    }
}