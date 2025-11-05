using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ChemLab1.DAL
{
    public class DatabaseHelper
    {
        private static string connectionString =
            ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        public static DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }

        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    object result = null;

                    try
                    {
                        result = cmd.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("[DB ERROR] ExecuteScalar failed: " + ex.Message);
                        return 0; // Return 0 to avoid breaking registration
                    }

                    // If result is null, return 0
                    if (result == null || result == DBNull.Value)
                        return 0;

                    return result;
                }
            }
        }

    }
}