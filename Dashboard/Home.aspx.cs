using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ChemLab1.Dashboard
{
    public partial class Home : System.Web.UI.Page
    {
        private string connectionString;
        private int currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize connection string safely
            connectionString = ConfigurationManager.ConnectionStrings["ChemLabConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                throw new Exception("Connection string 'ChemLabConnection' not found in web.config");
            }
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            currentUserId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                LoadUserData();
                LoadUserStats();
                LoadLearningProgress();
                LoadRecentActivity();
                SetRoleBasedButtons();
            }
        }

        private void LoadUserData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT FullName, Email, TotalPoints, 
                                (SELECT COUNT(*) FROM UserBadges WHERE UserID = @UserID) as BadgeCount,
                                (SELECT COUNT(*) FROM QuizAttempts WHERE UserID = @UserID) as QuizCount
                                FROM Users WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", currentUserId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string fullName = reader["FullName"].ToString();
                    string email = reader["Email"].ToString();
                    int totalPoints = Convert.ToInt32(reader["TotalPoints"]);
                    int badgeCount = Convert.ToInt32(reader["BadgeCount"]);
                    int quizCount = Convert.ToInt32(reader["QuizCount"]);

                    // Set user info in sidebar
                    litUserName.Text = fullName;
                    litUserEmail.Text = email;
                    litUserInitial.Text = fullName.Substring(0, 1).ToUpper();

                    // Set welcome message
                    litWelcomeName.Text = fullName.Split(' ')[0]; // First name only

                    // Set stats in sidebar
                    litTotalPoints.Text = totalPoints.ToString();
                    litBadgeCount.Text = badgeCount.ToString();
                    litQuizCount.Text = quizCount.ToString();

                    // Set stats in cards
                    litPointsDisplay.Text = totalPoints.ToString();
                    litBadgesDisplay.Text = badgeCount.ToString();
                    litQuizzesDisplay.Text = quizCount.ToString();

                    // Calculate streak (simplified - you can enhance this)
                    litStreakDisplay.Text = CalculateStreak().ToString();
                }

                reader.Close();
            }
        }

        private void LoadUserStats()
        {
            // Stats are already loaded in LoadUserData
        }

        private void LoadLearningProgress()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Get modules with user progress
                string query = @"SELECT TOP 5 
                                LM.ModuleTitle,
                                ISNULL(
                                    (SELECT COUNT(DISTINCT QA.QuizID) * 100.0 / 
                                    NULLIF((SELECT COUNT(*) FROM Quizzes WHERE ModuleID = LM.ModuleID), 0)
                                    FROM QuizAttempts QA
                                    INNER JOIN Quizzes Q ON QA.QuizID = Q.QuizID
                                    WHERE QA.UserID = @UserID AND Q.ModuleID = LM.ModuleID), 0
                                ) as Progress
                                FROM LearningModules LM
                                WHERE LM.IsActive = 1
                                ORDER BY LM.DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", currentUserId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);

                if (dt.Rows.Count > 0)
                {
                    rptProgress.DataSource = dt;
                    rptProgress.DataBind();
                    pnlNoProgress.Visible = false;
                }
                else
                {
                    pnlNoProgress.Visible = true;
                }
            }
        }

        private void LoadRecentActivity()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 5 * FROM (
                                    SELECT 
                                        'Completed Quiz' as Title,
                                        Q.QuizTitle as Details,
                                        QA.AttemptDate as ActivityDate,
                                        '✅' as Icon,
                                        'linear-gradient(135deg, #10b981 0%, #059669 100%)' as IconColor
                                    FROM QuizAttempts QA
                                    INNER JOIN Quizzes Q ON QA.QuizID = Q.QuizID
                                    WHERE QA.UserID = @UserID
                                    
                                    UNION ALL
                                    
                                    SELECT 
                                        'Earned Badge' as Title,
                                        B.BadgeName as Details,
                                        UB.EarnedDate as ActivityDate,
                                        '🏆' as Icon,
                                        'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)' as IconColor
                                    FROM UserBadges UB
                                    INNER JOIN Badges B ON UB.BadgeID = B.BadgeID
                                    WHERE UB.UserID = @UserID
                                    
                                    UNION ALL
                                    
                                    SELECT 
                                        'Bookmarked Module' as Title,
                                        LM.ModuleTitle as Details,
                                        BM.BookmarkedDate as ActivityDate,
                                        '🔖' as Icon,
                                        'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' as IconColor
                                    FROM Bookmarks BM
                                    INNER JOIN LearningModules LM ON BM.ModuleID = LM.ModuleID
                                    WHERE BM.UserID = @UserID
                                ) AS Activities
                                ORDER BY ActivityDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", currentUserId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);

                if (dt.Rows.Count > 0)
                {
                    // Add TimeAgo column
                    dt.Columns.Add("TimeAgo", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        DateTime activityDate = Convert.ToDateTime(row["ActivityDate"]);
                        row["TimeAgo"] = GetTimeAgo(activityDate);
                        row["Title"] = row["Title"] + ": " + row["Details"];
                    }

                    rptActivity.DataSource = dt;
                    rptActivity.DataBind();
                    pnlNoActivity.Visible = false;
                }
                else
                {
                    pnlNoActivity.Visible = true;
                }
            }
        }

        private void SetRoleBasedButtons()
        {
            // Check user role from session or database
            string userRole = Session["UserRole"]?.ToString() ?? "Student";

            if (userRole == "Teacher")
            {
                btnCreateClassroom.Visible = true;
                btnLinkChild.Visible = false;
            }
            else if (userRole == "Parent")
            {
                btnCreateClassroom.Visible = false;
                btnLinkChild.Visible = true;
            }
            else // Student
            {
                btnCreateClassroom.Visible = false;
                btnLinkChild.Visible = false;
            }
        }

        private int CalculateStreak()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Simple streak calculation - count consecutive days with activity
                string query = @"SELECT COUNT(DISTINCT CAST(AttemptDate AS DATE)) as DayCount
                                FROM QuizAttempts
                                WHERE UserID = @UserID 
                                AND AttemptDate >= DATEADD(day, -30, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", currentUserId);

                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }

        private string GetTimeAgo(DateTime dateTime)
        {
            TimeSpan timeSpan = DateTime.Now - dateTime;

            if (timeSpan.TotalMinutes < 1)
                return "Just now";
            if (timeSpan.TotalMinutes < 60)
                return $"{(int)timeSpan.TotalMinutes} minutes ago";
            if (timeSpan.TotalHours < 24)
                return $"{(int)timeSpan.TotalHours} hours ago";
            if (timeSpan.TotalDays < 7)
                return $"{(int)timeSpan.TotalDays} days ago";
            if (timeSpan.TotalDays < 30)
                return $"{(int)(timeSpan.TotalDays / 7)} weeks ago";

            return dateTime.ToString("MMM dd, yyyy");
        }

        protected void btnSubmitClassroom_Click(object sender, EventArgs e)
        {
            // Note: You'll need to create a Classrooms table in your database
            string classroomName = txtClassroomName.Text.Trim();
            string description = txtClassroomDesc.Text.Trim();
            string formLevel = ddlFormLevel.SelectedValue;

            if (string.IsNullOrEmpty(classroomName))
            {
                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Please enter a classroom name');", true);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // You'll need to create this table
                    string query = @"INSERT INTO Classrooms (ClassroomName, Description, FormLevel, TeacherID, CreatedDate)
                                    VALUES (@Name, @Description, @FormLevel, @TeacherID, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", classroomName);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@FormLevel", formLevel);
                    cmd.Parameters.AddWithValue("@TeacherID", currentUserId);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, GetType(), "success",
                        "alert('Classroom created successfully!'); closeModal('classroomModal');", true);

                    // Clear form
                    txtClassroomName.Text = "";
                    txtClassroomDesc.Text = "";
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error creating classroom: {ex.Message}');", true);
            }
        }

        protected void btnSubmitLinkChild_Click(object sender, EventArgs e)
        {
            string childEmail = txtChildEmail.Text.Trim();
            string verificationCode = txtVerificationCode.Text.Trim();

            if (string.IsNullOrEmpty(childEmail))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Please enter child email');", true);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check if child exists
                    string checkQuery = "SELECT UserID FROM Users WHERE Email = @Email";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Email", childEmail);

                    conn.Open();
                    object childUserId = checkCmd.ExecuteScalar();

                    if (childUserId != null)
                    {
                        // You'll need to create a ParentChildLinks table
                        string linkQuery = @"INSERT INTO ParentChildLinks (ParentID, ChildID, LinkedDate, IsApproved)
                                           VALUES (@ParentID, @ChildID, GETDATE(), 0)";

                        SqlCommand linkCmd = new SqlCommand(linkQuery, conn);
                        linkCmd.Parameters.AddWithValue("@ParentID", currentUserId);
                        linkCmd.Parameters.AddWithValue("@ChildID", childUserId);

                        linkCmd.ExecuteNonQuery();

                        ScriptManager.RegisterStartupScript(this, GetType(), "success",
                            "alert('Link request sent! Waiting for child approval.'); closeModal('linkChildModal');", true);

                        txtChildEmail.Text = "";
                        txtVerificationCode.Text = "";
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "error",
                            "alert('No user found with that email.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error linking child: {ex.Message}');", true);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Update last login
            // Update last login
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET LastLogin = GETDATE() WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", currentUserId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Clear session
            Session.Clear();
            Session.Abandon();

            // Redirect to login
            Response.Redirect("~/Login.aspx");
        }
    }
}
