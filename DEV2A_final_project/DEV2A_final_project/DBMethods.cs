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
    }
}