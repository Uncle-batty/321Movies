<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="DEV2A_final_project.LandingPage" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
 
<head runat="server">
    
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>

  <title>321 Movies</title>
  <meta content="" name="description"/>
  <meta content="" name="keywords"/>

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon"/>
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon"/>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet"/>

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet"/>
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"/>
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet"/>
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet"/>

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet"/>

  <!-- =======================================================
  * Template Name: Day
  * Updated: Mar 10 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/day-multipurpose-html-template-for-free/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
<header class="top-bar">
  <div class="Search_container1">
    <div class="logo">
      <a href="#">321 Movies</a>
    </div>
    <div class="nav-links">
      <a style="color:#05ab05;text-decoration:underline" href="LandingPage.aspx">Landing</a>
      <a href="UserHomePage.aspx">Home Page</a>
    </div>
  </div>
</header>

      <h1 class="logo"><a href="index.html">321 Movies</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
    </div>
  </header><!-- End Header -->


  
  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center">
    <div class="container position-relative" data-aos="fade-up" data-aos-delay="500">
      <form id="heroForm" runat="server">
      <h1>Welcome to 321 Movies</h1>
      <h2>This is the Template for the DEV project</h2>
      <asp:Button ID="SignUp" Text ="Login"  class="btn-get-started" OnClick ="btn_UserLogin" runat="server" />
      <asp:Button ID="Login" Text ="Sign In" class="btn-get-started" OnClick ="btn_UserSignIn" runat="server" />
          </form>
    </div>
  </section><!-- End Hero -->

  

  <main id="main">

    <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container">

        <div class="row">
          <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-left">
            <img src="assets/img/about.jpg" class="img-fluid" alt="">
          </div>
          <div class="col-lg-6 pt-4 pt-lg-0 order-2 order-lg-1 content" data-aos="fade-right">
            <h3>What is 321 Movies?</h3>
            <p class="fst-italic">
              321 Movies provides people with movies that anyone can enjoy at affordable subscriptions! Our movies range from comedy to action and everything inbetween. 
                Movies such as:
            </p>
            <ul>
              <li><i class="bi bi-check-circle"></i> Award winnering hollywood bangers.</li>
              <li><i class="bi bi-check-circle"></i> Family friendly movies that the whole family can enjoy.</li>
              <li><i class="bi bi-check-circle"></i> Romance flicks to keep your heart warm during winter:)</li>
            </ul>
            <p>
                Welcome to 321 Movies! Here, you can enjoy a vast library of movies from the comfort of your own home. 
                Our website offers a user-friendly interface that allows you to easily search and browse through our collection of films by genre or year. 
                Whether you're in the mood for an action-packed blockbuster, a heartwarming romance, or a spine-chilling horror movie, we have something for everyone. 
                Plus, our website is accessible on all devices, so you can enjoy your favorite movies and TV shows on your desktop, laptop, tablet, or smartphone. So sit back, relax, and let us take you on a cinematic journey with our high-quality streaming service.
            </p>
          </div>
        </div>

      </div>
    </section><!-- End About Section -->


    <!-- ======= Clients Section ======= -->
    <section id="clients" class="clients">
      <div class="container" data-aos="zoom-in">

          <div class="row d-flex align-items-center">

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/dc-comics.png" class="img-fluid" alt=""/>
              </div>

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/universal studios.png" class="img-fluid" alt=""/>
              </div>

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/DreamWorks.png" class="img-fluid" alt=""/>
              </div>

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/lucasfilm.png" class="img-fluid" alt=""/>
              </div>

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/warner-bros.png" class="img-fluid" alt=""/>
              </div>

              <div class="col-lg-2 col-md-4 col-6">
                  <img src="assets/img/clients/Marvel.png" class="img-fluid" alt=""/>
              </div>


          </div>

      </div>
    </section><!-- End Clients Section -->

    <!-- ======= Cta Section ======= -->
    <section id="cta" class="cta">
      <div class="container" data-aos="zoom-in">
       

      </div>
    </section><!-- End Cta Section -->

    <!-- ======= Pricing Section ======= -->
    <section id="pricing" class="pricing">
      <div class="container">

        <div class="section-title">
          <span>Pricing</span>
          <h2>Pricing</h2>
          <p>Choose between our affordable subsription prices</p>
        </div>

        <div class="row">

          <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="150">
            <div class="box">
              <h3>Free</h3>
              <h4><sup>R</sup>0<span> / month</span></h4>
              <ul>
                  <li>5 movies</li>
                  <li> limted genres </li>
                  <li class="na">Access to kids movies</li>
                  <li class="na">Access to watchlist</li>

              </ul>
              <div class="btn-wrap">
                <a href="#" class="btn-buy">Buy Now</a>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mt-4 mt-md-0" data-aos="zoom-in">
            <div class="box featured">
              <h3>Standard</h3>
              <h4><sup>R</sup>99<span> / month</span></h4>
              <ul>
                <li>100 movies </li>
                <li>all different genres </li>
                <li>Includes kids movies</li>
                <li>Limted to 20 movies in watchlist</li>
              </ul>
              <div class="btn-wrap">
                <a href="#" class="btn-buy">Buy Now</a>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mt-4 mt-lg-0" data-aos="zoom-in" data-aos-delay="150">
            <div class="box">
              <h3>Standard</h3>
              <h4><sup>R</sup>199<span> / month</span></h4>
              <ul>
                  <li>Unlimited movies </li>
                  <li>All different genres </li>
                  <li>Includes kids movies</li>
                  <li>Unlimited movies in watchlist</li>
              </ul>
              <div class="btn-wrap">
                <a href="#" class="btn-buy">Buy Now</a>
              </div>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Pricing Section -->

    <!-- ======= Team Section ======= -->
    <section id="team" class="team">
      <div class="container">

        <div class="section-title">
          <span>Team</span>
          <h2>Team</h2>
          <p>Meet the team behind 321 Movies</p>
        </div>

        <div class="row">
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
            <div class="member">
              <img src="assets/img/team/team-1.jpg" alt="">
              <h4>Loius Batty</h4>
              <span>Project Leader</span>
              
              <div class="social">
                <a href=""><i class="bi bi-instagram"></i></a>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
            <div class="member">
              <img src="assets/img/team/team-2.jpg" alt="">
              <h4>Tadiwanshe Chingwe</h4>
              <span>Full-Stack Developer</span>
              <div class="social">
                <a href=""><i class="bi bi-instagram"></i></a>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
            <div class="member">
              <img src="assets/img/team/team-3.jpg" alt="">
              <h4>Jose Hyman</h4>
              <span>Full-Stack Developer</span>
              <p>
              <div class="social">
                <a href=""><i class="bi bi-instagram"></i></a>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
              <div class="member">
                <img src="assets/img/team/team-1.jpg" alt="">
                <h4>Rapudi Hlakudi</h4>
                <span>Full-Stack Developer</span>
                <div class="social">
                  <a href=""><i class="bi bi-instagram"></i></a>
                </div>
              </div>
            </div>
  
            <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
              <div class="member">
                <img src="assets/img/team/team-2.jpg" alt="">
                <h4>Ayush Bhadra</h4>
                <span>Database Designer</span>

                <div class="social">
                  <a href=""><i class="bi bi-instagram"></i></a>
                </div>
              </div>
            </div>
  
            <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="zoom-in">
              <div class="member">
                <img src="assets/img/team/team-3.jpg" alt=""/>
                <h4>Edwin Malaji</h4>
                <span>Databse Designer</span>
                <div class="social">
                  <a href=""><i class="bi bi-instagram"></i></a>
                </div>
              </div>
            </div>

        </div>

      </div>
    </section><!-- End Team Section -->

   

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-4 col-md-6">
            <div class="footer-info">
              <h3>321 Movies</h3>
              <p>
                Kingsway Avenue Auckland Park Johannesburg <br/>
                Johnannesburg, Gauteng <br/>
                South Africa <br/><br/>
                <strong>Phone:</strong> +27 65 321 0000<br/>
                <strong>Email:</strong> contact@321movies.com<br/>
              </p>
              <div class="social-links mt-3">
                <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
                <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
                <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
                <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
                <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
              </div>
            </div>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i href="#hero" class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i href="#about" class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

         

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>Our Newsletter</h4>
            <p>If you would like receive news and other noteable events</p>
            <form action="" method="post">
              <input type="email" name="email"><input type="submit" value="Subscribe">
            </form>

          </div>

        </div>
      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>321 Movies</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/day-multipurpose-html-template-for-free/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
