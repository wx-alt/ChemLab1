using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChemLab1.Modules
{
    public partial class LearningMaterials : System.Web.UI.Page
    {
        private string connStr = WebConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;
        private List<SubTopicInfo> allSubTopics = new List<SubTopicInfo>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllSubTopics();
                BindFormLevels();
            }
        }

        private void LoadAllSubTopics()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"SELECT st.SubTopicID, st.SubTopicCode, st.SubTopicTitle, st.Content, 
                                       st.TopicID, t.TopicTitle, t.TopicCode, t.FormLevel
                                FROM SubTopics st
                                INNER JOIN Topics t ON st.TopicID = t.TopicID
                                ORDER BY t.FormLevel, t.TopicCode, st.SubTopicCode";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    allSubTopics.Add(new SubTopicInfo
                    {
                        SubTopicID = (int)reader["SubTopicID"],
                        SubTopicCode = reader["SubTopicCode"].ToString(),
                        SubTopicTitle = reader["SubTopicTitle"].ToString(),
                        Content = reader["Content"]?.ToString() ?? "Content coming soon...",
                        TopicID = (int)reader["TopicID"],
                        TopicTitle = reader["TopicTitle"].ToString(),
                        TopicCode = reader["TopicCode"].ToString(),
                        FormLevel = (int)reader["FormLevel"]
                    });
                }
            }
        }

        private void BindFormLevels()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT FormLevel FROM Topics ORDER BY FormLevel", con);
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);

                rptFormLevels.DataSource = dt;
                rptFormLevels.DataBind();
            }
        }

        protected void rptFormLevels_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int formLevel = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "FormLevel"));
                Repeater rptTopics = (Repeater)e.Item.FindControl("rptTopics");

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Topics WHERE FormLevel=@FormLevel ORDER BY TopicCode", con);
                    cmd.Parameters.AddWithValue("@FormLevel", formLevel);
                    SqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    rptTopics.DataSource = dt;
                    rptTopics.DataBind();
                }
            }
        }

        protected void rptTopics_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int topicId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "TopicID"));
                Repeater rptSubTopics = (Repeater)e.Item.FindControl("rptSubTopics");

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM SubTopics WHERE TopicID=@TopicID ORDER BY SubTopicCode", con);
                    cmd.Parameters.AddWithValue("@TopicID", topicId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    rptSubTopics.DataSource = dt;
                    rptSubTopics.DataBind();
                }
            }
        }

        protected void SubTopic_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "ViewContent")
            {
                int subTopicId = Convert.ToInt32(e.CommandArgument);
                LoadSubTopicContent(subTopicId);
            }
        }

        private void LoadSubTopicContent(int subTopicId)
        {
            LoadAllSubTopics();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"SELECT st.SubTopicID, st.SubTopicCode, st.SubTopicTitle, st.Content,
                                       t.TopicTitle, t.TopicCode, t.FormLevel
                                FROM SubTopics st
                                INNER JOIN Topics t ON st.TopicID = t.TopicID
                                WHERE st.SubTopicID = @SubTopicID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SubTopicID", subTopicId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    litSubTopicCode.Text = reader["SubTopicCode"].ToString();
                    litSubTopicTitle.Text = reader["SubTopicTitle"].ToString();
                    litTopicTitle.Text = reader["TopicTitle"].ToString();
                    litFormLevel.Text = reader["FormLevel"].ToString();

                    string content = reader["Content"]?.ToString();
                    if (string.IsNullOrEmpty(content))
                    {
                        content = @"<h3>Content Coming Soon</h3>
                                   <p>This learning material is currently being prepared. Please check back later.</p>
                                   <p>In the meantime, you can explore other topics from the sidebar.</p>";
                    }
                    litContent.Text = content;

                    pnlContent.Visible = true;
                    pnlEmpty.Visible = false;

                    hdnCurrentSubTopicID.Value = subTopicId.ToString();

                    // Setup navigation buttons
                    SetupNavigation(subTopicId);
                }
            }
        }

        private void SetupNavigation(int currentSubTopicId)
        {
            int currentIndex = allSubTopics.FindIndex(st => st.SubTopicID == currentSubTopicId);

            if (currentIndex > 0)
            {
                btnPrevious.Visible = true;
                btnPrevious.CommandArgument = allSubTopics[currentIndex - 1].SubTopicID.ToString();
            }
            else
            {
                btnPrevious.Visible = false;
            }

            if (currentIndex < allSubTopics.Count - 1)
            {
                btnNext.Visible = true;
                btnNext.CommandArgument = allSubTopics[currentIndex + 1].SubTopicID.ToString();
            }
            else
            {
                btnNext.Visible = false;
            }
        }

        protected void NavigatePrevious(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int subTopicId = Convert.ToInt32(btn.CommandArgument);
            LoadSubTopicContent(subTopicId);
        }

        protected void NavigateNext(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int subTopicId = Convert.ToInt32(btn.CommandArgument);
            LoadSubTopicContent(subTopicId);
        }

        public class SubTopicInfo
        {
            public int SubTopicID { get; set; }
            public string SubTopicCode { get; set; }
            public string SubTopicTitle { get; set; }
            public string Content { get; set; }
            public int TopicID { get; set; }
            public string TopicTitle { get; set; }
            public string TopicCode { get; set; }
            public int FormLevel { get; set; }
        }
    }
}
