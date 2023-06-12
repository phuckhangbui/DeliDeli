<%-- 
    Document   : showNewsDetail
    Created on : Jun 10, 2023, 11:28:20 AM
    Author     : Admin
--%>

<%@page import="User.UserDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="News.NewsDTO"%>
<%@page import="News.NewsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <!--      CSS         -->
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="stylesheet" href="./styles/adminStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>
    <body>

        <div class="container-fluid">

            <div class="row">
                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="admin.jsp">
                            <img src="./assets/public.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageAccount">
                            <img src="./assets/user-unchose.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageRecipe">
                            <img src="./assets/post-unchose.svg" alt="">
                            Posts
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/content-unchose.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageNews" class="active">
                            <img src="./assets/news-unchose.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/policies-unchose.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/broadcast-unchose.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/bug-report-unchose.svg" alt="">
                            Report
                        </a>
                    </div>


                </nav>

                <div class="col-md-10 news-detail-admin">
                    <%
                        UserDTO user = (UserDTO) session.getAttribute("user");
                        if (user == null || user.getRole() != 2) {
                            response.sendRedirect("error.jsp");
                        } else {
                    %>
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
                        }
                    %>
                    
                    <div class="container">
                        <div class="new-result">
                            <div class="container ">
                                <div class="row new-result-content new-result-content-link">
                                    <%                                        NewsDTO news = (NewsDTO) request.getAttribute("news");
                                    %>
                                    <div >
                                        <p><%= NewsDAO.getNewsCategoryByNewsId(news.getId())%></p>
                                        <p class="new-result-content-post-title"><%= news.getTitle()%></p>
                                    </div>
                                    <p>By: <%= request.getAttribute("author")%></p>
                                    <p>Create at: <%= news.getCreateAt()%></p>
                                    <img src="<%= news.getImage()%>" alt="">

                                    <p><%= news.getDesc()%></p>
                                </div>
                            </div>

                            <div class="news-detail-admin-action">
                                <form action="MainController" method="post" class="news-detail-admin-button">
                                    <input type="hidden" value="<%= news.getId()%>" name="newsId">
                                    <button><a href="updateNews.jsp?newsId=<%= news.getId()%>">Edit</a></button>
                                    <button type="submit" name="action" value="deleteNews" class="news-detail-admin-button-delete">Delete</a></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
