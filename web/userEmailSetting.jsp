<%-- 
    Document   : userPrivateDetail
    Created on : May 31, 2023, 10:13:10 AM
    Author     : Admin
--%>

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
                                <img src="./assets/public-unchose.svg" alt="">
                                Public Profile
                            </a>
                            <a href="userEmailSetting.jsp?userId=<%= userId%>" class="active-link">
                                <img src="./assets/personal.png" alt="">
                                Personal Setting
                            </a>
                            <a href="userPasswordSetting.jsp?userId=<%= user.getId()%>">
                                <img src="./assets/Password-unchose.svg" alt="">
                                Change Password
                            </a>
                            <a href="userSavedRecipes.html">
                                <img src="./assets/favorite-unchose.svg" alt="">
                                Saved Recipes
                            </a>
                            <div class="dropdown" id="dropdownUserRecipe">
                                <a href="#" class="dropbtn">
                                    <img src="./assets/my-recipe-unchose.svg" alt="">
                                    My Own Recipes
                                </a>
                                <div class="dropdown-content-right">
                                    <a href="privateRecipeManagement.jsp?userId=<%= userId%>">Private Recipes</a>
                                    <a href="pendingRecipeManagement.jsp?userId=<%= userId%>">Pending Recipes</a>
                                    <a href="publicRecipeManagement.jsp?userId=<%= userId%>">Public Recipes</a>
                                    <a href="rejectedRecipeManagement.jsp?userId=<%= userId%>">Rejected Recipes</a>
                                </div>
                            </div>
                            <a href="userReviewManagement.jsp?userId=<%= userId%>">
                                <img src="./assets/review-unchose.svg" alt="">
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
                                This is your avatar that everyone can see
                            </p>
                        </div>
                        <div class="user-profile-public-avatar">
                            <div>
                                <img id="preview-image" src="./assets/profile-pic.svg" alt="">
                            </div>
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


        <%@include file="footer.jsp" %>
        
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
