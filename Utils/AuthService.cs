using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using ChemLab1.DAL;
using System.Security.Cryptography;

namespace ChemLab1.Utils
{
    public class AuthService
    {
        // Register new user (Student)
        public static bool RegisterUser(string email, string password, string fullName,
                               string userType = "Student", string school = null)
        {
            // ADD THIS LINE AT THE VERY START
            System.Diagnostics.Debug.WriteLine("Using DB: " + DatabaseHelper.GetConnection().ConnectionString);

            try
            {
                // Check if email already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlParameter[] checkParams = { new SqlParameter("@Email", email) };
                int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkQuery, checkParams));
                System.Diagnostics.Debug.WriteLine($"[DEBUG] Email check count for {email}: {count}");

                if (count > 0)
                    return false; // Email already exists

                // Insert new user
                string insertQuery = @"
            INSERT INTO Users (Email, PasswordHash, FullName, School)
            VALUES (@Email, @Password, @FullName, @School)";

                SqlParameter[] parameters = {
            new SqlParameter("@Email", email),
            new SqlParameter("@Password", HashPassword(password)),
            new SqlParameter("@FullName", fullName),
            new SqlParameter("@School", (object)school ?? DBNull.Value)
        };

                int rowsAffected = DatabaseHelper.ExecuteNonQuery(insertQuery, parameters);
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Registration Error: " + ex.Message);
                return false;
            }
        }


        // Hash password with salt
        private static string HashPassword(string password)
        {
            byte[] salt = new byte[16];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(salt);
            }

            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000, HashAlgorithmName.SHA256);
            byte[] hash = pbkdf2.GetBytes(32);

            byte[] hashBytes = new byte[48];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 32);

            return Convert.ToBase64String(hashBytes);
        }

        // Verify password
        private static bool VerifyPassword(string enteredPassword, string storedHash)
        {
            byte[] hashBytes = Convert.FromBase64String(storedHash);
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            var pbkdf2 = new Rfc2898DeriveBytes(enteredPassword, salt, 10000, HashAlgorithmName.SHA256);
            byte[] hash = pbkdf2.GetBytes(32);

            for (int i = 0; i < 32; i++)
            {
                if (hashBytes[i + 16] != hash[i])
                    return false;
            }
            return true;
        }

        // Login user
        public static bool LoginUser(string email, string password)
        {
            try
            {
                string query = @"
                    SELECT UserID, Email, PasswordHash, FullName, IsActive 
                    FROM Users 
                    WHERE Email = @Email AND IsActive = 1";

                SqlParameter[] parameters = {
                    new SqlParameter("@Email", email)
                };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    string storedHash = row["PasswordHash"].ToString();

                    if (!VerifyPassword(password, storedHash))
                        return false;

                    // Update last login
                    string updateQuery = "UPDATE Users SET LastLogin = GETDATE() WHERE UserID = @UserID";
                    SqlParameter[] updateParams = {
                        new SqlParameter("@UserID", row["UserID"])
                    };
                    DatabaseHelper.ExecuteNonQuery(updateQuery, updateParams);

                    // Create session
                    CreateSession(
                        userID: Convert.ToInt32(row["UserID"]),
                        email: row["Email"].ToString(),
                        fullName: row["FullName"].ToString()
                    );

                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Login Error: " + ex.Message);
                return false;
            }
        }

        // Create session
        private static void CreateSession(int userID, string email, string fullName)
        {
            HttpContext.Current.Session["UserID"] = userID;
            HttpContext.Current.Session["UserEmail"] = email;
            HttpContext.Current.Session["UserName"] = fullName;
        }

        // Clear session
        public static void ClearSession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }

        public static bool IsLoggedIn()
        {
            return HttpContext.Current.Session["UserID"] != null;
        }

        public static int GetCurrentUserID()
        {
            return HttpContext.Current.Session["UserID"] != null
                ? Convert.ToInt32(HttpContext.Current.Session["UserID"])
                : 0;
        }

        public static string GetCurrentUserName()
        {
            return HttpContext.Current.Session["UserName"]?.ToString() ?? "Guest";
        }

        public static string GetCurrentUserEmail()
        {
            return HttpContext.Current.Session["UserEmail"]?.ToString();
        }

        public static string GetCurrentFormLevel()
        {
            return HttpContext.Current.Session["FormLevel"]?.ToString() ?? "Form 4";
        }


        public static DataRow GetUserDetails(int userID)
        {
            try
            {
                string query = "SELECT * FROM Users WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Get User Details Error: " + ex.Message);
                return null;
            }
        }

        // Update user profile
        public static bool UpdateUserProfile(int userID, string fullName, string school)
        {
            try
            {
                string query = @"
                    UPDATE Users 
                    SET FullName = @FullName, 
                        School = @School 
                    WHERE UserID = @UserID";

                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@FullName", fullName),
                    new SqlParameter("@School", (object)school ?? DBNull.Value)
                };

                int rowsAffected = DatabaseHelper.ExecuteNonQuery(query, parameters);

                if (rowsAffected > 0)
                {
                    HttpContext.Current.Session["UserName"] = fullName;
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Update Profile Error: " + ex.Message);
                return false;
            }
        }

        // Change password
        public static bool ChangePassword(int userID, string oldPassword, string newPassword)
        {
            try
            {
                string query = "SELECT PasswordHash FROM Users WHERE UserID = @UserID";
                SqlParameter[] selectParams = { new SqlParameter("@UserID", userID) };
                DataTable dt = DatabaseHelper.ExecuteQuery(query, selectParams);

                if (dt.Rows.Count > 0)
                {
                    string currentPassword = dt.Rows[0]["PasswordHash"].ToString();

                    if (VerifyPassword(oldPassword, currentPassword))
                    {
                        string updateQuery = "UPDATE Users SET PasswordHash = @Password WHERE UserID = @UserID";
                        SqlParameter[] updateParams = {
                            new SqlParameter("@Password", HashPassword(newPassword)),
                            new SqlParameter("@UserID", userID)
                        };

                        int rowsAffected = DatabaseHelper.ExecuteNonQuery(updateQuery, updateParams);
                        return rowsAffected > 0;
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Change Password Error: " + ex.Message);
                return false;
            }
        }
    }
}
