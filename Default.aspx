<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ChemLab1._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
/* ====== Custom Styles ====== */
.section.courses .price h6 {
    font-size: 14px !important;
}

/* Learning Features boxes */
#learning-features .team-member {
    background-color: #6a4bcf;
    color: #fff;
    padding: 20px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    height: 300px;
    margin-bottom: 20px;
}

#learning-features .team-member .main-content {
    margin-top: 0;
}

#learning-features .team-member h4 {
    margin-bottom: 10px;
}

#learning-features .team-member p {
    font-size: 14px;
    line-height: 1.5;
}

/* ====== Live Quiz Section ====== */
#live-quizzes {
    margin-top: 40px;
    padding: 60px 0;
    background: linear-gradient(135deg, #6a4bcf 0%, #8b6eff 100%);
    color: #fff;
}

#live-quizzes .section-heading {
    text-align: center;
    margin-bottom: 40px;
}

#live-quizzes .section-heading h2 {
    font-size: 32px;
    font-weight: 700;
    color: #fff;
}

#live-quizzes .section-heading p {
    color: #e8e2ff;
    font-size: 15px;
}

#live-quizzes .action-box {
    background: #ecebf7;
    color: #333;
    padding: 40px 30px;
    border-radius: 18px;
    text-align: center;
    transition: transform 0.25s ease-in-out, box-shadow 0.25s;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    cursor: pointer;
}

#live-quizzes .action-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
}

#live-quizzes .action-box h4 {
    font-size: 24px;
    margin-bottom: 15px;
    font-weight: 600;
    color: #6a4bcf;
}

#live-quizzes .action-box p {
    font-size: 15px;
    margin-bottom: 35px;
    opacity: 0.9;
    color: #444;
}

#live-quizzes .form-box {
    background: #ffffff;
    color: #333;
    padding: 40px 30px;
    border-radius: 18px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    margin-top: 25px;
    margin-bottom: 20px;
    animation: fadeIn 0.4s ease;
}

#live-quizzes select,
#live-quizzes input {
    border-radius: 10px;
    border: 1px solid #ccc;
    padding: 10px 15px;
    width: 100%;
    margin-bottom: 20px;
    font-size: 15px;
    color: #333;
}

#live-quizzes .btn {
    padding: 12px 40px !important;
    border-radius: 30px !important;
    font-weight: 600;
    font-size: 1rem;
    border: none !important;
    outline: none !important;
    box-shadow: none !important;
    transition: all 0.3s ease-in-out;
    background: #6a4bcf;
    color: #fff;
}

#live-quizzes .btn:hover {
    background-color: #fff !important;
    color: #6a4bcf !important;
    border: 2px solid #6a4bcf !important;
}

#live-quizzes #roomCode {
    font-size: 20px;
    color: #6a4bcf;
    letter-spacing: 2px;
    margin-top: 10px;
    font-weight: 600;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@media (max-width: 992px) {
    #live-quizzes .action-box {
        margin-bottom: 20px;
    }
    #live-quizzes .section-heading h2 {
        font-size: 26px;
    }
}

/* ====== Quiz Section ====== */
#quiz {
    background: #ffffff;
    color: #333;
    padding: 100px 0 80px;
}

#quiz .section-heading {
    margin-bottom: 50px;
    text-align: center;
}

#quiz .section-heading h6 {
    text-transform: uppercase;
    color: #6a4bcf;
    letter-spacing: 1px;
}

#quiz .section-heading h2 {
    font-weight: 700;
    font-size: 28px;
    color: #333;
}

.quiz-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 25px;
    justify-content: center;
    margin: 0 60px;
}

.quiz-card {
    background: #ffffff;
    border-radius: 18px;
    width: 100%;
    height: 180px;
    padding: 25px 15px;
    text-align: center;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(106, 75, 207, 0.1);
    transition: transform 0.25s ease-in-out, box-shadow 0.25s;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.quiz-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.quiz-card h4 {
    color: #6a4bcf;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 16px;
}

.quiz-card p {
    color: #555;
    font-size: 14px;
    margin-bottom: 12px;
}

.quiz-card .btn {
    background: #6a4bcf;
    color: #fff;
    border: none;
    border-radius: 25px;
    padding: 6px 18px;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease-in-out;
}

.quiz-card .btn:hover {
    background: #fff;
    color: #6a4bcf;
    border: 2px solid #6a4bcf;
}

@media (max-width: 1200px) {
    .quiz-grid {
        grid-template-columns: repeat(4, 1fr);
        margin: 0 40px;
    }
}

@media (max-width: 992px) {
    .quiz-grid {
        grid-template-columns: repeat(3, 1fr);
        margin: 0 30px;
    }
}

@media (max-width: 768px) {
    .quiz-grid {
        grid-template-columns: repeat(2, 1fr);
        margin: 0 20px;
    }
}

@media (max-width: 576px) {
    .quiz-grid {
        grid-template-columns: 1fr;
        margin: 0 15px;
    }
}

/* ====== Events/Courses Section ====== */
.event_box {
    display: flex;
    flex-wrap: wrap;
    margin: -5px;
}

.event_outer {
    width: 20% !important;
    margin: 0px !important;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}

.events_item {
    display: flex;
    flex-direction: column;
    height: 250px;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.events_item:hover {
    transform: translateY(-10px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.events_item .thumb {
    position: relative !important;
    flex: 0 0 140px;
}

.events_item .thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.events_item .down-content {
    text-align: left !important;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
}

.events_item .down-content h4 {
    font-size: 12px;
    line-height: 1.2;
    margin: 5px 0;
    min-height: 40px;
    font-weight: 500 !important;
    text-align: left !important;
    padding: 0 !important;
}

.events_item .down-content .author {
    font-weight: 700 !important;
    text-align: left !important;
    margin: 0 !important;
    padding: 0 !important;
    font-size: 16px;
    color: #555;
}

.events_item .thumb .category {
    font-size: 12px !important;
    font-weight: 600 !important;
    position: absolute !important;
    top: 10px !important;
    left: 10px !important;
    background-color: rgba(106, 75, 207, 0.9) !important;
    color: #fff !important;
    padding: 5px 10px !important;
    border-radius: 5px !important;
    z-index: 2 !important;
    text-transform: uppercase !important;
}

.events_item .thumb .price h6 {
    font-size: 12px !important;
    font-weight: 500 !important;
    position: absolute !important;
    top: 10px !important;
    right: 50px !important;
    color: #fff !important;
    z-index: 2 !important;
    padding: 0 !important;
    background: none !important;
}

.container {
    padding-left: 0 !important;
    padding-right: 0 !important;
}

/* ====== Banner Section ====== */
.main-banner .owl-banner .item {
    position: relative;
    height: 650px;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
}

@media (max-width: 991px) {
    .main-banner .owl-banner .item {
        height: 350px;
    }
}

/* ====== Owl Carousel Core Styles ====== */
.owl-carousel {
    display: none;
    width: 100%;
    -webkit-tap-highlight-color: transparent;
    position: relative;
    z-index: 1;
}

.owl-carousel .owl-stage {
    position: relative;
    -ms-touch-action: pan-Y;
    touch-action: manipulation;
    -moz-backface-visibility: hidden;
}

.owl-carousel .owl-stage:after {
    content: ".";
    display: block;
    clear: both;
    visibility: hidden;
    line-height: 0;
    height: 0;
}

.owl-carousel .owl-stage-outer {
    position: relative;
    overflow: hidden;
    -webkit-transform: translate3d(0px, 0px, 0px);
}

.owl-carousel .owl-item {
    position: relative;
    min-height: 1px;
    float: left;
    -webkit-backface-visibility: hidden;
    -webkit-tap-highlight-color: transparent;
    -webkit-touch-callout: none;
}

.owl-carousel .owl-item img {
    display: block;
    width: 100%;
}

.owl-carousel .owl-nav.disabled,
.owl-carousel .owl-dots.disabled {
    display: none;
}

.owl-carousel .owl-nav .owl-prev,
.owl-carousel .owl-nav .owl-next,
.owl-carousel .owl-dot {
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.owl-carousel .owl-nav button.owl-prev,
.owl-carousel .owl-nav button.owl-next,
.owl-carousel button.owl-dot {
    background: none;
    color: inherit;
    border: none;
    padding: 0 !important;
    font: inherit;
}

.owl-carousel.owl-loaded {
    display: block;
}

.owl-carousel.owl-loading {
    opacity: 0;
    display: block;
}

.owl-carousel.owl-hidden {
    opacity: 0;
}

.owl-carousel.owl-drag .owl-item {
    -ms-touch-action: pan-y;
    touch-action: pan-y;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.owl-carousel.owl-grab {
    cursor: move;
    cursor: grab;
}

.owl-carousel .animated {
    animation-duration: 1000ms;
    animation-fill-mode: both;
}

.owl-height {
    transition: height 500ms ease-in-out;
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


    <div class="main-banner" id="top">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="owl-carousel owl-banner">
                        <!-- Slide 1 -->
                        <div class="item item-1">
                            <div class="header-text">
                                <span class="category">Interactive Learning</span>
                                <h2>Understand Chemistry Through Hands-On Exploration</h2>
                                <p>ChemLab transforms traditional chemistry learning into an interactive experience. Explore digital experiments, auto-marked quizzes, and visual modules designed to make every concept easier to grasp.</p>
                                <div class="buttons">
                                    <div class="main-button">
                                        <a href="#courses">Access Learning Modules</a>
                                    </div>
                                    <div class="icon-button">
                                        <a href="#quiz"><i class="fa fa-play"></i> Start a Quiz</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Slide 2 -->
                        <div class="item item-2">
                            <div class="header-text">
                                <span class="category">Smart Assessment</span>
                                <h2>Track Your Progress and Improve Your Skills</h2>
                                <p>With ChemLab, students can attempt topic-based quizzes, receive instant results, and monitor performance over time. Each attempt helps build a stronger foundation in chemistry.</p>
                                <div class="buttons">
                                    <div class="main-button">
                                        <a href="#live-quizzes">Join Live Quiz</a>
                                    </div>
                                    <div class="icon-button">
                                        <a href="#quiz"><i class="fa fa-flask"></i> Explore Quiz Library</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Slide 3 -->
                        <div class="item item-3">
                            <div class="header-text">
                                <span class="category">Collaborative Practice</span>
                                <h2>Join Real-Time Quiz Sessions with Your Class</h2>
                                <p>Through ChemLab's live quiz rooms, students and teachers can collaborate and compete in real-time challenges, making learning more engaging and interactive.</p>
                                <div class="buttons">
                                    <div class="main-button">
                                        <a href="#live-quizzes">Join Quiz Room</a>
                                    </div>
                                    <div class="icon-button">
                                        <a href="<%= ResolveUrl("~/Login.aspx") %>"><i class="fa fa-user"></i> Login to Start</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="section about-us" id="about-us">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-1">
                    <div class="accordion" id="accordionExample">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    How did ChemLab start?
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    ChemLab began as a university innovation project to enhance digital chemistry learning. 
                                    Many students struggled to visualize reactions and lab procedures, so we developed a platform that offers 
                                    <strong>interactive simulations</strong>, <strong>auto-marked quizzes</strong>, and <strong>digital notes</strong> 
                                    to make chemistry learning more engaging and accessible.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    How does ChemLab help students learn?
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    ChemLab helps students explore topics through <strong>step-by-step virtual experiments</strong>, 
                                    <strong>interactive practice quizzes</strong>, and <strong>visual study materials</strong>. 
                                    The system promotes self-paced learning and encourages students to build confidence in core chemistry concepts.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    Why choose ChemLab over traditional learning?
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    Traditional learning can be static, but ChemLab makes it <strong>interactive and adaptive</strong>. 
                                    Students can visualize reactions, test understanding instantly, and track their performance, 
                                    while educators can monitor class progress and customize content for better engagement.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingFour">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    What kind of support do users get?
                                </button>
                            </h2>
                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    ChemLab provides continuous platform updates, responsive <strong>technical support</strong>, 
                                    and learning resources to help users get the most out of their experience. 
                                    Both students and educators have access to our built-in help center.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5 align-self-center">
                    <div class="section-heading">
                        <h6>About Us</h6>
                        <h2>Empowering digital chemistry education with ChemLab</h2>
                        <p>ChemLab is an e-learning platform designed to make chemistry learning interactive, visual, and engaging. 
                        It combines simulations, quizzes, and real-time feedback to help students master chemistry concepts effectively.</p>
                        <div class="main-button">
                            <a href="#courses" class="scroll-link">Access Materials</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="services section" id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="service-item">
                        <div class="icon">
                            <img src="<%= ResolveUrl("~/assets/images/service-03.png") %>" alt="learning materials">
                        </div>
                        <div class="main-content">
                            <h4>Learning Materials</h4>
                            <p>Access comprehensive Chemistry notes, practical guides, and multimedia resources aligned with school curriculum.</p>
                            <div class="main-button">   
                                <a href="#courses" class="scroll-link">Explore Quizzes</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="service-item">
                        <div class="icon">
                            <img src="<%= ResolveUrl("~/assets/images/service-02.png") %>" alt="progress tracking">
                        </div>
                        <div class="main-content">
                            <h4>Progress Tracking</h4>
                            <p>The system allows students and teachers to monitor performance over time, identify weak areas, and improve learning outcomes effectively.</p>
                            <div class="main-button">
                                <a href="<%= ResolveUrl("~/Login.aspx") %>">View Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="service-item">
                        <div class="icon">
                            <img src="<%= ResolveUrl("~/assets/images/service-01.png") %>" alt="interactive quizzes">
                        </div>
                        <div class="main-content">
                            <h4>Interactive Quizzes</h4>
                            <p>Students can test their understanding of Form 4 and 5 Chemistry topics through engaging quizzes with instant feedback and performance analysis.</p>
                            <div class="main-button">
                                <a href="#quiz" class="scroll-link">Explore Quizzes</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="section courses" id="courses">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <div class="section-heading">
              <h6>Learning Modules</h6>
              <h2>Latest Chemistry Lessons</h2>
            </div>
          </div>
        </div>

        <!-- Filter Bar -->
        <ul class="event_filter text-center mb-5">
          <li><a class="is_active" href="#!" data-filter="*">Show All</a></li>
          <li><a href="#!" data-filter=".form4">Form 4 Topics</a></li>
          <li><a href="#!" data-filter=".form5">Form 5 Topics</a></li>
          <li><a href="#!" data-filter=".experiment">Experiments</a></li>
        </ul>

        <!-- Courses Grid -->
        <div class="row event_box">
          <!-- Form 4 -->
          <div class="col-lg-4 event_outer form4">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/10b981/ffffff?text=Structure+of+Atom" alt="Structure of Atom"></a>
                <span class="category">Form 4</span>
                <span class="price"><h6>Topic 1</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Chemistry Module</span>
                <h4>Structure of the Atom</h4>
              </div>
            </div>
          </div>

          <div class="col-lg-4 event_outer form4">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/3b82f6/ffffff?text=Chemical+Bonds" alt="Chemical Bonds"></a>
                <span class="category">Form 4</span>
                <span class="price"><h6>Topic 2</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Interactive Lesson</span>
                <h4>Chemical Bonds & Their Properties</h4>
              </div>
            </div>
          </div>

          <div class="col-lg-4 event_outer form4">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/f59e0b/ffffff?text=Equilibrium" alt="Chemical Equilibrium"></a>
                <span class="category">Form 4</span>
                <span class="price"><h6>Topic 5</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Chemistry Module</span>
                <h4>Chemical Equilibrium</h4>
              </div>
            </div>
          </div>

          <!-- Form 5 -->
          <div class="col-lg-4 event_outer form5">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/ef4444/ffffff?text=Redox+Reactions" alt="Redox Reactions"></a>
                <span class="category">Form 5</span>
                <span class="price"><h6>Topic 3</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Chemistry Module</span>
                <h4>Oxidation and Reduction (Redox) Reactions</h4>
              </div>
            </div>
          </div>

          <div class="col-lg-4 event_outer form5">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/6366f1/ffffff?text=Rate+of+Reaction" alt="Rate of Reaction"></a>
                <span class="category">Form 5</span>
                <span class="price"><h6>Topic 4</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Interactive Lesson</span>
                <h4>Factors Affecting Rate of Reaction</h4>
              </div>
            </div>
          </div>

          <div class="col-lg-4 event_outer form5">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/ec4899/ffffff?text=Organic+Chem" alt="Organic Chemistry"></a>
                <span class="category">Form 5</span>
                <span class="price"><h6>Topic 6</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Interactive Lesson</span>
                <h4>Introduction to Organic Chemistry</h4>
              </div>
            </div>
          </div>

          <!-- Experiments -->
          <div class="col-lg-4 event_outer experiment">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/f97316/ffffff?text=Acid+Base+Titration" alt="Acid-Base Titration"></a>
                <span class="category">Experiment</span>
                <span class="price"><h6>Lab</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Virtual Lab</span>
                <h4>Volumetric Analysis: Acid–Base Titration</h4>
              </div>
            </div>
          </div>

          <div class="col-lg-4 event_outer experiment">
            <div class="events_item">
              <div class="thumb">
                <a href="#"><img src="https://placehold.co/260x120/14b8a6/ffffff?text=Electrolysis" alt="Electrolysis Experiment"></a>
                <span class="category">Experiment</span>
                <span class="price"><h6>Lab</h6></span>
              </div>
              <div class="down-content">
                <span class="author">Virtual Lab</span>
                <h4>Electrolysis of Copper(II) Sulphate Solution</h4>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ====== Live Quiz Section ====== -->
    <div class="section exercises" id="live-quizzes">
      <div class="container">
        <div class="row text-center">
          <div class="col-lg-12">
            <div class="section-heading">
              <h6>Live Practice</h6>
              <h2>Join or Host a Live Quiz Room</h2>
              <p>Collaborate and compete in real-time chemistry quizzes. Choose to host or join a room.</p>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="row justify-content-center">
          <div class="col-lg-4 col-md-6">
            <div class="item action-box text-center">
              <h4>Host a Quiz</h4>
              <p>Start a new live session and invite others to join using a room code.</p>
              <button class="btn btn-primary" id="showCreateRoom">Create Room</button>
            </div>
          </div>

          <div class="col-lg-4 col-md-6">
            <div class="item action-box text-center">
              <h4>Join a Quiz</h4>
              <p>Already have a code? Enter it to join an existing live quiz room.</p>
              <button class="btn btn-success" id="showJoinRoom">Join Room</button>
            </div>
          </div>
        </div>

        <!-- Create Room Form -->
        <div class="row justify-content-center mt-5" id="createRoomSection" style="display: none;">
          <div class="col-lg-6">
            <div class="item form-box text-center">
              <h4>Create a New Quiz Room</h4>
              <p>Select a quiz topic below to generate a room code for others to join.</p>
              <select id="quizTopic" class="form-select mb-3">
                <option value="" disabled selected>Select Topic</option>
                <option>Atomic Structure</option>
                <option>Chemical Bonding</option>
                <option>Organic Chemistry</option>
              </select>
              <button class="btn btn-primary" id="createRoomBtn">Generate Room</button>

              <div id="roomInfo" class="mt-3" style="display:none;">
                <p><strong>Room Code:</strong> <span id="roomCode"></span></p>
                <p>Share this code with your classmates to let them join your quiz.</p>
              </div>
              <button class="btn btn-outline-light mt-3" id="backFromCreate">← Back</button>
            </div>
          </div>
        </div>

        <!-- Join Room Form -->
        <div class="row justify-content-center mt-5" id="joinRoomSection" style="display: none;">
          <div class="col-lg-6">
            <div class="item form-box text-center">
              <h4>Join a Quiz Room</h4>
              <p>Enter the 6-digit code shared by your host to join the quiz session.</p>
              <input type="text" id="joinCode" class="form-control mb-3 text-center" maxlength="6" placeholder="Enter Room Code">
              <button class="btn btn-success" id="joinRoomBtn">Join Room</button>
              <div id="joinStatus" class="mt-3"></div>
              <button class="btn btn-outline-light mt-3" id="backFromJoin">← Back</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <section id="quiz" class="quiz-section">
      <div class="container">
        <div class="section-heading text-center mb-5">
          <h6>Quiz Library</h6>
          <h2>Explore Chemistry Quizzes</h2>
        </div>

        <div class="quiz-grid">
          <div class="quiz-card">
            <h4>Atomic Structure</h4>
            <p>10 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Periodic Table</h4>
            <p>12 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Chemical Bonding</h4>
            <p>15 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Stoichiometry</h4>
            <p>8 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>States of Matter</h4>
            <p>10 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Thermochemistry</h4>
            <p>14 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Chemical Equilibrium</h4>
            <p>18 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Acids and Bases</h4>
            <p>12 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Redox Reactions</h4>
            <p>10 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Electrochemistry</h4>
            <p>16 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Kinetics</h4>
            <p>9 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Solutions</h4>
            <p>13 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Gaseous Laws</h4>
            <p>11 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Organic Chemistry Basics</h4>
            <p>20 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Hydrocarbons</h4>
            <p>14 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Polymers</h4>
            <p>9 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Biomolecules</h4>
            <p>10 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Chemical Reactions</h4>
            <p>12 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Environmental Chemistry</h4>
            <p>10 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
          <div class="quiz-card">
            <h4>Analytical Techniques</h4>
            <p>15 Questions</p>
            <button class="btn btn-primary">Start Quiz</button>
          </div>
        </div>
      </div>
    </section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>

<script>
    (function ($) {
        "use strict";

        // Scroll header background
        $(window).scroll(function () {
            var scroll = $(window).scrollTop();
            var box = $('.header-text').height();
            var header = $('header').height();

            if (scroll >= box - header) {
                $("header").addClass("background-header");
            } else {
                $("header").removeClass("background-header");
            }
        });

        // Isotope filtering for courses
        const elem = document.querySelector('.event_box');
        const filtersElem = document.querySelector('.event_filter');
        if (elem) {
            const rdn_events_list = new Isotope(elem, {
                itemSelector: '.event_outer',
                layoutMode: 'masonry'
            });
            if (filtersElem) {
                filtersElem.addEventListener('click', function (event) {
                    if (event.target.tagName !== 'A') {
                        return;
                    }
                    const filterValue = event.target.getAttribute('data-filter');
                    rdn_events_list.arrange({
                        filter: filterValue
                    });
                    filtersElem.querySelector('.is_active').classList.remove('is_active');
                    event.target.classList.add('is_active');
                    event.preventDefault();
                });
            }
        }

        // Owl Carousel for banner
        $('.owl-banner').owlCarousel({
            center: true,
            items: 1,
            loop: true,
            nav: true,
            navText: ['<i class="fa fa-angle-left" aria-hidden="true"></i>', '<i class="fa fa-angle-right" aria-hidden="true"></i>'],
            margin: 30,
            responsive: {
                992: {
                    items: 1
                },
                1200: {
                    items: 1
                }
            }
        });

        // Menu trigger
        if ($('.menu-trigger').length) {
            $(".menu-trigger").on('click', function () {
                $(this).toggleClass('active');
                $('.header-area .nav').slideToggle(200);
            });
        }

        // Smooth scroll
        $('.scroll-to-section a[href*=\\#]:not([href=\\#])').on('click', function () {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    var width = $(window).width();
                    if (width < 767) {
                        $('.menu-trigger').removeClass('active');
                        $('.header-area .nav').slideUp(200);
                    }
                    $('html,body').animate({
                        scrollTop: (target.offset().top) - 80
                    }, 700);
                    return false;
                }
            }
        });

        // Active menu on scroll
        $(document).ready(function () {
            $(document).on("scroll", onScroll);

            $('.scroll-to-section a[href^="#"]').on('click', function (e) {
                e.preventDefault();
                $(document).off("scroll");

                $('.scroll-to-section a').each(function () {
                    $(this).removeClass('active');
                })
                $(this).addClass('active');

                var target = this.hash;
                var target = $(this.hash);
                $('html, body').stop().animate({
                    scrollTop: (target.offset().top) - 79
                }, 500, 'swing', function () {
                    window.location.hash = target;
                    $(document).on("scroll", onScroll);
                });
            });
        });

        function onScroll(event) {
            var scrollPos = $(document).scrollTop();
            $('.nav a').each(function () {
                var currLink = $(this);
                var refElement = $(currLink.attr("href"));
                if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
                    $('.nav ul li a').removeClass("active");
                    currLink.addClass("active");
                }
                else {
                    currLink.removeClass("active");
                }
            });
        }

        // Dropdown menu
        const dropdownOpener = $('.main-nav ul.nav .has-sub > a');
        if (dropdownOpener.length) {
            dropdownOpener.each(function () {
                var _this = $(this);
                _this.on('tap click', function (e) {
                    var thisItemParent = _this.parent('li'),
                        thisItemParentSiblingsWithDrop = thisItemParent.siblings('.has-sub');

                    if (thisItemParent.hasClass('has-sub')) {
                        var submenu = thisItemParent.find('> ul.sub-menu');

                        if (submenu.is(':visible')) {
                            submenu.slideUp(450, 'easeInOutQuad');
                            thisItemParent.removeClass('is-open-sub');
                        } else {
                            thisItemParent.addClass('is-open-sub');

                            if (thisItemParentSiblingsWithDrop.length === 0) {
                                thisItemParent.find('.sub-menu').slideUp(400, 'easeInOutQuad', function () {
                                    submenu.slideDown(250, 'easeInOutQuad');
                                });
                            } else {
                                thisItemParent.siblings().removeClass('is-open-sub').find('.sub-menu').slideUp(250, 'easeInOutQuad', function () {
                                    submenu.slideDown(250, 'easeInOutQuad');
                                });
                            }
                        }
                    }
                    e.preventDefault();
                });
            });
        }

    })(window.jQuery);

    // Scroll to courses functionality
    document.addEventListener("DOMContentLoaded", function () {
        const btn = document.querySelector(".scroll-to-courses");
        if (!btn) return;

        btn.addEventListener("click", function (e) {
            e.preventDefault();

            const isHome = window.location.pathname.toLowerCase().includes("default.aspx") ||
                window.location.pathname === "/" ||
                window.location.pathname === "";

            if (isHome) {
                const target = document.getElementById("courses");
                if (target) {
                    const yOffset = -80;
                    const y = target.getBoundingClientRect().top + window.scrollY + yOffset;
                    window.scrollTo({ top: y, behavior: "smooth" });
                }
            } else {
                window.location.href = "Default.aspx#courses";
            }
        });
    });

    // Live Quiz Room functionality
    document.getElementById('showCreateRoom').addEventListener('click', function () {
        document.getElementById('createRoomSection').style.display = 'block';
        document.getElementById('joinRoomSection').style.display = 'none';
    });

    document.getElementById('showJoinRoom').addEventListener('click', function () {
        document.getElementById('joinRoomSection').style.display = 'block';
        document.getElementById('createRoomSection').style.display = 'none';
    });

    document.getElementById('backFromCreate').addEventListener('click', function () {
        document.getElementById('createRoomSection').style.display = 'none';
    });

    document.getElementById('backFromJoin').addEventListener('click', function () {
        document.getElementById('joinRoomSection').style.display = 'none';
    });

    document.getElementById('createRoomBtn').addEventListener('click', function () {
        const topic = document.getElementById('quizTopic').value;
        if (topic) {
            const roomCode = Math.random().toString(36).substring(2, 8).toUpperCase();
            document.getElementById('roomCode').textContent = roomCode;
            document.getElementById('roomInfo').style.display = 'block';
        } else {
            alert('Please select a topic first.');
        }
    });

    document.getElementById('joinRoomBtn').addEventListener('click', function () {
        const code = document.getElementById('joinCode').value;
        if (code.length === 6) {
            document.getElementById('joinStatus').innerHTML = '<p class="text-success">Joining room...</p>';
        } else {
            document.getElementById('joinStatus').innerHTML = '<p class="text-danger">Please enter a valid 6-digit code.</p>';
        }
    });
</script>

</asp:Content>
