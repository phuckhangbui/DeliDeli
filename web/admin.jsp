<%-- 
    Document   : admin
    Created on : May 23, 2023, 4:09:46 PM
    Author     : Admin
--%>

<%@page import="User.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null || user.getRole() != 2) {  
                response.sendRedirect("error.jsp");
        } else {
        %>
        <h1>Welcome ${user.getUserName()}</h1>
        <a href="MainController?action=logout" >Logout</a>
        
        <hr>
        <p><a href="MainController?action=manageAccount">Manage Account</a></p>
        <p><a href="MainController?action=manageRecipe">Manage Recipe</a></p>
        
        
        <%
            }
        %>
    </body>
</html>
