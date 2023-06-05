<%-- 
    Document   : userPrivateDetail
    Created on : May 31, 2023, 10:13:10 AM
    Author     : Admin
--%>

<%@page import="Review.ReviewDAO"%>
<%@page import="Recipe.RecipeDAO"%>
<%@page import="Review.ReviewDTO"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDTO"%>
<%@page import="User.UserDAO"%>
<%@page import="User.UserDetailDTO"%>
<%@page import="User.UserDetailDAO"%>
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
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>

    <body>
        <% String accountName = request.getParameter("accountName");
            UserDTO account = UserDAO.getAccountByName(accountName);
            String fullName = "";
            ArrayList<RecipeDTO> accountRecipe = null;
            ArrayList<ReviewDTO> reviewList = null;
            if (account != null) {
                UserDetailDTO accountDetail = UserDetailDAO.getUserDetailByUserId(account.getId());
                fullName = accountDetail.getLastName() + " " + accountDetail.getFirstName();
                accountRecipe = RecipeDAO.getRecipeByUserId(account.getId());
                reviewList = ReviewDAO.getReviewByUserId(account.getId());
            }
        %>
        <%@include file="header.jsp" %>


        <!--        User Public Info Manage        -->
        <%
            String userId = request.getParameter("userId");
            UserDetailDTO userDetail = UserDetailDAO.getUserDetailByUserId(new Integer(userId));
        %>
        <div class="blank-background">
            <div class="container ">
                <form action="MainController" method="post" class="row user-profile">
                    <input type="hidden" name="userId" value="<%= userId%>">
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
                            <a href="userPublicDetail.jsp?userId=<%= userId%>">
                                <img src="./assets/public.svg" alt="">
                                Public Profile
                            </a>
                            <a href="userEmailSetting.jsp?userId=<%= userId%>">
                                <img src="./assets/personal.png" alt="">
                                Personal Setting
                            </a>
                            <a href="userPasswordSetting.jsp?userId=<%= userId%>">
                                <img src="./assets/Password.svg" alt="">
                                Change Password
                            </a>
                            <a href="userSavedRecipes.html">
                                <img src="./assets/favorite.svg" alt="">
                                Saved Recipes
                            </a>
                            <a href="userOwnRecipes.html">
                                <img src="./assets/my-recipe.svg" alt="">
                                My Own Recipes
                            </a>
                            <a href="userOwnReviews.html">
                                <img src="./assets/full-star.png" alt="">
                                My Reviews
                            </a>
                        </div>
                    </div>
                    <div class="col-md-5 user-profile-column-2">
                        <div class="user-profile-header">
                            <div>
                                Personal Profile
                            </div>
                            <p>
                                View your personal account information here
                            </p>
                        </div>
                        <div class="user-profile-personal-content">
                            <div class="user-profile-personal-content-readonly">
                                <p>User Name</p>
                                <input type="text" placeholder="<%= user.getUserName()%>" readonly>
                            </div>
                            <div>
                                <p>Email</p>
                                <input type="text" name="txtEmail" value="<%= user.getEmail()%>" >
                            </div>
                        </div>
                        <div class="user-profile-save-button">
                            <p class='error-popup'>${requestScope.errorList[0]}</p>
                            <p>Save Changes ?</p>
                            <button type="submit" value="changeUserEmail" name="action">SAVE</button>
                        </div>
                    </div>
                    <div class="col-md-3 user-profile-column-3 ">
                        <div class="user-profile-header">
                            <div>
                                Profile Picture
                            </div>
                            <p>
                                Click the image to change your profile picture
                            </p>
                        </div>
                        <div class="user-profile-public-avatar">
                            <div>
                                <img id="preview-image" src="./assets/profile-pic.svg" alt="">
                            </div>
                            <input type="file" id="image-input" accept="image/*" onchange="previewImage(event)">
                        </div>
                    </div>
                </form>
            </div>
        </div>


<!--        <a href="userPublicDetail.jsp?userId=<%= userId%>">Public</a>

        <form action="MainController" method="post" class="">
            <input type="hidden" name="userId" value="<%= userId%>">
            <div>
                <p>Old Password</p>
                <input type="password" name="txtOldPassword" required="">
            </div>
            <div>
                <p>New Password</p>
                <input type="password" name="txtNewPassword" required="">
            </div>
            <div>
                <p>Re-enter New Password</p>
                <input type="password" name="txtConfirmNewPassword" required="">
            </div>
            <div class='error-popup'>
                <p>${requestScope.errorList[0]}</p>
            </div>
            <button type="submit" value="saveUserPrivateDetail" name="action">SAVE</button>
        </form>-->
    </body>
</html>
