<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WatchMovie.aspx.cs" Inherits="DEV2A_final_project.WatchMovie" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>321Movies</title>
  <meta content="" name="homepage for 321 movies">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/WatchMovie.css" rel="stylesheet">
</head>
<body class="Home_body">
    <header class="top-bar">
  <div class="Search_container1">
    <div class="logo">
      <a href="#">321 Movies</a>
    </div>
    <div class="nav-links">
      <a href="LandingPage.aspx">Landing</a>
      <a href="UserHomePage.aspx">Home Page</a>
    </div>
    <div class="search-bar">
      <input type="text" placeholder="Search...">
      <button type="submit">Search</button>
    </div>
    <a href="User Profile.aspx" class="profile-button">
      <img src="assets/img/User_Icon.png" alt="Profile Image">
    </a>
  </div>
</header>
    <form id="form1" runat="server">
        <div>
            <div class="vcontainer">
    <iframe runat="server" id="Moviescr" src="https://www.youtube.com/embed/Y274jZs5s7s" frameborder="0" allowfullscreen autoplay></iframe>
     </div>
            <div class="bottomContainer">
                <div class ="card">
                    <img class="card img" src="assets/Movies/movie1.jpg" />
                </div>
           
                <div class="labelContainer">
                <div class="labels">
                    <asp:Label ID="Label1" runat="server">Title</asp:Label> 
                </div>
                <asp:Label CssClass="info" ID="lbltitle" runat="server"></asp:Label>  


                <div class="labels">
                    <asp:Label ID="Label2" runat="server">Description</asp:Label> 
                </div>
                    <asp:Label CssClass="info" ID="lbldesc" runat="server"></asp:Label>

                <div class="labels">
                    <asp:Label ID="Label3" runat="server">Rating</asp:Label> 
                </div>
                    <asp:Label CssClass="info" ID="lblrating" runat="server"></asp:Label>
                    </div>
                <div class ="labelContainer">
                     <div class="labels">
                    <asp:Label ID="Label4" runat="server">Age rating</asp:Label> 
                </div>
                    <asp:Label CssClass="info" ID="lblage" runat="server"></asp:Label>

                <div class="labels">
                    <asp:Label ID="Label5" runat="server">Run Time</asp:Label> 
                </div>
                    <asp:Label CssClass="info" ID="lblruntime" runat="server"></asp:Label>
                </div>

                </div>
  

        </div>
    </form>
</body>
</html>
