<%-- 
    Document   : manageAccount
    Created on : Jun 4, 2023, 3:55:06 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="User.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDTO"%>
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
        <%@include file="navBarAdmin.jsp" %>

        <%
            ArrayList<UserDTO> listAcc = (ArrayList) request.getAttribute("listAcc");
            ArrayList<UserDTO> listAccSearched = (ArrayList) request.getAttribute("listAccSearched");
            int endPage = (Integer) request.getAttribute("endPage");
            String tag = (String) request.getAttribute("tag");
            if (tag.equals("")) {
                tag = "0";
            }
            String currentRole = request.getParameter("role");
            if (currentRole == null) {
                currentRole = "all";
            }
            String[] tmp = {"Deactivated", "Active"};
        %>

        <div class="container-fluid">
            <div class="row">
                <nav class="nav-left-bar col-md-2">
                    <div>
                        <a href="adminPage.html">
                            <img src="./assets/public-unchose.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="userList.html" class="active">
                            <img src="./assets/personal.png" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/post-unchose.svg" alt="">
                            Posts
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/content-unchose.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/news-unchose.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/policies-unchose.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/broadcast-unchose.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="">
                            <img src="./assets/bug-report-unchose.svg" alt="">
                            Report
                        </a>
                    </div>


                </nav>


                <div class="col-md-10 user-list">

                    <form action="MainController" method="post" style="display: flex; justify-content: center; align-items: center">
                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                        <input type="hidden" value="<%= tag%>" name="tag">
                        <input type="text" name="txtSearch">
                        <button type="submit" value="searchAccount" name="action">Search</button>
                    </form>

                    <form action="MainController?action=manageAccount" method="post">
                        <select name="role">
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                            <option value="all">All</option>
                            <input type="submit" value="Filter">
                        </select>
                    </form>

                    <!--      User List         -->
                    <%
                        int currentPage = 1;

                        String currentPageParam = request.getParameter("page");
                        if (currentPageParam != null && !currentPageParam.isEmpty()) {
                            currentPage = Integer.parseInt(currentPageParam);
                        }
                    %>

                    <%
                        if (listAccSearched != null && !listAccSearched.isEmpty()) {
                    %>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User name</th>
                                <th>Role</th>
                                <th>Email</th>
                                <th>Create at</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                for (UserDTO u : listAccSearched) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                                <td><%= u.getRole()%></td>
                                <td><%= u.getEmail()%></td>
                                <td><%= u.getCreateAt()%></td>
                                <td><%= tmp[u.getStatus()]%></td>
                                <td class="user-action-button">
                                    <form action="MainController?username=<%= u.getUserName()%>" method="post" class="activate-acc-button">
                                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                                        <input type="hidden" value="<%= tag%>" name="tag">
                                        <%
                                            if (tmp[u.getStatus()].equals("Deactivated")) {
                                        %>
                                        <button type="submit" value="activateAcc" name="action" >Activate</button>
                                        <%
                                        } else {
                                        %>
                                        <button type="submit" value="deactivateAcc" name="action">Deactivate</button>
                                        <%
                                            }
                                        %>
                                    </form>
                                    <form action="MainController?username=<%= u.getUserName()%>" method="post" class="delete-acc-button">
                                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                                        <input type="hidden" value="<%= tag%>" name="tag">
                                        <button type="submit" value="deleteAcc" name="action" >Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <div class="table-redirect">
                        <%
                            for (int i = 1; i <= endPage; i++) {
                                String pageUrl = "MainController?action=manageAccount&page=" + i + "&role=" + currentRole;
                        %>
                        <a class="<%= (currentPage == i) ? "table-redirect-active-link" : ""%>" href="<%= pageUrl%>"><%= i%></a>
                        <%
                            }
                        %>
                    </div>

                    <% } else if (listAcc != null && listAcc.size() > 0) {
                    %>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User name</th>
                                <th>Role</th>
                                <th>Email</th>
                                <th>Create at</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                for (UserDTO u : listAcc) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                                <td><%= u.getRole()%></td>
                                <td><%= u.getEmail()%></td>
                                <td><%= u.getCreateAt()%></td>
                                <td><%= tmp[u.getStatus()]%></td>
                                <td class="user-action-button">
                                    <form action="MainController?username=<%= u.getUserName()%>" method="post" class="activate-acc-button">
                                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                                        <input type="hidden" value="<%= tag%>" name="tag">
                                        <%
                                            if (tmp[u.getStatus()].equals("Deactivated")) {
                                        %>
                                        <button type="submit" value="activateAcc" name="action">Activate</button>
                                        <%
                                        } else {
                                        %>
                                        <button type="submit" value="deactivateAcc" name="action">Deactivate</button>
                                        <%
                                            }
                                        %>
                                    </form>
                                    <form action="MainController?username=<%= u.getUserName()%>" method="post" class="delete-acc-button">
                                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                                        <input type="hidden" value="<%= tag%>" name="tag">
                                        <button type="submit" value="deleteAcc" name="action">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <div class="table-redirect">
                        <%
                            for (int i = 1; i <= endPage; i++) {
                        %>
                        <a class="<%= (new Integer(tag) == i) ? "table-redirect-active-link" : ""%>" href="MainController?action=manageAccount&index=<%= i%>&role=<%= currentRole%>"><%= i%></a>
                        <%
                            }
                        %>
                        <%
                            }
                        %>
                    </div>

                </div>
            </div>
        </div>
        <script src="./script/userListScript.js"></script>
        <!--<a href="admin.jsp">Back to daskboard</a>-->
    </body>
</html>
