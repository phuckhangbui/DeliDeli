<%-- 
    Document   : createNews
    Created on : Jun 7, 2023, 3:51:24 PM
    Author     : Admin
--%>

<%@page import="User.UserDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="News.NewsDAO"%>
<%@page import="News.NewsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
        %>

        <form action="MainController" method="post">
            <p>Title: <input type="text" name="txtTitle"></p>
            <p>Category:
                <select name="category">
                    <%
                        HashMap<Integer, String> newsMap = Utils.NavigationBarUtils.getMap("NewsCategory");
                        for (Map.Entry<Integer, String> entry : newsMap.entrySet()) {
                    %>
                    <option value="<%= entry.getKey()%>"><%= entry.getValue()%></option>
                    <%
                        }
                    %>
                </select>
            </p>
            <p>Image: <input type="file" name="file"></p>
            <p>Description: <textarea rows="10" cols="10" id="editor"></textarea></p>
            <input type="hidden" name="editorContent" id="editorContent" value="">
            <input type="hidden" name="userId" value="<%= user.getId()%>">
            <button type="submit" value="createNews" name="action">Submit</button>
        </form>

        <script>
            CKEDITOR.replace('editor');
        </script>

        <script>
            document.querySelector('form').addEventListener('submit', function (event) {
                // Get the CKEditor content
                var editorContent = CKEDITOR.instances.editor.getData();

                // Assign the content to a hidden input field
                document.getElementById('editorContent').value = editorContent;
            });
        </script>
    </body>
</html>
