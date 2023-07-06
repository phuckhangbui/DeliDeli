<%-- 
    Document   : userPrivateDetail
    Created on : May 31, 2023, 10:13:10 AM
    Author     : Admin
--%>

<%@page import="DTO.UserDetailDTO"%>
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
        <%@include file="header.jsp" %>

        <!--        User Public Info Manage        -->
        <%
            String userId = request.getParameter("userId");
            UserDetailDTO userDetail = (UserDetailDTO)request.getAttribute("userDetail");
        %>
        <div class="blank-background">
            <div class="container ">
                <form action="UserController" method="post" class="row user-profile">
                    <input type="hidden" name="userId" value="<%= userId%>">



                    <div class="col-md-3 user-profile-column-1">
                        <div class="user-profile-header">
                            <div>
                                Management
                            </div>
                            <p>
                                Manage your account
                            </p>
                        </div>
                        <div class="user-profile-option">
                            <a href="UserController?action=userPublicDetail&userId=<%=user.getId()%>">
                                <img src="./assets/public-unchosen-icon.svg" alt="">
                                Public Profile
                            </a>
                            <a href="UserController?action=userEmailSetting&userId=<%=user.getId()%>" class="active-link">
                                <img src="./assets/user-icon.svg" alt="">
                                Personal Setting
                            </a>
                            <a href="UserController?action=userPasswordSetting&userId=<%=user.getId()%>">
                                <img src="./assets/password-unchosen-icon.svg" alt="">
                                Change Password
                            </a>
                            <a href="userSavedRecipes.html">
                                <img src="./assets/favorite-unchosen-icon.svg" alt="">
                                Saved Recipes
                            </a>
                            <div class="dropdown" id="dropdownUserRecipe">
                                <a href="#" >
                                    <img src="./assets/my-recipe-unchosen-icon.svg" alt="">
                                    My Own Recipes
                                </a>
                                <div class="dropdown-content-right">
                                    <a href="UserController?action=loadRecipeManagement&page=private&userId=<%= userId%>">Private Recipes</a>
                                    <a href="UserController?action=loadRecipeManagement&page=pending&userId=<%= userId%>">Pending Recipes</a>
                                    <a href="UserController?action=loadRecipeManagement&page=public&userId=<%= userId%>">Public Recipes</a>
                                    <a href="UserController?action=loadRecipeManagement&page=rejected&userId=<%= userId%>">Rejected Recipes</a>
                                </div>
                            </div>
                            <a href="UserController?action=loadUserReview&userId=<%= userId%>">
                                <img src="./assets/full-star-unchosen-icon.svg" alt="">
                                My Reviews
                            </a>
<!--                            <a href="userNotification.jsp?userId=<%= userId%>">
                                My Notifications
                            </a>-->
                        </div>
                    </div>     



                    <div class="col-md-5 user-profile-column-2">
                        <div class="user-profile-header">
                            <div>
                                Personal Setting
                            </div>
                            <p>
                                View your personal account information here
                            </p>
                        </div>
                        <div class="user-profile-personal-content">
                            <div class="user-profile-personal-content-readonly">
                                <p>User Name</p>
                                <input type="text" placeholder="<%= user.getUserName()%>" readonly class="enable">
                            </div>
                            <div>
                                <p>Email</p>
                                <input type="text" name="txtEmail" value="<%= user.getEmail()%>" class="enable">
                            </div>
                        </div>
                        <div class="user-profile-save-button">
                            <p class='error-popup'>${requestScope.errorList[0]}</p>
                            <p>Save Changes ?</p>
                            <button type="submit" value="changeUserEmail" name="action" id="save">SAVE</button>
                        </div>
                    </div>
                    <div class="col-md-3 user-profile-column-3 ">
                        <div class="user-profile-header">
                            <div>
                                Profile Picture
                            </div>
                            <p>
                                This is your avatar that everyone can see
                            </p>
                        </div>
                        <div class="user-profile-public-avatar">
                            <div>
                                <img src="ServletImageLoader?identifier=<%= user.getAvatar()%>" alt="">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>




        <%@include file="footer.jsp" %>

        <script src="script/DisabledButton.js"></script>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
