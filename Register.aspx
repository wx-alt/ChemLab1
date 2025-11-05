<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ChemLab1.Register" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body {
        background: 
            linear-gradient(135deg, rgba(122,106,216,0.6), rgba(162,147,243,0.6)),
            url('assets/images/banner-item-01.jpg') no-repeat center center fixed !important;
        background-size: cover !important;
        font-family: 'Poppins', sans-serif;
        margin: 0;
        min-height: 100vh;
        padding-top: 90px;
    }

    .register-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: calc(100vh - 90px);
        padding: 50px 15px;
    }

    .register-card {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 25px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.25);
        padding: 40px 45px;
        width: 100%;
        max-width: 450px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .register-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 45px rgba(0, 0, 0, 0.35);
    }

    h3 {
        text-align: center;
        color: #7a6ad8;
        font-weight: 600;
        margin-bottom: 30px;
    }

    .register-card .mb-3 {
        width: 100%;
        max-width: 350px;
        text-align: left;
        margin-bottom: 20px;
    }

    .register-card label {
        color: #444;
        font-weight: 500;
        margin-bottom: 6px;
        display: block;
        width: 100%;
    }

    .register-card .form-control {
        width: 100% !important;
        max-width: 400px !important;
        border-radius: 20px;
        padding: 12px 15px;
        border: 1px solid #ddd;
        transition: all 0.3s ease;
        box-sizing: border-box;
        display: block;
        margin: 0 auto; /* keeps boxes centered */
    }


    .register-card .form-control:focus {
        border-color: #7a6ad8;
        box-shadow: 0 0 6px rgba(122, 106, 216, 0.3);
        outline: none;
    }

    .register-card .btn-register {
        background-color: #7a6ad8;
        color: #fff;
        border: none;
        border-radius: 25px;
        padding: 12px;
        font-weight: 500;
        width: 100%;
        max-width: 350px;
        transition: all 0.3s ease;
        display: block;
        margin: 15px auto 0 auto;
    }

    .register-card .btn-register:hover {
        background-color: #5c4fc9;
        transform: scale(1.03);
    }

    .text-center a {
        color: #7a6ad8;
        text-decoration: none;
        font-weight: 500;
    }

    .text-center a:hover {
        text-decoration: underline;
    }

    .error-message {
        color: #dc3545;
        font-size: 13px;
        margin-top: 5px;
        display: block;
    }

    .success-message {
        color: #28a745;
        font-size: 14px;
        text-align: center;
        padding: 12px;
        background: rgba(40, 167, 69, 0.1);
        border-radius: 10px;
        margin-bottom: 15px;
        max-width: 350px;
    }

    .alert-message {
        font-size: 14px;
        text-align: center;
        padding: 12px;
        border-radius: 10px;
        margin-bottom: 15px;
        max-width: 350px;
    }

    .alert-danger {
        color: #dc3545;
        background: rgba(220, 53, 69, 0.1);
    }

    @media (max-width: 768px) {
        .register-card { 
            padding: 30px 25px; 
        }
        .register-card .mb-3,
        .register-card .btn-register {
            max-width: 100%;
        }
    }
</style>

        <header class="header-area header-sticky background-header">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav class="main-nav">
                            <a href="Default.aspx" class="logo">
                                <h1>ChemLab</h1>
                            </a>
                            <ul class="nav">
                                <li><a href="Default.aspx">Home</a></li>
                                <li><a href="Default.aspx#about-us">About Us</a></li>
                                <li><a href="Default.aspx#courses">Modules</a></li>
                                <li><a href="Default.aspx#live-quizzes">Join a Quiz</a></li>
                                <li><a href="Default.aspx#quiz">Quiz Library</a></li>
                                <li><a href="Login.aspx">Login</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </header>

<div class="register-wrapper">
    <div class="register-card">
        <h3>Create Your Account</h3>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert-message" Visible="false"></asp:Label>

        <div class="mb-3">
            <label>Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                ControlToValidate="txtFullName" 
                ErrorMessage="Full name is required" 
                CssClass="error-message" 
                Display="Dynamic" />
        </div>

        <div class="mb-3">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                ControlToValidate="txtEmail" 
                ErrorMessage="Email is required" 
                CssClass="error-message" 
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                ControlToValidate="txtEmail"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ErrorMessage="Please enter a valid email address" 
                CssClass="error-message" 
                Display="Dynamic" />
        </div>

        <div class="mb-3">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password (min 6 characters)" />
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                ControlToValidate="txtPassword" 
                ErrorMessage="Password is required" 
                CssClass="error-message" 
                Display="Dynamic" />
        </div>

        <div class="mb-3">
            <label>Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm your password" />
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                ControlToValidate="txtConfirmPassword" 
                ErrorMessage="Please confirm your password" 
                CssClass="error-message" 
                Display="Dynamic" />
            <asp:CompareValidator ID="cvPassword" runat="server" 
                ControlToValidate="txtConfirmPassword" 
                ControlToCompare="txtPassword" 
                ErrorMessage="Passwords do not match" 
                CssClass="error-message" 
                Display="Dynamic" />
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register" OnClick="btnRegister_Click" />

        <p class="text-center mt-3 mb-0">
            Already have an account? <a href="Login.aspx">Login here</a>
        </p>
    </div>
</div>

</asp:Content>