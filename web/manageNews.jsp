<%-- 
    Document   : manageNews
    Created on : Jun 7, 2023, 3:32:15 PM
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
                        <a href="#">
                            <img src="./assets/policies-unchosen-icon.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/bug-report-unchosen-icon.svg" alt="">
                            Report
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
                        <!--                        <div>
                                                    <a href="admin.jsp">
                                                        <img src="./assets/public-unchose.svg" alt="">
                                                        Dashboard
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="AdminController?action=manageAccount" >
                                <img src="./assets/user-unchosen-icon.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageRecipe" >
                                <img src="./assets/post-unchosen-icon.svg" alt="">
                                Posts
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
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/policies-unchose.svg" alt="">
                                                        Policies
                                                    </a>
                                                </div>-->
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/broadcast-unchose.svg" alt="">
                                                        Broadcast
                                                    </a>
                                                </div>-->
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/bug-report-unchose.svg" alt="">
                                                        Report
                                                    </a>
                                                </div>-->
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

                        <div class="news-table">
                            <div class="user-header">
                                News List
                            </div>
                            <div class="nav-top-bar-search">
                                <!--                                <form action="MainController" method="post" class="nav-top-bar-search-user">
                                                                    <button type="submit" name="action" value="searchAccount"><img src="assets/search2.svg" alt=""></button>
                                                                    <input type="text" name="txtSearch" placeholder="What are you searching for ?">
                                                                    <input type="hidden" value="Title" name="">
                                                                </form>-->
                                <div class="news-create-button">
                                    <button><a href="createNews.jsp">Create</a></button>
                                </div>
                            </div>

                            <%
                                ArrayList<NewsDTO> listNews = (ArrayList) request.getAttribute("listNews");
                                ArrayList<String> listNewsCategories = (ArrayList) request.getAttribute("listNewsCategories");
                                ArrayList<String> listNewsAuthors = (ArrayList) request.getAttribute("listNewsAuthors");
                                if (listNews.size() > 0 && listNews != null) {
                            %>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Title</th>
                                        <th>Created</th>
                                        <th>Updated</th>
                                        <th>Owner</th>
                                        <th>Category</th>
                                        <th></th>
                                        <!--<th>Edit</th>-->
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <%
                                        for (int i = 0; i < listNews.size(); i++) {
                                            NewsDTO news = listNews.get(i);
                                            String newsCategory = listNewsCategories.get(i);
                                            String newsAuthor = listNewsAuthors.get(i);
                                    %>
                                    <tr>
                                        <td><%= news.getId()%></td>
                                        <td  ><%= news.getTitle()%></td>
                                        <td><%= news.getCreateAt()%></td>
                                        <td><%= news.getUpdateAt()%></td>
                                        <td><%= newsAuthor%></td>
                                        <td><%= newsCategory%></td>
                                        <td class="news-action-button">
                                            <form action="AdminController" method="post" class="news-table-button">
                                                <input type="hidden" value="<%= news.getId()%>" name="newsId">
                                                <button type="submit" value="showNewsDetail" name="action">Show</button>
                                            </form>
                                        </td>
                                        <!--<td><a href="createNews.jsp?id=<%= news.getId()%>" >Edit</a></td>-->
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                            <%
                                }
                            %>


                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
