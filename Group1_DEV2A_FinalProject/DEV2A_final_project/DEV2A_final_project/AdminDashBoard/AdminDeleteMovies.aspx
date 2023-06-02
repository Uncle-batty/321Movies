﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDeleteMovies.aspx.cs" Inherits="DEV2A_final_project.AdminDashBoard.AdminDelete" %>

<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="cssAdmin/bootstrap.min.css" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="cssAdmin/dataTables.bootstrap5.min.css" />
    <link rel="stylesheet" href="cssAdmin/style.css" />
    <title>AdminDeleteMovie</title>
   

  </head>

  <body>
    >
      <form runat="server">
    <!-- top navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container-fluid">
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="offcanvas"
          data-bs-target="#sidebar"
          aria-controls="offcanvasExample"
        >
          <span class="navbar-toggler-icon" data-bs-target="#sidebar"></span>
        </button>
        <a
          class="navbar-brand me-auto ms-lg-0 ms-3 text-uppercase fw-bold"
          href="#"
          >321 MOVIES</a
        >
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#topNavBar"
          aria-controls="topNavBar"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="topNavBar">
          <div class="d-flex ms-auto my-3 my-lg-0">
            <div class="input-group">
              <input
                class="form-control"
                type="search"
                placeholder="Search"
                aria-label="Search"
              />
              <button class="btn btn-primary" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </div>
             
          </div>
          <%--<ul class="navbar-nav">
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle ms-2"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                <i class="bi bi-person-fill"></i>
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li>
                  <a class="dropdown-item" href="#">Something else here</a>
                </li>
              </ul>
            </li>
          </ul>--%>
        </div>
      </div>
    </nav>
    <!-- top navigation bar -->
    <!-- offcanvas -->
    <div
      class="offcanvas offcanvas-start sidebar-nav bg-dark"
      tabindex="-1"
      id="sidebar"
    >
      <div class="offcanvas-body p-0">
        <nav class="navbar-dark">
          <ul  class="navbar-nav">
             
                   <li>
                    <div class="text-muted small fw-bold text-uppercase px-3">
                      CORE
                     </div>
                    </li>
              <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>

                   <li>
                      <a href="#" class="nav-link px-3 active">
                        <span class="me-2"><i class="bi bi-speedometer2"></i></span>
                        <span>Dashboard-Delete-Movies</span>
                      </a>
                  </li>
             
                  <li class="my-4"><hr class="dropdown-divider bg-light" /></li>
              
                   <li>
                       <asp:HyperLink ID="HyperLink3" class="nav-link px-3 sidebar-link" runat="server" NavigateUrl="~/AdminDashBoard/AdminDashboard1.aspx" onclick="Users_Click">
                                <span class="me-2"><i class="bi bi-film"></i></span>
                                <span>Movies</span>
                        </asp:HyperLink>
                  </li>
              
                    <li>
                      <asp:HyperLink ID="HyperLink2" class="nav-link px-3 sidebar-link"  runat="server" NavigateUrl="~/AdminDashBoard/AdminUsers.aspx" onclick="Users_Click"  >
                        <span class="me-2"><i class="bi bi-people-fill"></i></span>
                        <span>Users</span>
                      </asp:HyperLink>

                   </li>
                   <li class="my-4"><hr class="dropdown-divider bg-light" /></li>
     
                 
         
              </ul>
        
        </nav>
      </div>
    </div>
    <!-- offcanvas -->
    <main class="mt-5 pt-3">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <h4>Dashboard  </h4>
          </div>
        </div>
        <!--cards-->
        <div class="row">
          <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white h-100">
              <div class="card-body py-5">Primary Card</div>
              <div class="card-footer d-flex">
                View Details
                <span class="ms-auto">
                  <i class="bi bi-chevron-right"></i>
                </span>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark h-100">
              <div class="card-body py-5">Warning Card</div>
              <div class="card-footer d-flex">
                View Details
                <span class="ms-auto">
                  <i class="bi bi-chevron-right"></i>
                </span>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card bg-success text-white h-100">
              <div class="card-body py-5">Success Card</div>
              <div class="card-footer d-flex">
                View Details
                <span class="ms-auto">
                  <i class="bi bi-chevron-right"></i>
                </span>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card bg-danger text-white h-100">
              <div class="card-body py-5">Danger Card</div>
              <div class="card-footer d-flex">
                View Details
                <span class="ms-auto">
                  <i class="bi bi-chevron-right"></i>
                </span>
              </div>
            </div>
          </div>
        </div>
       <!--DeleteCard -->
       <div class="container">
           <div class="card">
               
               <div class="card-body">
                   <h5 class="card-title" id="cardtitle" runat="server">Delete Movie :<asp:Label ID="movieTilte" runat="server" Text=""></asp:Label></h5>
                   <p class="card-text"><span class="ms-auto">
                 <i class="bi bi-exclamation-triangle"></i>
                </span>Warning You are about to delete movie with ID no. :<asp:Label ID="movieId" runat="server" Text=""></asp:Label></p>
                   
                   <asp:button type="button" class="btn btn-danger float-right ml-2" Text="Delete" runat="server" OnClick="btnDelete_Click"></asp:button>
                   <asp:button type="button" class="btn btn-secondary float-right" Text="Cancel" runat="server"  OnClick="btnCancel_Click"></asp:button>
               </div>
           </div>
       </div>
          </div>
    </main>

  

    <script src="./jsAdmin/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.2/dist/chart.min.js"></script>
    <script src="./js/jquery-3.5.1.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="./js/dataTables.bootstrap5.min.js"></script>
    <script src="./js/script.js"></script>

  </form>
  </body>
</html>
