<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ChemLab1.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    /* Contact Page Specific Styles */
    .contact-page-content {
        min-height: calc(100vh - 200px);
        padding-top: 140px;
        padding-bottom: 80px;
        background: linear-gradient(135deg, #f1f0fe 0%, #ffffff 100%);
    }

    .contact-page-content .content-wrapper {
        background: #fff;
        border-radius: 25px;
        padding: 60px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
        max-width: 900px;
        margin: 0 auto;
    }

    .contact-page-content h2 {
        font-size: 36px;
        font-weight: 700;
        color: #7a6ad8;
        margin-bottom: 20px;
    }

    .contact-page-content h3 {
        font-size: 24px;
        font-weight: 600;
        color: #1e1e1e;
        margin-bottom: 15px;
        margin-top: 30px;
    }

    .contact-page-content p {
        font-size: 16px;
        line-height: 1.8;
        color: #4a4a4a;
        margin-bottom: 15px;
    }

    .contact-page-content address {
        font-style: normal;
        font-size: 16px;
        line-height: 1.8;
        color: #4a4a4a;
        margin-bottom: 20px;
    }

    .contact-page-content abbr {
        text-decoration: none;
        border-bottom: none;
    }

    .contact-page-content a {
        color: #7a6ad8;
        text-decoration: none;
        transition: all 0.3s;
    }

    .contact-page-content a:hover {
        color: #5c4fc9;
        text-decoration: underline;
    }

    .contact-page-content strong {
        color: #1e1e1e;
        font-weight: 600;
    }

    @media (max-width: 768px) {
        .contact-page-content .content-wrapper {
            padding: 40px 30px;
        }

        .contact-page-content h2 {
            font-size: 28px;
        }
    }
</style>

<main aria-labelledby="title" class="contact-page-content">
    <div class="container">
        <div class="content-wrapper">
            <h2 id="title">Contact Us</h2>
            <h3>Get in Touch</h3>
            <p>
                Have questions about ChemLab? We're here to help! Reach out to us through any of the 
                channels below and our team will get back to you as soon as possible.
            </p>
            
            <h3>Our Office</h3>
            <address>
                One Microsoft Way<br />
                Redmond, WA 98052-6399<br />
                <abbr title="Phone">P:</abbr>
                425.555.0100
            </address>

            <h3>Support & Inquiries</h3>
            <address>
                <strong>Technical Support:</strong> <a href="mailto:Support@example.com">Support@example.com</a><br />
                <strong>General Inquiries:</strong> <a href="mailto:Marketing@example.com">Marketing@example.com</a>
            </address>

            <p>
                We typically respond to all inquiries within 24-48 hours during business days. 
                For urgent technical issues, please include "URGENT" in your email subject line.
            </p>
        </div>
    </div>
</main>

</asp:Content>
