<%-- 
    Document   : manageAccount
    Created on : Jun 4, 2023, 3:55:06 PM
    Author     : Admin
--%>

<%@page import="Admin.AdminDAO"%>
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

        <div class="container-fluid">


            <%                ArrayList<UserDTO> listAcc = (ArrayList) request.getAttribute("listAcc");
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

            <div class="row">
                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="admin.jsp">
                            <img src="./assets/public-unchose.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageAccount" class="active">
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
                        <a href="MainController?action=manageNews">
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


                <div class="col-md-10 user-list">
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
                    <div class="user-header">
                        Users List
                    </div>
                    <div class="nav-top-bar-search">
                        <form action="MainController" method="post" class="nav-top-bar-search-user">
                            <button type="submit" name="action" value="searchAccount"><img src="assets/search2.svg" alt=""></button>
                            <input type="text" name="txtSearch" placeholder="Who are you searching for ?">
                            <input type="hidden" value="<%= currentRole%>" name="currentRole">
                            <input type="hidden" value="<%= tag%>" name="tag">
                        </form>
                        <form action="MainController?action=manageAccount" method="post" class="nav-top-bar-search-filter">
                            <select name="role">
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                                <option value="all">All</option>
                            </select>
                            <button type="submit" value="Filter" class="filter-table-button">Filter</button>
                        </form>
                    </div>

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
                                <th>No.</th>
                                <th>User name</th>
                                <th>Role</th>
                                <th>Email</th>
                                <th>Created</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                for (UserDTO u : listAccSearched) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                                <td><%= AdminDAO.getRoleByRoleId(u.getRole())%></td>
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
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#userListModal">Delete</button>
                                        <div class="modal fade" id="userListModal" tabindex="-1" aria-labelledby="userListModalLabel" aria-hidden="true">
                                            <div class="popup-confirm">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="exampleModalLabel">CONFIRMATION</h1>
                                                        </div>
                                                        <div class="modal-body">
                                                            Pressing delete will remove this user from this site forever, are you sure you still want to delete them ?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I changed my mind</button>
                                                            <button type="button" class="btn popup-confirm-btn">Yes, delete them</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
                                <th>No.</th>
                                <th>User name</th>
                                <th>Role</th>
                                <th>Email</th>
                                <th>Created</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                for (UserDTO u : listAcc) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                                <td><%= AdminDAO.getRoleByRoleId(u.getRole()) %></td>
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
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#userListModal">Delete</button>
                                        <div class="modal fade" id="userListModal" tabindex="-1" aria-labelledby="userListModalLabel" aria-hidden="true">
                                            <div class="popup-confirm">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="exampleModalLabel">CONFIRMATION</h1>
                                                        </div>
                                                        <div class="modal-body">
                                                            Pressing delete will remove this user from this site forever, are you sure you still want to delete them ?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I changed my mind</button>
                                                            <button type="button" class="btn popup-confirm-btn">Yes, delete them</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
