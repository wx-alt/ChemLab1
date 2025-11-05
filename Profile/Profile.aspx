<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ChemLab1.Profile.Profile" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - ChemLab</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            color: white;
            font-size: 28px;
            font-weight: 600;
        }

        .hamburger {
            width: 30px;
            height: 25px;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .hamburger span {
            width: 100%;
            height: 3px;
            background: white;
            border-radius: 3px;
            transition: all 0.3s;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            right: -350px;
            width: 350px;
            height: 100vh;
            background: white;
            box-shadow: -5px 0 20px rgba(0, 0, 0, 0.2);
            transition: right 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar.active {
            right: 0;
        }

        .sidebar-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-header h2 {
            font-size: 22px;
        }

        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background 0.3s;
        }

        .close-btn:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
        }

        .sidebar-menu li {
            border-bottom: 1px solid #f0f0f0;
        }

        .sidebar-menu a {
            display: block;
            padding: 18px 25px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
            font-size: 16px;
        }

        .sidebar-menu a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding-left: 35px;
        }

        .sidebar-menu a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 999;
        }

        .overlay.active {
            display: block;
        }

        /* Profile Content */
        .profile-container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            margin-top: 20px;
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .avatar-section {
            margin-bottom: 25px;
        }

        .avatar-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
        }

        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #667eea;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .avatar-upload {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
        }

        .avatar-upload:hover {
            transform: scale(1.1);
        }

        .avatar-upload svg {
            width: 20px;
            height: 20px;
            fill: white;
        }

        .role-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .role-student {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .role-teacher {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .role-parent {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .profile-name {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .profile-email {
            color: #666;
            font-size: 15px;
            margin-bottom: 20px;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 30px;
        }

        .stat-item {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            border-radius: 15px;
            color: white;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            opacity: 0.9;
        }

        /* Info Section */
        .info-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .info-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .info-header h2 {
            font-size: 24px;
            color: #333;
        }

        .edit-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .edit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .info-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }

        .info-label {
            font-size: 13px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .info-value {
            font-size: 18px;
            color: #333;
            font-weight: 600;
        }

        .info-item input {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .info-item input:focus {
            outline: none;
            border-color: #667eea;
        }

        .info-item input:disabled {
            background: transparent;
            border: none;
            padding: 0;
            font-weight: 600;
            color: #333;
        }

        /* Activity Section */
        .activity-section {
            margin-top: 30px;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .activity-section h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 25px;
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            transition: transform 0.3s;
        }

        .activity-item:hover {
            transform: translateX(5px);
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 24px;
        }

        .activity-icon.quiz {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .activity-icon.module {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .activity-icon.badge {
            background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .activity-time {
            font-size: 13px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 968px) {
            .profile-container {
                grid-template-columns: 1fr;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                right: -100%;
            }

            .profile-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1>My Profile</h1>
                <div class="hamburger" onclick="toggleSidebar()">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>

            <!-- Profile Container -->
            <div class="profile-container">
                <!-- Left Card - Avatar & Stats -->
                <div class="profile-card">
                    <div class="avatar-section">
                        <div class="avatar-container">
                            <asp:Image ID="imgAvatar" runat="server" CssClass="avatar" ImageUrl="~/Images/default-avatar.png" />
                            <div class="avatar-upload" onclick="document.getElementById('fileUpload').click()">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
                                </svg>
                            </div>
                            <asp:FileUpload ID="fileUpload" runat="server" Style="display: none;" onchange="uploadAvatar()" />
                        </div>
                        <asp:Label ID="lblRole" runat="server" CssClass="role-badge role-student" Text="Student"></asp:Label>
                    </div>

                    <div class="profile-name">
                        <asp:Label ID="lblFullName" runat="server" Text="Loading..."></asp:Label>
                    </div>
                    <div class="profile-email">
                        <asp:Label ID="lblEmail" runat="server" Text="email@example.com"></asp:Label>
                    </div>

                    <div class="profile-stats">
                        <div class="stat-item">
                            <div class="stat-value">
                                <asp:Label ID="lblPoints" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-label">Total Points</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">
                                <asp:Label ID="lblBadges" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-label">Badges Earned</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">
                                <asp:Label ID="lblQuizzes" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-label">Quizzes Completed</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">
                                <asp:Label ID="lblStreak" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-label">Day Streak</div>
                        </div>
                    </div>
                </div>

                <!-- Right Card - Info -->
                <div class="info-card">
                    <div class="info-header">
                        <h2>Personal Information</h2>
                        <button type="button" class="edit-btn" onclick="toggleEdit()">
                            <span id="editBtnText">Edit Profile</span>
                        </button>
                    </div>

                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">User ID</div>
                            <div class="info-value">
                                <asp:Label ID="lblUserID" runat="server" Text=""></asp:Label>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Full Name</div>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="info-value" Enabled="false"></asp:TextBox>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Email Address</div>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="info-value" Enabled="false"></asp:TextBox>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Age</div>
                            <asp:TextBox ID="txtAge" runat="server" CssClass="info-value" Enabled="false" TextMode="Number"></asp:TextBox>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Role</div>
                            <div class="info-value">
                                <asp:Label ID="lblUserType" runat="server" Text=""></asp:Label>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Joined Date</div>
                            <div class="info-value">
                                <asp:Label ID="lblJoinedDate" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>

                    <div style="margin-top: 30px; display: none;" id="saveSection">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="edit-btn" OnClick="btnSave_Click" style="margin-right: 10px;" />
                        <button type="button" class="edit-btn" onclick="cancelEdit()" style="background: #6c757d;">Cancel</button>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="activity-section">
                <h2>Recent Activity</h2>
                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <div class="activity-list">
                            <div class="activity-item">
                                <div class="activity-icon <%# GetActivityIconClass(Eval("ActivityType").ToString()) %>">
                                    <%# GetActivityIcon(Eval("ActivityType").ToString()) %>
                                </div>
                                <div class="activity-details">
                                    <div class="activity-title"><%# Eval("Title") %></div>
                                    <div class="activity-time"><%# GetTimeAgo(Eval("CreatedAt")) %></div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h2>Menu</h2>
                <button class="close-btn" onclick="toggleSidebar()">&times;</button>
            </div>
            <ul class="sidebar-menu">
                <li><a href="../Dashboard/Home.aspx">🏠 Home</a></li>
                <li><a href="../Modules/LearningMaterials.aspx">📚 Learning Modules</a></li>
                <li><a href="../Quiz/QuizList.aspx">📝 Quiz</a></li>
                <li><a href="../Classroom/Classroom.aspx">👥 Classroom</a></li>
                <li><a href="../Achievements/Achievements.aspx">🏆 Achievements</a></li>
                <li><a href="../Progress/Progress.aspx">📊 Progress</a></li>
                <li><a href="Profile.aspx" class="active">👤 Profile</a></li>
                <li><a href="../Bookmarks/Bookmarks.aspx">🔖 Bookmarks</a></li>
                <li><a href="../Settings/Settings.aspx">⚙️ Settings</a></li>
                <li><a href="../Logout.aspx">🚪 Logout</a></li>
            </ul>
        </div>
    </form>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        let isEditing = false;

        function toggleEdit() {
            isEditing = !isEditing;
            const txtFullName = document.getElementById('<%= txtFullName.ClientID %>');
            const txtEmail = document.getElementById('<%= txtEmail.ClientID %>');
            const txtAge = document.getElementById('<%= txtAge.ClientID %>');
            const editBtnText = document.getElementById('editBtnText');
            const saveSection = document.getElementById('saveSection');

            if (isEditing) {
                txtFullName.disabled = false;
                txtEmail.disabled = false;
                txtAge.disabled = false;
                editBtnText.textContent = 'Editing...';
                saveSection.style.display = 'block';
            } else {
                txtFullName.disabled = true;
                txtEmail.disabled = true;
                txtAge.disabled = true;
                editBtnText.textContent = 'Edit Profile';
                saveSection.style.display = 'none';
            }
        }

        function cancelEdit() {
            location.reload();
        }

        function uploadAvatar() {
            const form = document.getElementById('form1');
            form.submit();
        }
    </script>
</body>
</html>
