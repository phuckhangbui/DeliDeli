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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- Account list table -->
        <%
            ArrayList<UserDTO> listAcc = (ArrayList) request.getAttribute("listAcc");
            int endPage = (Integer) request.getAttribute("endPage");
            String tag = (String) request.getAttribute("tag");
            String currentRole = request.getParameter("role");
            if(currentRole == null) {
                currentRole = "all";
            }
            String[] tmp = {"Deactivated", "Active"};
        %>

        <form action="MainController?action=manageAccount" method="post">
            <select name="role">
                <option value="user">User</option>
                <option value="admin">Admin</option>
                <option value="all">All</option>
                <input type="submit" value="Filter">
            </select>
        </form>
        <hr>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>User name</th>
                <th>Email</th>
                <th>Create at</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                if (listAcc != null && listAcc.size() > 0) {
                    for (UserDTO u : listAcc) {
            %>
            <tr>
                <td><%= u.getId()%></td>
                <td><%= u.getUserName()%></td>
                <td><%= u.getEmail()%></td>
                <td><%= u.getCreateAt()%></td>
                <td><%= tmp[u.getStatus()]%></td>
                <td>
                    <form action="MainController?username=<%= u.getUserName()%>" method="post">
                        <input type="hidden" value="<%= currentRole%>" name="currentRole">
                        <input type="hidden" value="<%= tag%>" name="tag">
                        <button type="submit" value="deactivateAcc" name="action">Deactivate</button>
                        <button type="submit" value="activateAcc" name="action">Activate</button>
                        <button type="submit" value="deleteAcc" name="action">Delete</button>
                    </form>
                </td>
            </tr>
            <% }
                }
            %>
        </table>

        <%          
            for (int i = 1; i <= endPage; i++) {
        %>
        <a class="<%= (new Integer(tag) == i) ? "active" : ""%>" href="MainController?action=manageAccount&index=<%= i%>&role=<%= currentRole %>"><%= i%></a>
        <%
            }
        %>

        <a href="admin.jsp">Back to daskboard</a>
    </body>
</html>
