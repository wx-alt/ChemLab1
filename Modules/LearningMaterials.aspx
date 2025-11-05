<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LearningMaterials.aspx.cs" Inherits="ChemLab1.Modules.LearningMaterials" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Modules - ChemLab</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            overflow-x: hidden;
        }

        .page-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 320px;
            background: white;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            overflow-y: auto;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 1000;
        }

        .sidebar.closed {
            transform: translateX(-100%);
        }

        .sidebar-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 24px;
            color: white;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .sidebar-header h2 {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .sidebar-header p {
            font-size: 13px;
            opacity: 0.9;
        }

        .sidebar-content {
            padding: 16px;
        }

        /* Form Level Section */
        .form-level {
            margin-bottom: 12px;
        }

        .form-level-btn {
            width: 100%;
            padding: 14px 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .form-level-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.4);
        }

        .form-level-btn .arrow {
            transition: transform 0.3s ease;
        }

        .form-level-btn.active .arrow {
            transform: rotate(90deg);
        }

        /* Topic Section */
        .topics-container {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .topics-container.expanded {
            max-height: 2000px;
        }

        .topic-item {
            margin: 8px 0;
            padding-left: 12px;
            border-left: 3px solid #e5e7eb;
        }

        .topic-btn {
            width: 100%;
            padding: 12px 14px;
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #374151;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.2s ease;
        }

        .topic-btn:hover {
            background: #f3f4f6;
            border-color: #667eea;
            color: #667eea;
        }

        .topic-btn .arrow {
            font-size: 12px;
            transition: transform 0.3s ease;
        }

        .topic-btn.active {
            background: #ede9fe;
            border-color: #667eea;
            color: #667eea;
        }

        .topic-btn.active .arrow {
            transform: rotate(90deg);
        }

        /* Subtopic Section */
        .subtopics-container {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 8px;
        }

        .subtopics-container.expanded {
            max-height: 1000px;
        }

        .subtopic-link {
            display: flex;
            align-items: center;
            padding: 10px 14px;
            margin: 4px 0;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            color: #6b7280;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .subtopic-link:hover {
            background: #f9fafb;
            border-color: #667eea;
            color: #667eea;
            transform: translateX(4px);
        }

        .subtopic-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        .subtopic-link.completed {
            border-color: #10b981;
        }

        .subtopic-link .check-icon {
            margin-left: auto;
            color: #10b981;
            font-weight: bold;
            display: none;
        }

        .subtopic-link.completed .check-icon {
            display: block;
        }

        /* Main Content Area */
        .main-content {
            flex: 1;
            margin-left: 320px;
            padding: 32px;
            transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .main-content.expanded {
            margin-left: 0;
        }

        .content-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            min-height: 600px;
            max-width: 900px;
            margin: 0 auto;
        }

        .content-header {
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 2px solid #f3f4f6;
        }

        .content-code {
            display: inline-block;
            padding: 6px 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .content-title {
            font-size: 32px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 12px;
        }

        .content-meta {
            display: flex;
            gap: 16px;
            color: #6b7280;
            font-size: 14px;
        }

        .content-body {
            font-size: 16px;
            line-height: 1.8;
            color: #374151;
        }

        .content-body h3 {
            font-size: 24px;
            font-weight: 600;
            color: #1f2937;
            margin: 32px 0 16px;
        }

        .content-body p {
            margin-bottom: 16px;
        }

        .content-body ul, .content-body ol {
            margin: 16px 0;
            padding-left: 24px;
        }

        .content-body li {
            margin-bottom: 8px;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 16px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #6b7280;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #9ca3af;
        }

        /* Hamburger Button */
        .hamburger-btn {
            position: fixed;
            top: 24px;
            left: 24px;
            width: 48px;
            height: 48px;
            background: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 999;
            transition: all 0.3s ease;
        }

        .hamburger-btn:hover {
            transform: scale(1.05);
        }

        .hamburger-btn span {
            width: 24px;
            height: 3px;
            background: #667eea;
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        .hamburger-btn.active span:nth-child(1) {
            transform: rotate(45deg) translate(7px, 7px);
        }

        .hamburger-btn.active span:nth-child(2) {
            opacity: 0;
        }

        .hamburger-btn.active span:nth-child(3) {
            transform: rotate(-45deg) translate(7px, -7px);
        }

        /* Overlay */
        .overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 999;
        }

        .overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Progress Indicator */
        .progress-indicator {
            position: fixed;
            bottom: 32px;
            right: 32px;
            background: white;
            padding: 16px 24px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            display: none;
            align-items: center;
            gap: 12px;
            z-index: 100;
        }

        .progress-indicator.show {
            display: flex;
        }

        .progress-circle {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: conic-gradient(#667eea 0%, #764ba2 var(--progress), #e5e7eb var(--progress));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #667eea;
            font-size: 14px;
        }

        .progress-text {
            font-size: 14px;
            color: #374151;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 280px;
            }

            .sidebar.closed {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .hamburger-btn {
                display: flex;
            }

            .content-card {
                padding: 24px;
            }

            .content-title {
                font-size: 24px;
            }
        }

        /* Scrollbar Styling */
        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #f3f4f6;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #667eea;
            border-radius: 3px;
        }

        /* Navigation Buttons */
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            padding-top: 32px;
            border-top: 2px solid #f3f4f6;
        }

        .nav-btn {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .nav-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.4);
        }

        .nav-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .progress-line-container {
            position: fixed;
            left: 320px; /* Sidebar width */
            top: 100px; /* Adjust to start below header if needed */
            width: 8px;
            height: calc(100vh - 120px); /* Adjust for header/footer */
            background: #e5e7eb;
            border-radius: 4px;
            z-index: 50;
        }

        .progress-line-fill {
            width: 100%;
            height: 0%;
            background: #667eea;
            border-radius: 4px;
            transition: height 0.2s ease;
        }

        .progress-line-tick {
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 18px;
            color: #10b981;
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="page-container">
            <!-- Hamburger Button -->
            <button type="button" class="hamburger-btn" id="hamburgerBtn">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <!-- Overlay -->
            <div class="overlay" id="overlay"></div>

            <!-- Sidebar -->
            <div class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <h2>📚 Learning Modules</h2>
                    <p>Chemistry Form 4 & 5</p>
                </div>
                <div class="sidebar-content">
                    <asp:Repeater ID="rptFormLevels" runat="server" OnItemDataBound="rptFormLevels_ItemDataBound">
                        <ItemTemplate>
                            <div class="form-level">
                                <button type="button" class="form-level-btn" onclick="toggleFormLevel(this, <%# Eval("FormLevel") %>)">
                                    <span>Form <%# Eval("FormLevel") %></span>
                                    <span class="arrow">▶</span>
                                </button>
                                <div class="topics-container" id="form<%# Eval("FormLevel") %>Topics">
                                    <asp:Repeater ID="rptTopics" runat="server" OnItemDataBound="rptTopics_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="topic-item">
                                                <button type="button" class="topic-btn" onclick="toggleTopic(this, <%# Eval("TopicID") %>)">
                                                    <span><%# Eval("TopicCode") %> - <%# Eval("TopicTitle") %></span>
                                                    <span class="arrow">▶</span>
                                                </button>
                                                <div class="subtopics-container" id="topic<%# Eval("TopicID") %>Subtopics">
                                                    <asp:Repeater ID="rptSubTopics" runat="server">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkSubTopic" runat="server" 
                                                                CommandName="ViewContent" 
                                                                CommandArgument='<%# Eval("SubTopicID") %>' 
                                                                CssClass="subtopic-link"
                                                                OnCommand="SubTopic_Command"
                                                                data-subtopic-id='<%# Eval("SubTopicID") %>'>
                                                                <span><%# Eval("SubTopicCode") %> - <%# Eval("SubTopicTitle") %></span>
                                                                <span class="check-icon">✓</span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content" id="mainContent">
                <div class="content-card">
                    <asp:Panel ID="pnlContent" runat="server" Visible="false">
                        <div class="content-header">
                            <div class="content-code">
                                <asp:Literal ID="litSubTopicCode" runat="server"></asp:Literal>
                            </div>
                            <h1 class="content-title">
                                <asp:Literal ID="litSubTopicTitle" runat="server"></asp:Literal>
                            </h1>
                            <div class="content-meta">
                                <span>📖 <asp:Literal ID="litTopicTitle" runat="server"></asp:Literal></span>
                                <span>🎓 Form <asp:Literal ID="litFormLevel" runat="server"></asp:Literal></span>
                            </div>
                        </div>
                        <div class="content-body" id="contentBody">
                            <asp:Literal ID="litContent" runat="server"></asp:Literal>
                        </div>
                        <div class="nav-buttons">
                            <asp:LinkButton ID="btnPrevious" runat="server" CssClass="nav-btn" OnClick="NavigatePrevious" Visible="false">
                                ← Previous
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnNext" runat="server" CssClass="nav-btn" OnClick="NavigateNext" Visible="false">
                                Next →
                            </asp:LinkButton>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlEmpty" runat="server" Visible="true">
                        <div class="empty-state">
                            <div class="empty-state-icon">📚</div>
                            <h3>Select a Topic to Begin</h3>
                            <p>Choose a subtopic from the sidebar to start learning</p>
                        </div>
                    </asp:Panel>
                </div>
            </div>

            <!-- Progress Indicator -->
            <div class="progress-indicator" id="progressIndicator">
                <div class="progress-line-fill" id="progressLineFill"></div>
                <div class="progress-line-tick" id="progressLineTick">✔</div>
            </div>

            <div class="progress-line-container">
                <div class="progress-line-fill" id="progressLineFill"></div>
                <div class="progress-line-tick" id="progressLineTick">✔</div>
            </div>
        </div>


        <asp:HiddenField ID="hdnCurrentSubTopicID" runat="server" />
        <asp:HiddenField ID="hdnCompletedSubTopics" runat="server" Value="[]" />
        <asp:HiddenField ID="hdnExpandedFormLevel" runat="server" />
        <asp:HiddenField ID="hdnExpandedTopicID" runat="server" />

    </form>

    <script>
        // Sidebar Toggle
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');
        const mainContent = document.getElementById('mainContent');

        hamburgerBtn.addEventListener('click', function() {
            sidebar.classList.toggle('closed');
            overlay.classList.toggle('active');
            hamburgerBtn.classList.toggle('active');
        });

        overlay.addEventListener('click', function() {
            sidebar.classList.add('closed');
            overlay.classList.remove('active');
            hamburgerBtn.classList.remove('active');
        });

        // Form Level Toggle
        function toggleFormLevel(btn, formLevel) {
            const container = document.getElementById('form' + formLevel + 'Topics');
            const isExpanded = container.classList.contains('expanded');

            // Close all form levels
            document.querySelectorAll('.topics-container').forEach(c => c.classList.remove('expanded'));
            document.querySelectorAll('.form-level-btn').forEach(b => b.classList.remove('active'));

            if (!isExpanded) {
                container.classList.add('expanded');
                btn.classList.add('active');
                document.getElementById('<%= hdnExpandedFormLevel.ClientID %>').value = formLevel;
            } else {
                document.getElementById('<%= hdnExpandedFormLevel.ClientID %>').value = '';
            }
        }

        // Topic Toggle
        function toggleTopic(btn, topicId) {
            const container = document.getElementById('topic' + topicId + 'Subtopics');
            const isExpanded = container.classList.contains('expanded');

            if (!isExpanded) {
                container.classList.add('expanded');
                btn.classList.add('active');
                document.getElementById('<%= hdnExpandedTopicID.ClientID %>').value = topicId;
            } else {
                container.classList.remove('expanded');
                btn.classList.remove('active');
                document.getElementById('<%= hdnExpandedTopicID.ClientID %>').value = '';
            }
        }


        // Scroll Progress Tracking
        // Scroll-based vertical progress for current content
        const progressLineFill = document.getElementById('progressLineFill');
        const progressLineTick = document.getElementById('progressLineTick');

        function updateProgressLine() {
            const content = document.getElementById('contentBody');
            if (!content) return;

            const contentHeight = content.scrollHeight;
            const contentTop = content.offsetTop;
            const windowHeight = window.innerHeight;
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;

            // Calculate scroll percentage
            let scrollPercent = ((scrollTop + windowHeight - contentTop) / contentHeight) * 100;
            scrollPercent = Math.min(Math.max(scrollPercent, 0), 100); // clamp 0-100

            // Update vertical line fill
            progressLineFill.style.height = scrollPercent + '%';

            // Show tick when scrolled to bottom
            if (scrollPercent >= 100) {
                progressLineTick.style.display = 'block';
                markCurrentAsCompleted(); // mark subtopic as completed
            } else {
                progressLineTick.style.display = 'none';
            }
        }

        // Attach scroll listener
        window.addEventListener('scroll', updateProgressLine);
        window.addEventListener('resize', updateProgressLine);
        window.addEventListener('load', updateProgressLine);


        // Mark subtopic as completed
        function markCurrentAsCompleted() {
            const currentSubTopicId = document.getElementById('<%= hdnCurrentSubTopicID.ClientID %>').value;
            if (!currentSubTopicId) return;

            const completedField = document.getElementById('<%= hdnCompletedSubTopics.ClientID %>');
            let completed = JSON.parse(completedField.value || '[]');
            
            if (!completed.includes(currentSubTopicId)) {
                completed.push(currentSubTopicId);
                completedField.value = JSON.stringify(completed);
                
                // Add visual indicator
                const link = document.querySelector('[data-subtopic-id="' + currentSubTopicId + '"]');
                if (link) {
                    link.classList.add('completed');
                }

                // Save to localStorage
                localStorage.setItem('completedSubTopics', JSON.stringify(completed));
            }
        }

        // Load completed subtopics from localStorage
        window.addEventListener('load', function() {
            const expandedForm = document.getElementById('<%= hdnExpandedFormLevel.ClientID %>').value;
            if(expandedForm){
                const btn = document.querySelector('.form-level-btn[onclick*="toggleFormLevel(this, ' + expandedForm + ')"]');
                const container = document.getElementById('form' + expandedForm + 'Topics');
                if(btn && container){
                    container.classList.add('expanded');
                    btn.classList.add('active');
                }
            }

            // Restore expanded topic
            const expandedTopic = document.getElementById('<%= hdnExpandedTopicID.ClientID %>').value;
            if (expandedTopic) {
                const btn = document.querySelector('.topic-btn[onclick*="toggleTopic(this, ' + expandedTopic + ')"]');
                const container = document.getElementById('topic' + expandedTopic + 'Subtopics');
                if (btn && container) {
                    container.classList.add('expanded');
                    btn.classList.add('active');
                }
            }

        });

    </script>
</body>
</html>
