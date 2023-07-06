<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
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
                        <a href="AdminController?action=manageRecipe" class="active">
                            <img src="./assets/post-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion">
                            <img src="./assets/content-unchosen-icon.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageNews">
                            <img src="./assets/news-unchosen-icon.svg" alt="">
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
                            <a href="AdminController?action=manageRecipe" class="active">
                                <img src="./assets/post-icon.svg" alt="">
                                Recipe
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion">
                                <img src="./assets/content-unchosen-icon.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageNews">
                                <img src="./assets/news-unchosen-icon.svg" alt="">
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

                        <div class="user-header">
                            Recipe List
                        </div>

                        <%
                            ArrayList<RecipeDTO> listRecipe = (ArrayList) request.getAttribute("listRecipe");
                            ArrayList<Integer> listRecipeStatus = (ArrayList) request.getAttribute("listRecipeStatus");

                            int endPage = (Integer) request.getAttribute("endPage");
                            String tag = (String) request.getAttribute("tag");
                            if (tag.equals("")) {
                                tag = "0";
                            }
                            String currentStatus = request.getParameter("status");
                            if (currentStatus == null) {
                                currentStatus = "all";
                            }

                            String[] tmp = {"", "", "Pending...", "Approved", "Rejected"};

                            if (listRecipe != null && listRecipe.size() > 0) {
                        %>

                        <div class="nav-top-bar-search">
                            <!--                            <form action="MainController" method="post" class="nav-top-bar-search-user">
                                                            <button type="submit" name="action" value="search"><img src="assets/search2.svg" alt=""></button>
                                                            <input type="hidden" name="admin" value="admin"> 
                                                            <input type="text" name="txtsearch">
                                                            <select name="searchBy" id="">
                                                                <option value="Title" selected="selected">TITLE</option>
                                                                <option value="Category">CATEGORY</option>
                                                                <option value="Cuisine">CUISINES</option>
                                                            </select>
                                                        </form>
                            -->
                            <form action="AdminController" method="post" class="nav-top-bar-search-filter">
                                <select name="status">
                                    <option value="all">All</option>
                                    <%
                                        if (listRecipeStatus != null && listRecipeStatus.size() > 0) {
                                            for (Integer status : listRecipeStatus) {
                                                if (status != 1) {
                                    %>
                                    <option value="<%= status%>"><%= tmp[status]%></option>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                </select>
                                <button type="submit" value="manageRecipe" class="filter-table-button" name="action">Filter</button>
                            </form>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Title</th>
                                    <th>Owner</th>
                                    <th>Status</th>
                                    <th>Create at</th>
                                    <th>Update at</th>   
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    int count = 1;
                                    for (RecipeDTO r : listRecipe) {
                                %>
                                <tr>
                                    <td><%= count%></td>
                                    <td class="recipe-and-user-link">
                                        <a href="AdminController?action=showRecipeDetail&id=<%= r.getId()%>"><%= r.getTitle()%></a>
                                        
                                    </td>
                                    <% UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());%>
                                    <td class="recipe-and-user-link">
                                        <a href="AdminController?action=showUserDetail&username=<%= owner.getUserName()%>"><%= owner.getUserName()%></a>
                                    </td>
                                    <td><%= tmp[r.getStatus()]%></td>
                                    <% Timestamp timestamp = r.getCreate_at();
                                        SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                        String createDate = dateFormat.format(timestamp);
                                    %>
                                    <td><%= createDate%></td>
                                    <%
                                        if (r.getUpdate_at() == null) {
                                    %>
                                    <td><%= createDate%></td>
                                    <%
                                    } else {
                                        timestamp = r.getUpdate_at();
                                        dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                        String updateDate = dateFormat.format(timestamp);
                                    %>
                                    <td><%= updateDate%>
                                        <%
                                            }
                                        %>
                                    </td>
                                    
                                    
                                    
                                </tr>
                                <%
                                            count++;
                                        }
                                    }
                                %>
                            </tbody>
                        </table>

                        <div class="table-redirect">
                            <%
                                for (int i = 1; i <= endPage; i++) {
                            %>
                            <a class="<%= (new Integer(tag) == i) ? "table-redirect-active-link" : ""%>" href="AdminController?action=manageRecipe&index=<%= i%>&status=<%= currentStatus%>"><%= i%></a>
                            <%
                                }
                            %>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
        <script src="./script/recipeListScript.js"></script>
    </body>
</html>
