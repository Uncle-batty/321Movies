<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="DEV2A_final_project.UserLogin" %>

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


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    

  <!-- =======================================================
  * Template Name: Day
  * Updated: Mar 10 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/day-multipurpose-html-template-for-free/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body class="sign-in-body">
	<!-- ======= Header ======= -->
  <header id="header" class="d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">

      <h1 class="logo"><a href="LandingPage.aspx">321 Movies</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->



    </div>
  </header><!-- End Header -->
<form runat="server">
<div class="login-wrap">
	<div class="login-html">
		<h2 class="heroForm" style="color: white; margin-bottom: 50px; justify-items:center; ">Welcome to 321 Movies</h2>
		<!-- ======= Tab Headings ======= -->
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Personal Info</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Payment info</label>

		<div class="login-form">
			<div class="sign-in-htm">
				<div class="group">
					<label for="user" class="label">First Name(s)</label>
					<asp:TextBox id="tb_Fname" runat="server" type="text" class="input" />
				</div>
				<div class="group">
					<label for="user" class="label">Last Name</label>
					<asp:TextBox id="tb_Lname" runat="server" type="text" class="input"/>
				</div>
				<div class="group">
					<label for="user" class="label">Date Of Birth</label>
					<asp:TextBox id="tb_DOB" runat="server" type="date" class="input" />
				</div>

				<div class="group">
					<label for="user" class="label">Email Address</label>
					<asp:TextBox id="tb_Email" runat="server" type="text" class="input"/>
				</div>

				<div class="group">
					<label for="pass" class="label">Password</label>
					<asp:TextBox id="tb_UserPassword" runat="server" class="input" data-type="password"/>
				</div>
				<div class="group">
					<label for="pass" class="label"> Re-Enter Password</label>
					<asp:TextBox id="tb_UserPassword2" runat="server" class="input" data-type="password"/>
				</div>
				<div class="group">
					<asp:Button id="btn_PersonalInfoSubmit" runat="server" class="button" Text="Next >" OnClick="btn_NextClick"/>
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<a href="UserSignIn.aspx">Already a member?</a>
				</div>				
			</div>
			<asp:Label ID="lbl_personalInfoState" CssClass="align-bottom" runat="server" Text="**************"/>
			<div class="sign-up-htm">
				<div class="group">
					<label for="user" class="Subscription Level"></label>
					<div class="drop-down-container">
					<asp:DropDownList runat="server" ID="dd_Pricing" class="drop-down">
						<asp:ListItem value="1" Text="Free" ></asp:ListItem> 
						<asp:ListItem value="2" Text="Standard" ></asp:ListItem>
						<asp:ListItem value="3" Text="Premium" ></asp:ListItem>
					</asp:DropDownList>
					</div>
				</div>
				<div class="group">
					<label for="pass" class="label">Card Number</label>
					<asp:TextBox id="tb_CardNumber" runat="server" type="text" class="input" />
				</div>
				<div class="group">
					<label for="pass" class="label">Expiry date</label>
					<asp:TextBox id="tb_expDate" runat="server" type="text" class="input" />
				</div>
				<div class="group">
					<label for="pass" class="label">CVV</label>
					<asp:TextBox id="tb_CVV" runat="server" type="text" class="input" />
				</div>
				<div class="group">
					<asp:Button ID="btn_CompleteLogin" runat="server" class="button" Text="Complete" OnClick="btn_NewPaymentsClick"/>
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<a href="UserLogin.aspx">Skip This step ></a>
				</div>				
			</div>
		</div>		
	</div>
</div>
	</form>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>


  
  
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
