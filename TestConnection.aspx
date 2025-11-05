<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string connString = ConfigurationManager.ConnectionStrings["ChemLabConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                Response.Write("✅ Database connected successfully!");
            }
        }
        catch (Exception ex)
        {
            Response.Write("❌ Error: " + ex.Message);
        }
    }
</script>