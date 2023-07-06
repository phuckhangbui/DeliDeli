<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
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
                        <a href="AdminController?action=manageSuggestion" class="active">
                            <img src="./assets/content-icon.svg" alt="">
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
                            <a href="AdminController?action=manageRecipe" >
                                <img src="./assets/post-unchosen-icon.svg" alt="">
                                Recipe
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion" class="active">
                                <img src="./assets/content-icon.svg" alt="">
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

                        <%
                            String suggestion = (String) request.getAttribute("suggestion");
                            String chosenSuggestion = (String) request.getAttribute("chosenSuggestion");
                            System.out.println(chosenSuggestion);
                            String update = (String) request.getAttribute("update");
                            ArrayList<RecipeDTO> list = (ArrayList<RecipeDTO>) request.getAttribute("list");
                            ArrayList<RecipeDTO> customSuggestionList;
                            ArrayList<RecipeDTO> listRecipe = (ArrayList) request.getAttribute("listRecipe");

                            if (update == null) {
                                session.setAttribute("customSuggestionList", list);
                                customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
                            } else {
                                customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
                            }
                            if (listRecipe != null && listRecipe.size() > 0) {
                        %>

                        <!--                        <div class="nav-top-bar-search">
                                                    <form action="AdminController" method="post" class="nav-top-bar-search-user">
                                                        <button type="submit" name="action" value="search"><img src="assets/search2.svg" alt=""></button>
                                                        <input type="hidden" name="admin" value="admin"> 
                                                        <input type="text" name="txtsearch">
                                                        <select name="searchBy" id="">
                                                            <option value="Title" selected="selected">TITLE</option>
                                                            <option value="Category">CATEGORY</option>
                                                            <option value="Cuisine">CUISINES</option>
                                                        </select>
                                                    </form>
                                                </div>
                        -->


                        <div class="nav-top-bar-search">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="AdminController?action=manageSuggestion">Content List</a></li>
                                    <li class="breadcrumb-item current-link" aria-current="page">Edit Content</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="row">
                            <div class="col-md-6 table-haft-division">
                                <div class="user-header">
                                    Recipes List
                                </div>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Title</th>
                                            <th>Owner</th>
                                            <th></th>
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
                                            <td class="recipe-and-user-link"><a href="AdminController?action=showUserDetail&username=<%= owner.getUserName()%>"><%= owner.getUserName()%></a></td>

                                            <td>
                                                <form action="AdminController" method="post" class="recipe-table-button">
                                                    <input type="hidden" value="<%= r.getId()%>" name="id">
                                                    <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                                                    <input type="hidden" value="update" name="update">
                                                    <input type="hidden" value="<%= chosenSuggestion%>" name="chosenSuggestion">
                                                    <input type="hidden" value="<%= suggestion%>" name="suggestion">
                                                    <button type="submit" value="addSuggestion" name="action">Add</button>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                                    count++;
                                                }
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-6 ">
                                <%
                                    //ArrayList<RecipeDTO> customSuggestionList = (ArrayList) request.getAttribute("customSuggestionList");
                                    if (customSuggestionList != null && customSuggestionList.size() > 0) {
                                %>

                                <div class="user-header">
                                    <%= suggestion%>
                                </div>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Title</th>
                                            <th>Owner</th> 
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <%
                                            int count = 1;
                                            for (RecipeDTO r : customSuggestionList) {
                                        %>
                                        <tr>
                                            <td><%= count%></td>
                                            <td class="recipe-and-user-link">
                                                <a href="AdminController?action=showRecipeDetail&id=<%= r.getId()%>"><%= r.getTitle()%></a>
                                            </td>
                                            <% UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());%>
                                            <td><a href="AdminController?action=showUserDetail&username=<%= owner.getUserName()%>"><%= owner.getUserName()%></a></td>

                                            <td>
                                                <form action="AdminController" method="post" class="recipe-table-button">
                                                    <input type="hidden" value="<%= r.getId()%>" name="id">
                                                    <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                                                    <input type="hidden" value="update" name="update">
                                                    <input type="hidden" value="<%= chosenSuggestion%>" name="chosenSuggestion">
                                                    <input type="hidden" value="<%= suggestion%>" name="suggestion">
                                                    <button type="submit" value="removeSuggestion" name="action">Remove</button>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                                    count++;
                                                }
                                            }
                                        %>
                                    </tbody>
                                </table>
                                <form action="AdminController" method="post" class="update-suggestion">
                                    <p class="error-popup">${requestScope.error}</p>
                                    <p class="error-popup">${requestScope.titleExist}</p>
                                    <input type="hidden" name="txtUserId" value="<%= user.getId()%>">
                                    <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                                    <input type="hidden" value="<%= suggestion%>" name="suggestion">
                                    <input type="hidden" value="<%= chosenSuggestion%>" name="chosenSuggestion">
                                    <button type="submit" name="action" value="updateSuggestion">Update</button>
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
