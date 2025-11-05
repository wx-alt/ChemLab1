<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ChemLab1.Login" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    /* Login Page Styling */
    body {
        background: 
            linear-gradient(135deg, rgba(122,106,216,0.6), rgba(162,147,243,0.6)),
            url('assets/images/banner-item-01.jpg') no-repeat center center fixed !important;
        background-size: cover !important; /* make the image cover the whole page */
        font-family: 'Poppins', sans-serif;
        margin: 0;
        min-height: 100vh;
        padding-top: 90px; /* leave space for navbar */
    }

    .login-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: calc(100vh - 90px);
    }

    .login-card {
        background: rgba(255, 255, 255, 0.85); /* semi-transparent card */
        backdrop-filter: blur(10px); /* glass effect */
        border-radius: 25px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        padding: 40px 45px;
        width: 100%;
        max-width: 450px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .login-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 45px rgba(0, 0, 0, 0.25);
    }

    h3 {
        text-align: center;
        color: #7a6ad8;
        font-weight: 600;
        margin-bottom: 30px;
    }

    label {
        color: #444;
        font-weight: 500;
        margin-bottom: 6px;
        display: block;
        width: 100%; 
    }

    .form-control {
        border-radius: 20px;
        padding: 12px 15px;
        border: 1px solid #ddd;
        transition: all 0.3s ease;
        width: 100%;  
        max-width: 350px; 
    }

    .form-control:focus {
        border-color: #7a6ad8;
        box-shadow: 0 0 6px rgba(122, 106, 216, 0.3);
        outline: none;
    }

    .btn-login {
        background-color: #7a6ad8;
        color: #fff;
        border: none;
        border-radius: 25px;
        padding: 12px;
        font-weight: 500;
        width: 100%;
        width: 100%;
        transition: all 0.3s ease;
        display: block; 
    }

    .btn-login:hover {
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

    @media (max-width: 768px) {
        .login-card { padding: 30px 25px; }
    }
    .login-card .mb-3,
    .login-card .btn-login {
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        max-width: 320px; 
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

<div class="login-wrapper">
    <div class="login-card">
        <h3>Login to ChemLab</h3>

        <div class="mb-3">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" />
        </div>

        <div class="mb-3">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

        <p class="text-center mt-3 mb-0">
            Don’t have an account? <a href="Register.aspx">Create one here</a>
        </p>
    </div>
</div>

</asp:Content>
