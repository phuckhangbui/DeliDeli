<%-- 
    Document   : showUserDetail
    Created on : Jun 5, 2023, 7:26:51 PM
    Author     : Admin
--%>

<%@page import="Recipe.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDetailDTO"%>
<%@page import="User.UserDTO"%>
<%@page import="User.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            UserDTO user = (UserDTO) request.getAttribute("user");
            UserDetailDTO userDetail = (UserDetailDTO) request.getAttribute("userDetail");
            ArrayList<RecipeDTO> userRecipe = (ArrayList) request.getAttribute("userRecipe");
        %>

        <h3>User Name: <%= user.getUserName()%></h3>
        <p>Email: <%= user.getEmail()%></p>

        <p>First Name: <%= userDetail.getFirstName()%></p>
        <p>Last Name: <%= userDetail.getLastName()%></p>
        <p>Specialty: <%= userDetail.getSpecialty()%></p>
        <p>Bio: <%= userDetail.getBio()%></p>

        <%                if (userRecipe != null && userRecipe.size() > 0) {
        %>
        <h3>User's Recipe(s)</h3>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Create at</th>
                <th>Action</th>
            </tr>
            <%
                for (RecipeDTO r : userRecipe) {
            %>
            <tr>
                <td><%= r.getId()%></td>
                <td><%= r.getTitle()%></td>
                <td><%= r.getCreate_at()%></td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" value="<%= r.getId()%>" name="id">
                        <button type="submit" value="showRecipeDetail" name="action">Show</button>
                    </form>
                </td>
            </tr>
            <% }
            %>
        </table>
        <%
            }
        %>
    </body>
</html>
