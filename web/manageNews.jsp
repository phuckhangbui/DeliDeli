<%-- 
    Document   : manageNews
    Created on : Jun 7, 2023, 3:32:15 PM
    Author     : Admin
--%>

<%@page import="News.NewsDAO"%>
<%@page import="News.NewsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container-fluid">
            <%@include file="navBarAdmin.jsp" %>

            <div class="row">
                <nav class="nav-left-bar col-md-2">
                    <div>
                        <a href="admin.jsp">
                            <img src="./assets/public-unchose.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageAccount">
                            <img src="./assets/personal.png" alt="">
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
                    <%            ArrayList<NewsDTO> listNews = (ArrayList) request.getAttribute("listNews");
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
                                <th>Edit</th>
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
                                    <form action="MainController" method="post">
                                        <input type="hidden" value="<%= n.getId()%>" name="newsId">
                                        <button type="submit" value="showNewsDetail" name="action">Show</button>
                                    </form>
                                </td>
                                <td><a href="createNews.jsp?id=<%= n.getId()%>" >Edit</a></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <%
                        }
                    %>
                    <a href="createNews.jsp">Create news</a>
                </div>
            </div>

        </div>
    </body>
</html>
