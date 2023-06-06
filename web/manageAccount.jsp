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

        <form action="MainController" method="post" style="display: flex; justify-content: center; align-items: center">
            <input type="hidden" value="<%= currentRole%>" name="currentRole">
            <input type="hidden" value="<%= tag%>" name="tag">
            <input type="text" name="txtSearch">
            <button type="submit" value="searchAccount" name="action">Search</button>
        </form>

        <form action="MainController?action=manageAccount" method="post">
            <select name="role">
                <option value="user">User</option>
                <option value="admin">Admin</option>
                <option value="all">All</option>
                <input type="submit" value="Filter">
            </select>
        </form>
        <hr>

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
                for (UserDTO u : listAccSearched) {
                        
            %>
            <tr>
                <td><%= u.getId()%></td>
                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
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
            <%
                }
            %>
        </table>

        <%
            for (int i = 1; i <= endPage; i++) {
                String pageUrl = "MainController?action=manageAccount&page=" + i + "&role=" + currentRole;
        %>
        <a class="<%= (currentPage == i) ? "active" : ""%>" href="<%= pageUrl%>"><%= i%></a>
        <%
            }
        %>



        <% }else if (listAcc != null && listAcc.size() > 0) {
        %>
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
                for (UserDTO u : listAcc) {
            %>
            <tr>
                <td><%= u.getId()%></td>
                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
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
            <%
                }
            %>
        </table>
        <%
            for (int i = 1; i <= endPage; i++) {
        %>
        <a class="<%= (new Integer(tag) == i) ? "active" : ""%>" href="MainController?action=manageAccount&index=<%= i%>&role=<%= currentRole%>"><%= i%></a>
        <%
            }
        %>
        <%
            }
        %>

        <a href="admin.jsp">Back to daskboard</a>
    </body>
</html>
