using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data.SqlClient;

namespace DEV2A_final_project
{
    public class DBMethods
    {
        public string connectionString = "Data Source=TADIC;Initial Catalog=Movies321;Integrated Security=True";
        string userID = "";
        public bool addUser(string firstName, string lastName, string email, string password, string userDOB)
        {
            bool registered = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string storedProcedure = "userSignUp_st";
            var userIdGuid = new Guid();
            Console.WriteLine(userIdGuid.ToString());
            SqlCommand cmd = new SqlCommand(storedProcedure, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userIdGuid.ToString());
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
                userID = userIdGuid.ToString();
            }
            else
            {
                registered = false;
            }
            conn.Close();

            try
            {
                //var userIdGuid = new Guid();
                //Console.WriteLine(userIdGuid.ToString());
                //SqlCommand cmd = new SqlCommand(storedProcedure, conn);
                //cmd.CommandType = System.Data.CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@UserId", userIdGuid.ToString());
                //cmd.Parameters.AddWithValue("@Fname", firstName);
                //cmd.Parameters.AddWithValue("@Lname", lastName);
                //cmd.Parameters.AddWithValue("@Email", email);
                //cmd.Parameters.AddWithValue("@Password", password);
                //cmd.Parameters.AddWithValue("@User_DOB", userDOB);
                //conn.Open();
                //int execution = cmd.ExecuteNonQuery();
                //if (execution > 0)
                //{
                //    registered = true;
                //    userID = userIdGuid.ToString();
                //}
                //else
                //{
                //    registered = false;
                //}
                //conn.Close();
            }
            catch (Exception ex)
            {
                registered = false;
            }
            return registered;
        }
        public bool addUserPayments( string cardNumber, string ExpDate, string CVV, int substriptionlevel)
        {
            bool paymentAdded = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string storedProcedure = "AddUserPayments_st";
            string commmandText = $"update Users set SubID = {substriptionlevel} where UserId = {userID}";

            //Adds Users payment information
            try 
            {
                var guid = new Guid();
                SqlCommand cmd = new SqlCommand(storedProcedure, conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PaymentId", guid.ToString());
                cmd.Parameters.AddWithValue("@cardNumber", cardNumber);
                cmd.Parameters.AddWithValue("@ExpDate", ExpDate);
                cmd.Parameters.AddWithValue("@CVV", CVV);
                cmd.Parameters.AddWithValue("@UserID", userID);
                int execution = cmd.ExecuteNonQuery();
                if (execution == 1)
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

            //Updates the Users subscription level
            try 
            {
                SqlCommand cmd = new SqlCommand(commmandText, conn);
                int execution = cmd.ExecuteNonQuery();
                if (execution == 1)
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
                paymentAdded= false;
            }


            return paymentAdded;
        }
        public bool userSignIn(string email, string password)
        {
            bool userSignedIn = false;
            SqlConnection conn = new SqlConnection(connectionString);
            string commandText = $"select * from Users where Email = {email} and Password = {password}";           
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
                        dataReader.Close();
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
            string commandText = $"select * from Admin where email = {email} and Password = {password}";
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
                        dataReader.Close();
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
    }
}