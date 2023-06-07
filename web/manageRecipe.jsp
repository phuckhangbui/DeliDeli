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
        <%
            ArrayList<RecipeDTO> listRecipeConfirmed = (ArrayList) request.getAttribute("listRecipeConfirmed");
            ArrayList<RecipeDTO> listRecipeUnConfirmed = (ArrayList) request.getAttribute("listRecipeUnConfirmed");
        %>

        <form action="MainController" method="post" style="display: flex; justify-content: center; align-items: center">
            <input type="text" name="txtSearch">
            <button type="submit" value="searchRecipe" name="action">Search</button>
        </form>
        
        <div>
            <!-- Confirmed Recipe List -->
            <div>
                <h3>Confirmed Recipe List</h3>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Create at</th>
                        <th>Owner</th>
                        <th>Action</th>
                    </tr>
                    <%                if (listRecipeConfirmed != null && listRecipeConfirmed.size() > 0) {
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
                </table>
                <p></p>
                <button onclick="loadMore()" class="btn btn-primary">Load more</button>
            </div>

            <div>
                <!-- Unconfirmed Recipe List -->
                <h3>Unconfirmed Recipe List</h3>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Create at</th>
                        <th>Owner</th>
                        <th>Action</th>
                    </tr>
                    <%                if (listRecipeUnConfirmed != null && listRecipeUnConfirmed.size() > 0) {
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
                </table>
            </div>
        </div>

        <a href="admin.jsp">Back to daskboard</a>
    </body>
</html>
