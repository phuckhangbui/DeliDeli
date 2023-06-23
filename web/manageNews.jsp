<%-- 
    Document   : manageNews
    Created on : Jun 7, 2023, 3:32:15 PM
    Author     : Admin
--%>

<%@page import="User.UserDTO"%>
<%@page import="News.NewsDAO"%>
<%@page import="News.NewsDTO"%>
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
                        <a href="MainController?action=manageSuggestion">
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
                            <a href="MainController?action=manageSuggestion">
                                <img src="./assets/content-unchose.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=manageNews" class="active">
                                <img src="./assets/news.svg" alt="">
                                News
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/policies-unchose.svg" alt="">
                                                        Policies
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="#">
                                <img src="./assets/broadcast-unchose.svg" alt="">
                                Broadcast
                            </a>
                        </div>
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
                                        for (NewsDTO n : listNews) {
                                    %>
                                    <tr>
                                        <td><%= n.getId()%></td>
                                        <td  ><%= n.getTitle()%></td>
                                        <td><%= n.getCreateAt()%></td>
                                        <td><%= n.getUpdateAt()%></td>
                                        <td><%= NewsDAO.getNewsAuthorByNewsId(n.getId())%></td>
                                        <td><%= NewsDAO.getNewsCategoryByNewsId(n.getId())%></td>
                                        <td class="news-action-button">
                                            <form action="MainController" method="post" class="news-table-button">
                                                <input type="hidden" value="<%= n.getId()%>" name="newsId">
                                                <button type="submit" value="showNewsDetail" name="action">Show</button>
                                            </form>
                                        </td>
                                        <!--<td><a href="createNews.jsp?id=<%= n.getId()%>" >Edit</a></td>-->
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
