<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

<%@page import="Suggestion.SuggestionDAO"%>
<%@page import="User.UserDTO"%>
<%@page import="Recipe.RecipeDAO"%>
<%@page import="Recipe.RecipeDTO"%>
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
                        <a href="MainController?action=manageSuggestion" class="active">
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
                            <a href="MainController?action=manageSuggestion" class="active">
                                <img src="./assets/content-unchose.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=manageNews">
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

                        <%
                            String suggestion = request.getParameter("suggestion");
                            String update = request.getParameter("update");
                            ArrayList<RecipeDTO> list = SuggestionDAO.getAllRecipesBySuggestion(suggestion);
                            ArrayList<RecipeDTO> customSuggestionList;

                            if (update == null) {
                                session.setAttribute("customSuggestionList", list);
                                customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
                            } else {
                                customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
                            }
                            //
                            ArrayList<RecipeDTO> listRecipe = (ArrayList) RecipeDAO.getAllRecipes();
                            if (listRecipe != null && listRecipe.size() > 0) {
                        %>

                        <div class="nav-top-bar-search">
                            <form action="MainController" method="post" class="nav-top-bar-search-user">
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
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Title</th>
                                    <th>Create at</th>
                                    <th>Owner</th>
                                    <th>Show</th>
                                    <th>Add</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    int count = 1;
                                    for (RecipeDTO r : listRecipe) {
                                %>
                                <tr>
                                    <td><%= count%></td>
                                    <td><%= r.getTitle()%></td>
                                    <td><%= r.getCreate_at()%></td>
                                    <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                                    <td>
                                        <form action="MainController" method="post" class="recipe-table-button">
                                            <input type="hidden" value="<%= r.getId()%>" name="id">
                                            <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="MainController" method="post" class="recipe-table-button">
                                            <input type="hidden" value="<%= r.getId()%>" name="id">
                                            <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                                            <input type="hidden" value="update" name="update">
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

                        <%
                            //ArrayList<RecipeDTO> customSuggestionList = (ArrayList) request.getAttribute("customSuggestionList");
                            if (customSuggestionList != null && customSuggestionList.size() > 0) {
                        %>
                        <h3><%= suggestion%></h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Title</th>
                                    <th>Create at</th>
                                    <th>Owner</th>
                                    <th>Show</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    int count = 1;
                                    for (RecipeDTO r : customSuggestionList) {
                                %>
                                <tr>
                                    <td><%= count%></td>
                                    <td><%= r.getTitle()%></td>
                                    <td><%= r.getCreate_at()%></td>
                                    <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                                    <td>
                                        <form action="MainController" method="post" class="recipe-table-button">
                                            <input type="hidden" value="<%= r.getId()%>" name="id">
                                            <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="MainController" method="post" class="recipe-table-button">
                                            <input type="hidden" value="<%= r.getId()%>" name="id">
                                            <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                                            <input type="hidden" value="update" name="update">
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

                        <form action="MainController" method="post">
                            <input type="hidden" name="txtUserId" value="<%= user.getId()%>">
                            <input type="hidden" value="<%= customSuggestionList%>" name="customSuggestionList">
                            <input type="hidden" value="<%= suggestion%>" name="suggestion">
                            <button type="submit" name="action" value="updateSuggestion">Update</button>
                            <p class="error-popup">${requestScope.error}</p>
                            <p class="error-popup">${requestScope.titleExist}</p>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
