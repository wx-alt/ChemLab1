using System;
using System.Web.UI;
using ChemLab1.Utils;

namespace ChemLab1
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (AuthService.IsLoggedIn())
                {
                    Response.Redirect("~/Dashboard/Home.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (password.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters long.", false);
                return;
            }

            bool success = AuthService.RegisterUser(
                email: email,
                password: password,
                fullName: fullName,
                userType: "Student",
                school: null
            );


            if (success)
            {
                ShowMessage("Registration successful! Redirecting to login...", true);
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
            else
            {
                ShowMessage("Registration failed. This email address may already be in use.", false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "success-message" : "alert-message alert-danger";
            lblMessage.Visible = true;
        }
    }
}