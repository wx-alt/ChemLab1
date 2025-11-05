    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ChemLab1.Dashboard.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ChemLab - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }

        .hamburger {
            width: 30px;
            height: 24px;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            z-index: 1001;
        }

        .hamburger span {
            width: 100%;
            height: 3px;
            background: #667eea;
            border-radius: 3px;
            transition: all 0.3s ease;
        }

        .hamburger.active span:nth-child(1) {
            transform: rotate(45deg) translate(8px, 8px);
        }

        .hamburger.active span:nth-child(2) {
            opacity: 0;
        }

        .hamburger.active span:nth-child(3) {
            transform: rotate(-45deg) translate(7px, -7px);
        }

        /* Sidebar Navigation */
        .sidebar {
            position: fixed;
            top: 0;
            right: -350px;
            width: 350px;
            height: 100vh;
            background: white;
            box-shadow: -5px 0 20px rgba(0,0,0,0.1);
            transition: right 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar.active {
            right: 0;
        }

        .sidebar-header {
            padding: 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 600;
            color: #667eea;
        }

        .user-info h3 {
            font-size: 1.25rem;
            margin-bottom: 0.25rem;
        }

        .user-info p {
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .user-stats {
            display: flex;
            gap: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(255,255,255,0.2);
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
        }

        .stat-label {
            font-size: 0.75rem;
            opacity: 0.9;
            margin-top: 0.25rem;
        }

        .nav-menu {
            padding: 1rem 0;
        }

        .nav-item {
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            color: #333;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            font-size: 1rem;
        }

        .nav-item:hover {
            background: #f3f4f6;
            color: #667eea;
        }

        .nav-item.active {
            background: #ede9fe;
            color: #667eea;
            border-right: 3px solid #667eea;
        }

        .nav-icon {
            font-size: 1.25rem;
            width: 24px;
            text-align: center;
        }

        .nav-divider {
            height: 1px;
            background: #e5e7eb;
            margin: 0.5rem 2rem;
        }

        /* Overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 999;
        }

        .overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .welcome-section {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .welcome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .welcome-text h1 {
            font-size: 2rem;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .welcome-text p {
            color: #6b7280;
            font-size: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
        }

        .stat-icon.purple {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-icon.blue {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
        }

        .stat-icon.green {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }

        .stat-icon.orange {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
        }

        .stat-content h3 {
            font-size: 2rem;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }

        .stat-content p {
            color: #6b7280;
            font-size: 0.875rem;
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
        }

        .view-all {
            color: #667eea;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .view-all:hover {
            text-decoration: underline;
        }

        /* Progress Items */
        .progress-item {
            padding: 1rem;
            border-radius: 10px;
            background: #f9fafb;
            margin-bottom: 1rem;
        }

        .progress-item:last-child {
            margin-bottom: 0;
        }

        .progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.75rem;
        }

        .progress-title {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.95rem;
        }

        .progress-percentage {
            color: #667eea;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e5e7eb;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            transition: width 0.3s ease;
        }

        /* Activity Feed */
        .activity-item {
            display: flex;
            gap: 1rem;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            background: #f9fafb;
        }

        .activity-item:last-child {
            margin-bottom: 0;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.25rem;
            font-size: 0.95rem;
        }

        .activity-time {
            color: #6b7280;
            font-size: 0.8rem;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #6b7280;
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal:hover {
            color: #1f2937;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #374151;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.2s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-textarea {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
            min-height: 100px;
            resize: vertical;
            font-family: 'Inter', sans-serif;
        }

        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #6b7280;
        }

        .empty-state-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .header {
                padding: 1rem;
            }

            .welcome-text h1 {
                font-size: 1.5rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .sidebar {
                width: 100%;
                right: -100%;
            }

            .action-buttons {
                width: 100%;
            }

            .btn {
                flex: 1;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <div class="logo-icon">⚗️</div>
                <span>ChemLab</span>
            </div>
            <div class="hamburger" onclick="toggleSidebar()">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>

        <!-- Sidebar Navigation -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="user-profile">
                    <div class="user-avatar">
                        <asp:Literal ID="litUserInitial" runat="server"></asp:Literal>
                    </div>
                    <div class="user-info">
                        <h3><asp:Literal ID="litUserName" runat="server"></asp:Literal></h3>
                        <p><asp:Literal ID="litUserEmail" runat="server"></asp:Literal></p>
                    </div>
                </div>
                <div class="user-stats">
                    <div class="stat-item">
                        <div class="stat-value"><asp:Literal ID="litTotalPoints" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Points</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><asp:Literal ID="litBadgeCount" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Badges</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><asp:Literal ID="litQuizCount" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Quizzes</div>
                    </div>
                </div>
            </div>
            <nav class="nav-menu">
                <a href="Home.aspx" class="nav-item active">
                    <span class="nav-icon">🏠</span>
                    <span>Home</span>
                </a>
                <a href="../Modules/LearningModules.aspx" class="nav-item">
                    <span class="nav-icon">📚</span>
                    <span>Learning Modules</span>
                </a>
                <a href="../Quiz/QuizList.aspx" class="nav-item">
                    <span class="nav-icon">📝</span>
                    <span>Quizzes</span>
                </a>
                <a href="../Classroom/Classroom.aspx" class="nav-item">
                    <span class="nav-icon">👥</span>
                    <span>Classroom</span>
                </a>
                <a href="../Achievements/Achievements.aspx" class="nav-item">
                    <span class="nav-icon">🏆</span>
                    <span>Achievements</span>
                </a>
                <a href="../Progress/Progress.aspx" class="nav-item">
                    <span class="nav-icon">📊</span>
                    <span>Progress</span>
                </a>
                <div class="nav-divider"></div>
                <a href="../Profile/Profile.aspx" class="nav-item">
                    <span class="nav-icon">👤</span>
                    <span>Profile</span>
                </a>
                <a href="../Bookmarks/Bookmarks.aspx" class="nav-item">
                    <span class="nav-icon">🔖</span>
                    <span>Bookmarks</span>
                </a>
                <a href="../Settings/Settings.aspx" class="nav-item">
                    <span class="nav-icon">⚙️</span>
                    <span>Settings</span>
                </a>
                <div class="nav-divider"></div>
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="nav-item" OnClick="btnLogout_Click">
                    <span class="nav-icon">🚪</span>
                    <span>Logout</span>
                </asp:LinkButton>
            </nav>
        </div>

        <!-- Overlay -->
        <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

        <!-- Main Content -->
        <div class="container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-header">
                    <div class="welcome-text">
                        <h1>Welcome back, <asp:Literal ID="litWelcomeName" runat="server"></asp:Literal>! 👋</h1>
                        <p>Ready to continue your chemistry journey?</p>
                    </div>
                    <div class="action-buttons">
                        <asp:Button ID="btnCreateClassroom" runat="server" CssClass="btn btn-primary" Text="➕ Create Classroom" OnClientClick="openModal('classroomModal'); return false;" Visible="false" />
                        <asp:Button ID="btnLinkChild" runat="server" CssClass="btn btn-secondary" Text="👨‍👩‍👧 Link Child" OnClientClick="openModal('linkChildModal'); return false;" Visible="false" />
                    </div>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon purple">
                        <span>⭐</span>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Literal ID="litPointsDisplay" runat="server">0</asp:Literal></h3>
                        <p>Total Points</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <span>🏆</span>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Literal ID="litBadgesDisplay" runat="server">0</asp:Literal></h3>
                        <p>Badges Earned</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">
                        <span>✅</span>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Literal ID="litQuizzesDisplay" runat="server">0</asp:Literal></h3>
                        <p>Quizzes Completed</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon orange">
                        <span>🔥</span>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Literal ID="litStreakDisplay" runat="server">0</asp:Literal></h3>
                        <p>Day Streak</p>
                    </div>
                </div>
            </div>

            <!-- Content Grid -->
            <div class="content-grid">
                <!-- Learning Progress -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">📚 Learning Progress</h2>
                        <a href="../Modules/LearningModules.aspx" class="view-all">View All →</a>
                    </div>
                    <asp:Repeater ID="rptProgress" runat="server">
                        <ItemTemplate>
                            <div class="progress-item">
                                <div class="progress-header">
                                    <span class="progress-title"><%# Eval("ModuleTitle") %></span>
                                    <span class="progress-percentage"><%# Eval("Progress") %>%</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style='width: <%# Eval("Progress") %>%'></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlNoProgress" runat="server" CssClass="empty-state" Visible="false">
                        <div class="empty-state-icon">📖</div>
                        <p>Start learning to see your progress here!</p>
                    </asp:Panel>
                </div>

                <!-- Recent Activity -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">🕐 Recent Activity</h2>
                    </div>
                    <asp:Repeater ID="rptActivity" runat="server">
                        <ItemTemplate>
                            <div class="activity-item">
                                <div class="activity-icon" style='background: <%# Eval("IconColor") %>'>
                                    <%# Eval("Icon") %>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title"><%# Eval("Title") %></div>
                                    <div class="activity-time"><%# Eval("TimeAgo") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlNoActivity" runat="server" CssClass="empty-state" Visible="false">
                        <div class="empty-state-icon">📋</div>
                        <p>No recent activity yet</p>
                    </asp:Panel>
                </div>
            </div>
        </div>

        <!-- Create Classroom Modal -->
        <div class="modal" id="classroomModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Create Classroom</h2>
                    <button type="button" class="close-modal" onclick="closeModal('classroomModal')">×</button>
                </div>
                <div class="form-group">
                    <label class="form-label">Classroom Name</label>
                    <asp:TextBox ID="txtClassroomName" runat="server" CssClass="form-input" placeholder="e.g., Form 4 Chemistry A"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="txtClassroomDesc" runat="server" CssClass="form-textarea" TextMode="MultiLine" placeholder="Brief description of the classroom"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Form Level</label>
                    <asp:DropDownList ID="ddlFormLevel" runat="server" CssClass="form-input">
                        <asp:ListItem Value="Form 4">Form 4</asp:ListItem>
                        <asp:ListItem Value="Form 5">Form 5</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Button ID="btnSubmitClassroom" runat="server" CssClass="btn btn-primary" Text="Create Classroom" OnClick="btnSubmitClassroom_Click" style="width: 100%;" />
            </div>
        </div>

        <!-- Link Child Modal -->
        <div class="modal" id="linkChildModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Link Child Account</h2>
                    <button type="button" class="close-modal" onclick="closeModal('linkChildModal')">×</button>
                </div>
                <div class="form-group">
                    <label class="form-label">Child's Email</label>
                    <asp:TextBox ID="txtChildEmail" runat="server" CssClass="form-input" placeholder="Enter child's registered email"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Verification Code (Optional)</label>
                    <asp:TextBox ID="txtVerificationCode" runat="server" CssClass="form-input" placeholder="If child provided a code"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmitLinkChild" runat="server" CssClass="btn btn-primary" Text="Send Link Request" OnClick="btnSubmitLinkChild_Click" style="width: 100%;" />
            </div>
        </div>
    </form>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            const hamburger = document.querySelector('.hamburger');

            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            hamburger.classList.toggle('active');
        }

        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('active');
            }
        }
    </script>
</body>
</html>
