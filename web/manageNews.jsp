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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
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

                <div class="col-md-10 news">
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
                        <div class="row news-table">
                            <%                                ArrayList<NewsDTO> listNews = (ArrayList) request.getAttribute("listNews");
                                if (listNews.size() > 0 && listNews != null) {
                            %>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Create at</th>
                                        <th>Update at</th>
                                        <th>Owner</th>
                                        <th>Category</th>
                                        <th>Action</th>
                                        <!--<th>Edit</th>-->
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <%
                                        for (NewsDTO n : listNews) {
                                    %>
                                    <tr>
                                        <td><%= n.getId()%></td>
                                        <td><%= n.getTitle()%></td>
                                        <td><%= n.getCreateAt()%></td>
                                        <td><%= n.getUpdateAt()%></td>
                                        <td><%= NewsDAO.getNewsAuthorByNewsId(n.getId())%></td>
                                        <td><%= NewsDAO.getNewsCategoryByNewsId(n.getId())%></td>
                                        <td>
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

                            <div class="news-create-button">
                                <button><a href="createNews.jsp">Create</a></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
