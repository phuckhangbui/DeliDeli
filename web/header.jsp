<%-- 
    Document   : header
    Created on : May 24, 2023, 7:23:26 PM
    Author     : khang
--%>

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
    
    <div class="navigator-bar">
        <div class="container ">
            <div class="row navigation-bar-first">
                <a href="home.jsp" class="logo col-md-3">
                    <img src="./assets/Logo2.png" alt="">
                </a>
                <div class="search-bar col-md-6">
                    <form action="MainController" method="post" class="search-bar-content">
                        <input type="text" name="txtsearch" placeholder="What are you searching for ?">
                        <select name="searchBy" id="">
                            <option value="Title" selected="selected">TITLE</option>
                            <option value="Category">CATEGORY</option>
                            <!--<option value="">INGREDIENT</option>-->
                            <option value="Cuisine">CUISINES</option>
                        </select>
                        <button type="submit" name="action" value="search"><img src="./assets/search-button.svg" alt="Search Icon"></button>
                    </form>
                </div>
                <div class="account col-md-3">
                    <span><a href="login.jsp">Sign in</a></span>
                    <span>|</span>
                    <span><a href="registration.jsp">Register</a></span>
                </div>

            </div>
            <div class="row navigation-bar-last">
                <ul class="navigation-bar-content">
                    <li><a href="searchResultPage.html">CATEGORIES</a></li>
                    <li><a href="">INGREDIENTS</a></li>
                    <li><a href="">CUISINES</a></li>
                    <li><a href="">DIFFICULTIES</a></li>
                    <li><a href="">NEWS</a></li>
                    <li><a href="">ABOUT US</a></li>
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