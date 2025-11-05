using System;
using System.Web.UI;
using ChemLab1.Utils;

namespace ChemLab1
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && AuthService.IsLoggedIn())
            {
                Response.Redirect("~/Dashboard/Home.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Please enter both email and password.');", true);
                return;
            }

            if (AuthService.LoginUser(email, password))
            {
                Response.Redirect("~/Dashboard/Home.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Invalid email or password.');", true);
            }
        }
    }
}