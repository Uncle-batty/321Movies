﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserHomePage.aspx.cs" Inherits="DEV2A_final_project.UserHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>321Movies</title>
  <meta content="" name="description">
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
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Day
  * Updated: Mar 10 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/day-multipurpose-html-template-for-free/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body class="Home_body" >
    <header class="top-bar">
  <div class="container">
    <div class="logo">
      <a href="#">321 Movies</a>
    </div>
    <div id="search-container">
      <input type="text" placeholder="Search...">
      <button type="submit">Search</button>
    </div>
</header>
   


 <div>
     <div class="labels">
         <asp:Label ID="Label1" runat="server">Comedy</asp:Label> 
     </div>

     <style>


.card:hover {
  transform: scale(1.1);
}

         .card-buttons {
             display: none;
             position: absolute;
             bottom: 10px;
             left: 0;
             right: 0;
             text-align: center;
         }

         .card:hover .card-buttons {
             display: block;
         }
  .card-button {
  display: inline-block;
  margin: 0 5px;
  padding: 5px 10px;
  border: 1px solid #ccc;
  background-color: #006600;
  color: #fff;
  font-size: 14px;
  text-decoration: none;
  transition: background-color 0.2s ease-in-out;
}

.card-button:hover {
  background-color: rgba(255, 255, 255, 0.8);
}
}
</style>

<div >
     <div class ="card-container" >
        
        <asp:Repeater ID="rptCards1" runat="server">
    <ItemTemplate>
        <div class ="card">
            <img class="card img" src="<%# Eval("ImageUrl") %>" />
            <h2 class ="card-title"><%# Eval("Title") %></h2>  
            <p class ="card-description"><%# Eval("Description") %></p>  
            <div class="card-buttons">
    <a href="#" class="card-button">More Info</a>
    <a href="#" class="card-button">Watch</a>
  </div>
        </div>        
    </ItemTemplate>
</asp:Repeater>        
 </div>
    
</div>
     

   

    <div class="labels">
         <asp:Label ID="Label2" runat="server">Action</asp:Label> 
     </div>
    <div class ="card-container" >
        <asp:Repeater ID="rptCards2" runat="server">
    <ItemTemplate>
        <div class ="card">
            <img class="card img" src="<%# Eval("ImageUrl") %>" />
            <h2 class ="card-title"><%# Eval("Title") %></h2>  
            <p class ="card-description"><%# Eval("Description") %></p>
            <div class="card-buttons">
    <a href="#" class="card-button">More Info</a>
    <a href="#" class="card-button">Watch</a>
  </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
    </div>
</body>
</html>
