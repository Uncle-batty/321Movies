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
        public static bool errorOccured = false;
        public static string errorMessage = "";

        //public bool addUser(string firstName, string lastName, string email, string password, string userDOB)
        //{
        //    bool registered = false;
        //    SqlConnection conn = new SqlConnection(connectionString);
        //    string storedProcedure = "userSignUp_st";

        //    try
        //    {
        //        var guid = new Guid();
        //        SqlCommand cmd = new SqlCommand(storedProcedure, conn);
        //        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@UserId", guid.ToString());
        //        cmd.Parameters.AddWithValue("@Fname", firstName);
        //        cmd.Parameters.AddWithValue("@Lname", lastName);
        //        cmd.Parameters.AddWithValue("@Email", email);
        //        cmd.Parameters.AddWithValue("@Password", password);
        //        cmd.Parameters.AddWithValue(" @User_DOB", userDOB);
        //        conn.Open();
        //        int execution = cmd.ExecuteNonQuery();
        //        if (execution == 1)
        //        {
        //            registered = true;

        //        }
        //        else
        //        {
        //            registered = false;
        //        }

        //        conn.Close();
        //    }
        //    catch (Exception ex) 
        //    { 
        //        registered=false;
        //        errorMessage = ex.ToString();
        //    }
        //}
    }
}