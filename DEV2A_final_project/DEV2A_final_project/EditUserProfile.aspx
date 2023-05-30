<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUserProfile.aspx.cs" Inherits="DEV2A_final_project.EditUserProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>

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
    <title>User Profile</title>
    <style>
    .card1 {
      width: 400px;
      padding: 30px;
      border: 2px solid #ccc;
      border-radius: 6px;
      background-color: #f8f8f8;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      text-align: center;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin-top: 10%;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label{
      display: block;
      font-weight: bold;
      font-size: 18px;
      margin-bottom: 10px;
      color:black;
    }

    input[type="text"],
    select {
      width: 100%;
      padding: 12px;
      border: 2px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    .textBox{
        width: 100%;
      padding: 12px;
      border: 2px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    select{
      appearance: none;
      -webkit-appearance: none;
      background-color: #fff;
      background-image: url("arrow_down.png");
      background-repeat: no-repeat;
      background-position: right center;
      padding-right: 25px;
    }

    .button1 {
      display: inline-block;
      padding: 12px 24px;
      background-color: #006600;
      color: #fff;
      text-decoration: none;
      border-radius: 4px;
      transition: background-color 0.3s;
      font-size: 18px;
    }

    .button1:hover {
      background-color: #45a049;
    }
      .user-icon {
      width: 70px;
      height: 70px;
      border-radius: 10%;
      margin-bottom: 5px;
      max-height:70px;
      max-width:70px
    }
    </style>
</head>
<body class ="sign-in-body">
    <form id="form1" runat="server">
        <div>
             <header class="top-bar">
  <div class="Search_container1">
    <div class="logo">
      <a href="#">321 Movies</a>
    </div>
    <div class="nav-links">
      <a href="LandingPage.aspx">Landing</a>
      <a href="UserHomePage.aspx">Home Page</a>
    </div>
  </div>
</header>
          
        </div>

        <div class="card1">
 <img class="user-icon" src="assets/img/User_Icon.png" alt="User Icon">
      <div class="form-group">
        <label for="name">Name</label>
          <asp:TextBox ID="tb_Name" CssClass="textBox" runat="server"></asp:TextBox>
      </div>

      <div class="form-group">
        <label for="surname">Surname</label>
         <asp:TextBox ID="tb_Surname" CssClass="textBox" runat="server"></asp:TextBox>
      </div>

      <div class="form-group">
        <label for="email">Email</label>
         <asp:TextBox ID="tb_Email" CssClass="textBox" runat="server"></asp:TextBox>
      </div>


        <div style="margin-top:20px;">
             <asp:Button ID="btn_Save" CssClass="button1" runat="server" Text="Save" OnClick="btn_SaveClick" />
        </div>
       <div class="validatorLabel">
			<asp:Label ID="lbl_personalInfoState" style="justify-self:center; " runat="server" Text=""/>
		</div>
  </div>
    </form>
</body>
</html>
