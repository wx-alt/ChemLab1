using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;

namespace ChemLab1.Profile
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                LoadUserProfile();
                LoadRecentActivity();
            }

            // Handle avatar upload
            if (fileUpload.HasFile)
            {
                UploadAvatar();
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT UserID, Username, Email, UserType, Age, CreatedAt, 
                                       Points, BadgeCount, QuizCount, Streak, ProfilePicture
                                FROM Users WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Basic Info
                    lblUserID.Text = reader["UserID"].ToString();
                    lblFullName.Text = reader["Username"].ToString();
                    txtFullName.Text = reader["Username"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    lblUserType.Text = reader["UserType"].ToString();

                    // Age
                    if (reader["Age"] != DBNull.Value)
                    {
                        txtAge.Text = reader["Age"].ToString();
                    }

                    // Joined Date
                    DateTime joinedDate = Convert.ToDateTime(reader["CreatedAt"]);
                    lblJoinedDate.Text = joinedDate.ToString("MMMM dd, yyyy");

                    // Stats
                    lblPoints.Text = reader["Points"].ToString();
                    lblBadges.Text = reader["BadgeCount"].ToString();
                    lblQuizzes.Text = reader["QuizCount"].ToString();
                    lblStreak.Text = reader["Streak"].ToString();

                    // Role Badge
                    string userType = reader["UserType"].ToString();
                    lblRole.Text = userType;
                    lblRole.CssClass = "role-badge role-" + userType.ToLower();

                    // Profile Picture
                    if (reader["ProfilePicture"] != DBNull.Value && !string.IsNullOrEmpty(reader["ProfilePicture"].ToString()))
                    {
                        imgAvatar.ImageUrl = reader["ProfilePicture"].ToString();
                    }
                }
            }
        }

        private void LoadRecentActivity()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT TOP 5 ActivityType, Title, CreatedAt 
                                FROM UserActivity 
                                WHERE UserID = @UserID 
                                ORDER BY CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptActivity.DataSource = dt;
                rptActivity.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"UPDATE Users 
                                SET Username = @Username, 
                                    Email = @Email, 
                                    Age = @Age 
                                WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Username", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                if (!string.IsNullOrEmpty(txtAge.Text))
                {
                    cmd.Parameters.AddWithValue("@Age", Convert.ToInt32(txtAge.Text));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Age", DBNull.Value);
                }

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect(Request.RawUrl);
        }

        private void UploadAvatar()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string fileName = Path.GetFileName(fileUpload.FileName);
                string fileExtension = Path.GetExtension(fileName).ToLower();

                // Validate file type
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
                {
                    return;
                }

                // Create directory if it doesn't exist
                string uploadFolder = Server.MapPath("~/Images/Avatars/");
                if (!Directory.Exists(uploadFolder))
                {
                    Directory.CreateDirectory(uploadFolder);
                }

                // Save file with unique name
                string uniqueFileName = userId + "_" + DateTime.Now.Ticks + fileExtension;
                string filePath = Path.Combine(uploadFolder, uniqueFileName);
                fileUpload.SaveAs(filePath);

                // Update database
                string relativePath = "~/Images/Avatars/" + uniqueFileName;
                string connStr = ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "UPDATE Users SET ProfilePicture = @ProfilePicture WHERE UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProfilePicture", relativePath);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                Response.Redirect(Request.RawUrl);
            }
            catch (Exception ex)
            {
                // Log error
            }
        }

        protected string GetActivityIconClass(string activityType)
        {
            switch (activityType.ToLower())
            {
                case "quiz":
                    return "quiz";
                case "module":
                    return "module";
                case "badge":
                    return "badge";
                default:
                    return "quiz";
            }
        }

        protected string GetActivityIcon(string activityType)
        {
            switch (activityType.ToLower())
            {
                case "quiz":
                    return "📝";
                case "module":
                    return "📚";
                case "badge":
                    return "🏆";
                default:
                    return "✓";
            }
        }

        protected string GetTimeAgo(object createdAt)
        {
            if (createdAt == null || createdAt == DBNull.Value)
                return "Unknown";

            DateTime date = Convert.ToDateTime(createdAt);
            TimeSpan timeSpan = DateTime.Now - date;

            if (timeSpan.TotalMinutes < 1)
                return "Just now";
            if (timeSpan.TotalMinutes < 60)
                return $"{(int)timeSpan.TotalMinutes} minutes ago";
            if (timeSpan.TotalHours < 24)
                return $"{(int)timeSpan.TotalHours} hours ago";
            if (timeSpan.TotalDays < 7)
                return $"{(int)timeSpan.TotalDays} days ago";

            return date.ToString("MMM dd, yyyy");
        }
    }
}
