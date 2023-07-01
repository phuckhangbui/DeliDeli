<%-- 
    Document   : userDetail
    Created on : May 31, 2023, 9:03:57 AM
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

        <%            
            String userId = request.getParameter("userId");
            UserDetailDTO userDetail = (UserDetailDTO)request.getAttribute("userDetail");
        %>
        <!--        User Public Info Manage        -->
        <div class="blank-background">
            <div class="container ">
                <form action="UserController" method="post" class="row user-profile" enctype="multipart/form-data">
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
                            <a href="UserController?action=userPublicDetail&userId=<%=user.getId()%>" class="active-link">
                                <img src="./assets/public-icon.svg" alt="">
                                Public Profile
                            </a>
                            <a href="UserController?action=userEmailSetting&userId=<%=user.getId()%>">
                                <img src="./assets/user-unchosen-icon.svg" alt="">
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
                                <a href="#">
                                    <img src="./assets/my-recipe-icon.svg" alt="">
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
                                Public Profile
                            </div>
                            <p>
                                Input some personal information so people can know more about you
                            </p>
                        </div>
                        <div class="user-profile-public-content">
                            <div class="user-profile-public-content-name">
                                <div>
                                    <p>First Name</p>
                                    <input type="text" class="enable" name="txtFirstName" value="<%= userDetail.getFirstName()%>">
                                </div>
                                <div>
                                    <p>Last Name</p>
                                    <input type="text" class="enable" name="txtLastName" value="<%= userDetail.getLastName()%>" >
                                </div>
                            </div>
                            <div class="user-profile-public-content-birth">
                                <p>Birthday</p>
                                <input type="date" class="enable" name="txtBirthDate" value="<%= userDetail.getBirthdate()%>">
                            </div>
                            <div class="user-profile-public-content-special">
                                <p>Specialties</p>
                                <textarea name="txtSpecialty" class="enable" cols="30" rows="3" placeholder="What are your specialties ?"><%= userDetail.getSpecialty()%></textarea>
                            </div>
                            <div class="user-profile-public-content-bio">
                                <p>Bio</p>
                                <textarea name="txtBio" class="enable" cols="30" rows="5" placeholder="Write something about yourself"><%= userDetail.getBio()%></textarea>
                            </div>
                        </div>
                        <div class="user-profile-save-button">
                            <p class="error-popup">${requestScope.errorList[0]}</p>
                            <p>Save Changes?</p>
                            <button type="submit" value="saveUserPublicDetail" name="action" id="save" >SAVE</button>
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
                            <input type="file" id="image-input" name="file" class="enable">
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
