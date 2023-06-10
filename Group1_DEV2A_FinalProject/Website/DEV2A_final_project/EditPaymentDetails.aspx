<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditPaymentDetails.aspx.cs" Inherits="DEV2A_final_project.editPaymentDetails" %>

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
    <title>Edit Payment Details</title>
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
      margin-top: 30px;
    }

    .form-group {
      margin-top: 20px;
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

      .dropDownList{
      width: 100%;
      padding: 12px;
      border: 2px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;

      }

    .validatorLabel{
        margin-top: 10px;
		bottom: 5%;
		justify-items: center;
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
            <label for="pass" class="label">Subscription level</label>
            <asp:DropDownList runat="server" ID="ddl_SubscriptionLevel" class="dropDownList">
						<asp:ListItem value="1" Text="Free" ></asp:ListItem> 
						<asp:ListItem value="2" Text="Standard" ></asp:ListItem>
						<asp:ListItem value="3" Text="Premium" ></asp:ListItem>
					</asp:DropDownList>
      </div>

      <div class="form-group">
        <label for="pass" class="label">Card Number</label>
					<asp:TextBox id="tb_CardNumber" runat="server" type="text" class="input" />
      </div>

      <div class="form-group">
        <label for="pass" class="label">Expiry date</label>
					<asp:TextBox id="tb_expDate" runat="server" type="text" class="input" />
      </div>

      <div class="form-group">
        <label for="pass" class="label">CVV</label>
					<asp:TextBox id="tb_CVV" runat="server" type="text" class="input" />
      </div>

      

        <div style="margin-top:30px;">
             <asp:Button ID="btn_SavePaymentDetails" CssClass="button1" runat="server" Text="Save" OnClick="btn_Save_Click" />
        </div>
            <div style="margin-top:30px;">
                <asp:Button ID="btn_cancelSubscription" CssClass="button1" runat="server" Text="Cancel Subscription" OnClick="btn_CancelSubscription" />
            </div>


       <div class="validatorLabel">
			<asp:Label ID="lbl_personalInfoState" style="justify-self:center; " runat="server" Text=""/>
		</div>
    
  </div>
    </form>
</body>
</html>
