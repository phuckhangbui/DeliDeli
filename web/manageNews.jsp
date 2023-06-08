<%-- 
    Document   : manageNews
    Created on : Jun 7, 2023, 3:32:15 PM
    Author     : Admin
--%>

<%@page import="News.NewsDAO"%>
<%@page import="News.NewsDTO"%>
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
            ArrayList<NewsDTO> listNews = (ArrayList) request.getAttribute("listNews");
        %>

        <%
            if (listNews.size() > 0 && listNews != null) {
        %>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Create at</th>
                <th>Update at</th>
                <th>Owner</th>
                <th>Category</th>
                <th>Action</th>
                <th>Edit</th>
            </tr>
            <%
                for (NewsDTO n : listNews) {

            %>
            <tr>
                <td><%= n.getId()%></td>
                <td><%= n.getTitle()%></td>
                <td><%= n.getCreateAt()%></td>
                <td><%= n.getUpdateAt()%></td>
                <td><%= NewsDAO.getNewsAuthorByNewsId(n.getId())%></td>
                <td><%= NewsDAO.getNewsCategoryByNewsId(n.getId())%></td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" value="<%= n.getId()%>" name="newsId">
                        <button type="submit" value="showNewsDetail" name="action">Show</button>
                    </form>
                </td>
                <td><a href="createNews.jsp?id=<%= n.getId()%>">Edit</a></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>

        <a href="createNews.jsp">Create news</a>
    </body>
</html>
