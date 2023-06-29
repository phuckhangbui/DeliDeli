<%-- 
    Document   : createNews
    Created on : Jun 7, 2023, 3:51:24 PM
    Author     : Admin
--%>

<%@page import="DTO.NewsDTO"%>
<%@page import="DAO.NewsDAO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
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
                <%
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if (user == null || user.getRole() == 1) {
                        response.sendRedirect("error.jsp");
                    } else if (user.getRole() == 2) {
                %>

                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="admin.jsp" >
                            <img src="./assets/public-unchosen-icon.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageAccount" >
                            <img src="./assets/user-unchosen-icon.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageRecipe" >
                            <img src="./assets/post-unchosen-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion" >
                            <img src="./assets/content-unchosen-icon.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageNews" class="active">
                            <img src="./assets/news-icon.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/policies-unchosen-icon.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/bug-report-unchosen-icon.svg" alt="">
                            Report
                        </a>
                    </div>
                </nav>

                <div class="col-md-10 recipe">

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
                    } else if (user.getRole() == 3) {
                    %>
                    <nav class="nav-left-bar col-md-2">
                        <a class="logo" href="">
                            <img src="assets/Logo3.svg" alt="">
                        </a>
                        <!--                        <div>
                                                    <a href="admin.jsp">
                                                        <img src="./assets/public-unchose.svg" alt="">
                                                        Dashboard
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="AdminController?action=manageAccount">
                                <img src="./assets/user-unchose.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageRecipe">
                                <img src="./assets/post-unchose.svg" alt="">
                                Posts
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion">
                                <img src="./assets/content-unchose.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageNews" class="active">
                                <img src="./assets/news.svg" alt="">
                                News
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/policies-unchose.svg" alt="">
                                                        Policies
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="#">
                                <img src="./assets/broadcast-unchose.svg" alt="">
                                Broadcast
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/bug-report-unchose.svg" alt="">
                                                        Report
                                                    </a>
                                                </div>-->
                    </nav>

                    <div class="col-md-10 recipe">
                        <nav class="navbar">
                            <div class="nav-top-bar">
                                <div class="nav-top-bar-account dropdown">
                                    <img src="./assets/profile-pic.svg" alt="">
                                    <div>
                                        <p><%= user.getUserName()%></p>
                                        <p>Moderator</p>
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
                                <form action="AdminController" method="post" class="news-create-button" enctype="multipart/form-data">
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
                                        <p><textarea rows="10" cols="10" id="editor" value=""><%= news.getDesc()%></textarea></p>
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
        </div>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
