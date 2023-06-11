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
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
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

                <div class="col-md-10 news">
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
                    
                    <div class="container">
                        <div class="row news-content">
                            <%                                
                                //UserDTO user = (UserDTO) session.getAttribute("user");
                                String id = request.getParameter("newsId");

                                try {
                                    NewsDTO news = NewsDAO.getNewsByNewsId(new Integer(id));
                                    //if (news.getUser_id() == user.getId()) {
                            %>
                            <form action="MainController" method="post" class="news-create-button" enctype="multipart/form-data">
                                <div class="news-content-info">
                                    <p>Title: <input type="text" name="txtTitle" value="<%= news.getTitle()%>"></p>
                                </div>
                                <div class="news-content-info">
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
                                </div>
                                <div class="news-content-info news-content-info-white-background">
                                    <!--<p>Image: <input type="file" name="file"></p>-->
                                </div>
                                <div class="news-content-info">
                                    <p>Description: <textarea rows="10" cols="10" id="editor" value="<%= news.getDesc()%>"></textarea></p>
                                </div>
                                <input type="hidden" name="editorContent" id="editorContent" value="">
                                <input type="hidden" name="newsId" value="<%= id%>">
                                <button type="submit" value="updateNews" name="action">Update</button>
                                <!--<button type="submit" value="deleteNews" name="action">Delete</button>-->
                            </form>
                            <%//}
                                } catch (Exception e) {

                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>


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
