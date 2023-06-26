<%-- 
    Document   : userManagementSideBar
    Created on : Jun 8, 2023, 2:43:25 PM
    Author     : khang
--%>

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
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>
    <body>
        <div class="col-md-3 user-profile-column-1">
            <div class="user-profile-header">
                <div>
                    Setting
                </div>
                <p>
                    Customize your profile
                </p>
            </div>
            <div class="user-profile-option">
                <a href="userPublicDetail.jsp?userId=<%= user.getId()%>">
                    <img src="./assets/public.svg" alt="">
                    Public Profile
                </a>
                <a href="userEmailSetting.jsp?userId=<%= user.getId()%>">
                    <img src="./assets/personal.png" alt="">
                    Personal Setting
                </a>
                <a href="userPasswordSetting.jsp?userId=<%= user.getId()%>">
                    <img src="./assets/Password.svg" alt="">
                    Change Password
                </a>
                <a href="userSavedRecipes.html">
                    <img src="./assets/favorite.svg" alt="">
                    Saved Recipes
                </a>
                <div class="dropdown" id="dropdownUserRecipe">
                    <a href="#" class="dropbtn">
                        <img src="./assets/my-recipe.svg" alt="">
                        My Own Recipes
                    </a>
                    <div class="dropdown-content-right">
                        <a href="privateRecipeManagement.jsp">Private Recipes</a>
                        <a href="pendingRecipeManagement.jsp">Pending Recipes</a>
                        <a href="publicRecipeManagement.jsp">Public Recipes</a>
                    </div>
                </div>
                <a href="userReviewManagement.jsp">
                    <img src="./assets/full-star.png" alt="">
                    My Reviews
                </a>
            </div>
        </div>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
