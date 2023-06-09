<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

<%@page import="Recipe.RecipeDAO"%>
<%@page import="Recipe.RecipeDTO"%>
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

                <div class="col-md-10 recipe">
                    <form action="MainController" method="post">
                        <input type="hidden" name="admin" value="admin"> 
                        <input type="text" name="txtsearch">
                        <select name="searchBy" id="">
                            <option value="Title" selected="selected">TITLE</option>
                            <option value="Category">CATEGORY</option>
                            <option value="Cuisine">CUISINES</option>
                        </select>
                        <input type="submit" name="action" value="search">
                    </form>

                    <%            ArrayList<RecipeDTO> listSearch = (ArrayList) request.getAttribute("searchRecipesList");
                        if (listSearch != null && listSearch.size() > 0) {
                    %>
                    <table border="1">
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Create at</th>
                            <th>Owner</th>
                            <th>Action</th>
                        </tr>
                        <%
                            for (RecipeDTO r : listSearch) {
                        %>
                        <tr>
                            <td><%= r.getId()%></td>
                            <td><%= r.getTitle()%></td>
                            <td><%= r.getCreate_at()%></td>
                            <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
                            <td>
                                <form action="MainController" method="post">
                                    <input type="hidden" value="<%= r.getId()%>" name="id">
                                    <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                </form>
                            </td>
                        </tr>
                        <% }
                            }
                        %>
                    </table>


                    <%
                        ArrayList<RecipeDTO> listRecipeConfirmed = (ArrayList) request.getAttribute("listRecipeConfirmed");
                        ArrayList<RecipeDTO> listRecipeUnConfirmed = (ArrayList) request.getAttribute("listRecipeUnConfirmed");
                    %>


                    <div>
                        <!-- Confirmed Recipe List -->
                        <div>
                            <%                if (listRecipeConfirmed != null && listRecipeConfirmed.size() > 0) {
                            %>
                            <h3>Confirmed Recipe List</h3>
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
                                            <form action="MainController" method="post">
                                                <input type="hidden" value="<%= r.getId()%>" name="id">
                                                <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                                <button type="submit" value="deleteRecipe" name="action">Delete</button>
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

                        <div>
                            <!-- Unconfirmed Recipe List -->
                            <%                if (listRecipeUnConfirmed != null && listRecipeUnConfirmed.size() > 0) {
                            %>
                            <h3>Unconfirmed Recipe List</h3>
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
                                            <form action="MainController" method="post">
                                                <input type="hidden" value="<%= r.getId()%>" name="id">
                                                <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                                <button type="submit" value="confirmRecipe" name="action">Confirm</button>
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
                    <a href="admin.jsp">Back to daskboard</a>
                </div>
            </div>
        </div>

    </body>
</html>
