<%-- 
    Document   : headerAdmin
    Created on : Jun 8, 2023, 8:38:19 PM
    Author     : Admin
--%>

<%@page import="User.UserDTO"%>
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
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null || user.getRole() != 2) {
                response.sendRedirect("error.jsp");
            } else {
        %>

        <nav class="navbar row ">
            <div class="col-md-2">
                <a class="logo" href="">
                    <img src="assets/Logo3.svg" alt="">
                </a>
            </div>
            <div class="col-md-10 nav-top-bar">
                <div class="nav-top-bar-search">
                    <!--                    <form action="">
                                            <button><img src="assets/search2.svg" alt=""></button>
                                            <input type="text" placeholder="What are you searching for ?">
                                            <select name="" id="" class="">
                                                <option value="">Users</option>
                                                <option value="">News</option>
                                                <option value="">Posts</option>
                                            </select>
                                        </form>-->
                </div>
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
    </body>
</html>
