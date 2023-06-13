<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

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
                        <a href="MainController?action=manageRecipe" class="active">
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



                <div class="col-md-10 recipe">
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

                    <%
                        ArrayList<RecipeDTO> listSearch = (ArrayList) request.getAttribute("searchRecipesList");
                        if (listSearch != null && listSearch.size() > 0) {
                    %>

                    <div class="container">
                        <div class="row recipe-table">
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
                            <h3 class="recipe-table-title">Recipe List</h3>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Create at</th>
                                        <th>Owner</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <%
                                        for (RecipeDTO r : listSearch) {
                                    %>
                                    <tr>
                                        <td><%= r.getId()%></td>
                                        <td><%= r.getTitle()%></td>
                                        <td><%= r.getCreate_at()%></td>
                                        <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                                        <td>
                                            <form action="MainController" method="post" class="recipe-table-button">
                                                <input type="hidden" value="<%= r.getId()%>" name="id">
                                                <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%
                    ArrayList<RecipeDTO> listRecipeConfirmed = (ArrayList) request.getAttribute("listRecipeConfirmed");
                    ArrayList<RecipeDTO> listRecipeUnConfirmed = (ArrayList) request.getAttribute("listRecipeUnConfirmed");
                %>

                <div class="col-md-10 recipe">
                    <div class="container">
                        <div class="row recipe-table">

                            <%
                                if (listRecipeConfirmed != null && listRecipeUnConfirmed != null) {
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
                            <%
                                }
                            %>

                            <!-- Confirmed Recipe List -->
                            <div class="col-md-6">
                                <%                if (listRecipeConfirmed != null && listRecipeConfirmed.size() > 0) {
                                %>
                                <h3 class="recipe-table-title">Approved Recipe List</h3>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Create at</th>
                                            <th>Owner</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <%
                                            for (RecipeDTO r : listRecipeConfirmed) {
                                        %>
                                        <tr>
                                            <td><%= r.getId()%></td>
                                            <td><%= r.getTitle()%></td>
                                            <td><%= r.getCreate_at()%></td>
                                            <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                                            <td>
                                                <form action="MainController" method="post" class="recipe-table-button">
                                                    <input type="hidden" value="<%= r.getId()%>" name="id">
                                                    <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                                    <!-- <button type="submit" value="deleteRecipe" name="action">Delete</button> -->
                                                </form>
                                            </td>
                                        </tr>
                                        <% }
                                            }
                                        %>
                                    </tbody>
                                </table>
                                <!--<button onclick="loadMore()" class="btn btn-primary">Load more</button>-->
                            </div>

                            <div class="col-md-6">
                                <!-- Unconfirmed Recipe List -->
                                <%                if (listRecipeUnConfirmed != null && listRecipeUnConfirmed.size() > 0) {
                                %>
                                <h3 class="recipe-table-title">Pending Recipe List</h3>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Create at</th>
                                            <th>Owner</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <%
                                            for (RecipeDTO r : listRecipeUnConfirmed) {
                                        %>
                                        <tr>
                                            <td><%= r.getId()%></td>
                                            <td><%= r.getTitle()%></td>
                                            <td><%= r.getCreate_at()%></td>
                                            <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                                            <td>
                                                <form action="MainController" method="post" class="recipe-table-button">
                                                    <input type="hidden" value="<%= r.getId()%>" name="id">
                                                    <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                                    <!-- <button type="submit" value="confirmRecipe" name="action">Confirm</button> -->
                                                </form>
                                            </td>
                                        </tr>
                                        <% }
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- <a href="admin.jsp">Back to daskboard</a> -->
            </div>
        </div>
    </div>

</body>
</html>
