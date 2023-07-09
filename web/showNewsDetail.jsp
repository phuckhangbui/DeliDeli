<%-- 
    Document   : showNewsDetail
    Created on : Jun 10, 2023, 11:28:20 AM
    Author     : Admin
--%>

<%@page import="DTO.NewsDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
        <!--      CSS         -->
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="stylesheet" href="./styles/adminStyle.css">
        <link rel="stylesheet" href="./styles/notificationStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>
    <body>

        <div class="container-fluid">

            <div class="row">
                <%
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if (user == null || user.getRole() == 1) {
                        response.sendRedirect("error.jsp");
                    } else if (user.getRole() == 2) {
                %>

                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="AdminController?action=adminDashboard" >
                            <img src="./assets/public-unchosen-icon.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageAccount" >
                            <img src="./assets/user-unchosen-icon.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageRecipe" >
                            <img src="./assets/post-unchosen-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion" >
                            <img src="./assets/content-unchosen-icon.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageNews" class="active">
                            <img src="./assets/news-icon.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="adminBroadcast.jsp">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=logout">
                            <img src="./assets/leave-icon.svg" alt="">
                            Logout
                        </a>
                    </div>
                </nav>

                <div class="col-md-10 recipe">

                    <nav class="navbar">
                        <div class="nav-top-bar">
                            <div class="nav-top-bar-account dropdown">
                                <img src="./assets/profile-pic.svg" alt="">
                                <div>
                                    <p><%= user.getUserName()%></p>
                                    <p>Admin</p>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <%
                    } else if (user.getRole() == 3) {
                    %>
                    <nav class="nav-left-bar col-md-2">
                        <a class="logo" href="">
                            <img src="assets/Logo3.svg" alt="">
                        </a>
                        <div>
                            <a href="AdminController?action=manageAccount" >
                                <img src="./assets/user-unchosen-icon.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageRecipe" >
                                <img src="./assets/post-unchosen-icon.svg" alt="">
                                Recipe
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion" >
                                <img src="./assets/content-unchosen-icon.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageNews" class="active">
                                <img src="./assets/news-icon.svg" alt="">
                                News
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=logout">
                                <img src="./assets/leave-icon.svg" alt="">
                                Logout
                            </a>
                        </div>
                    </nav>

                    <div class="col-md-10 recipe">
                        <nav class="navbar">
                            <div class="nav-top-bar">
                                <div class="nav-top-bar-account dropdown">
                                    <img src="./assets/profile-pic.svg" alt="">
                                    <div>
                                        <p><%= user.getUserName()%></p>
                                        <p>Moderator</p>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <%
                            }
                        %>

                        <div class="blank-background">
                            <div class="container">
                                <div class="new-result">
                                    <div class="container ">
                                        <%
                                            NewsDTO news = (NewsDTO) request.getAttribute("news");
                                            String category = (String) request.getAttribute("category");
                                        %>
                                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="AdminController?action=manageNews">News List</a></li>
                                                <li class="breadcrumb-item current-link" aria-current="page"><%= news.getTitle()%></li>
                                            </ol>
                                        </nav>
                                        <div class="row">
                                            <header class="new-result-header">
                                                <p><%= news.getTitle()%></p>
                                            </header>
                                        </div>
                                        <div class="row new-result-content new-result-content-link">
                                            <div>
                                                <p class="new-result-content-post-title">By: <%= request.getAttribute("author")%></p>
                                                <%
                                                    if (news.getCreateAt().equals(news.getUpdateAt())) {
                                                %>
                                                <p>Published on: <%= news.getCreateAt()%></p>
                                                <%
                                                } else {
                                                %>
                                                <p>Updated on: <%= news.getUpdateAt()%></p>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <img src="ServletImageLoader?identifier=<%= news.getImage()%>" alt="">
                                            <p><%= news.getDesc()%></p>
                                        </div>
                                    </div>

                                    <div class="news-detail-admin-action">
                                        <form action="AdminController" method="post" class="news-detail-admin-button">
                                            <input type="hidden" value="<%= news.getId()%>" name="newsId">
                                            <button type="submit" name="action" value="loadNewsForUpdate">EDIT</button>
                                            <button type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal" class="news-detail-admin-button-delete">DELETE</button>
                                            
                                        </form>
                                    </div>
                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog ">
                                                    <div class="modal-content">
                                                        <div class="modal-header form-header">
                                                            <div class="form-title disapprove-style" id="exampleModalLabel">
                                                                Delete Confirmation
                                                            </div>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to delete this suggestion ?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I've changed my mind</button>
                                                            <button type="button" class="btn btn-danger">
                                                                <a href="AdminController?action=deleteNews&newsId=<%= news.getId()%>">
                                                                    Yes, delete it
                                                                </a>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
