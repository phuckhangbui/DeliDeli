<%-- 
    Document   : header
    Created on : May 24, 2023, 7:23:26 PM
    Author     : khang
--%>

<%@page import="User.UserDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">

    <head>
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <!--      CSS         -->
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
              rel="stylesheet">

    </head>

    <body>
        <%
            HashMap<Integer, String> cateMap = Utils.NavigationBarUtils.getMap("Category");
            HashMap<Integer, String> cuisineMap = Utils.NavigationBarUtils.getMap("Cuisine");
            HashMap<Integer, String> levelMap = Utils.NavigationBarUtils.getMap("Level");
            HashMap<Integer, String> ingredientMap = Utils.NavigationBarUtils.getMap("Ingredient");
            HashMap<Integer, String> dietMap = Utils.NavigationBarUtils.getMap("Diet");

            HashMap<Integer, String> newsMap = Utils.NavigationBarUtils.getMap("NewsCategory");

            UserDTO user = (UserDTO) session.getAttribute("user");

        %>
        <div class="navigator-bar">
            <div class="container ">
                <div class="row navigation-bar-first">
                    <a href="home.jsp" class="logo col-md-3">
                        <img src="./assets/Logo2.png" alt="">
                    </a>
                    <div class="search-bar col-md-7">
                        <form <form action="MainController" method="post">
                            <button type="submit" name="action" value="search"><img src="assets/search2.svg" alt=""></button>
                            <input type="text" name="txtsearch" placeholder="What are you searching for ?">
                            <select name="searchBy" id="" class="">
                                <option value="Title" selected="selected">TITLE</option>
                                <option value="Category">CATEGORIES</option>
                                <option value="Cuisine">CUISINES</option>
                                <option value="Diet">DIETS</option>
                            </select>
                        </form>
                    </div>
                    <%if (user != null) {%>
                    <div class="account col-md-2">
                        <span>
                            <div class="user-dropdown">
                                <button class="user-dropbtn"><%=user.getUserName()%></button>
                                <div class="user-dropdown-content">
                                    <a href="userCommunityProfile.jsp?accountName=<%= user.getUserName()%>">Your Profile</a>
                                    <a href="userPublicDetail.jsp?userId=<%=user.getId()%>">Management</a>
                                    <a href="addRecipe.jsp">Add Recipe</a>
                                    <a href="MainController?action=logout" >Logout</a>
                                </div>
                            </div>
                        </span>
                    </div>

                    <%} else { %>
                    <div class="account col-md-2">
                        <span><a href="login.jsp">Sign in</a></span>
                        <span>|</span>
                        <span><a href="registration.jsp">Register</a></span>
                    </div>
                    <% }%>
                </div>
                <div class="row navigation-bar-last">
                    <ul class="navigation-bar-content">
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">INGREDIENTS</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : ingredientMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=Ingredient&id=<%=key%>"><%=value%></a>
                                    <%}%>
                                    <a href="">View more</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="user-dropdown">
                                <button class="user-dropbtn">CATEGORIES</button>
                                <div class="user-dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : cateMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=Category&id=<%=key%>"><%=value%></a>

                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CUISINES</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : cuisineMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=Cuisine&id=<%=key%>"><%=value%></a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">DIFFICULTIES</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : levelMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=Level&id=<%=key%>"><%=value%></a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">DIETS</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : dietMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=Diet&id=<%=key%>"><%=value%></a>
                                    <%}%>
                                </div>
                            </div>
                        </li>

                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">NEWS</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry : newsMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <a href="searchResultPage.jsp?type=NewsCategory&id=<%=key%>"><%=value%></a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li><a href="#">ABOUT US</a></li>
                    </ul>
                </div>
            </div>
        </div>






        <!--      Bootstrap for JS         -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
</html>