<%-- 
    Document   : userDetail
    Created on : May 31, 2023, 9:03:57 AM
    Author     : Admin
--%>

<%@page import="User.UserDetailDAO"%>
<%@page import="User.UserDetailDTO"%>
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
            UserDetailDTO userDetail = UserDetailDAO.getUserDetailByUserId(new Integer(userId));
        %>
        <!--        User Public Info Manage        -->
        <div class="blank-background">
            <div class="container ">
                <form action="MainController" method="post" class="row user-profile">
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
                            <a href="userPublicDetail.jsp?userId=<%= user.getId()%>" class="active-link">
                                <img src="./assets/public.svg" alt="">
                                Public Profile
                            </a>
                            <a href="userEmailSetting.jsp?userId=<%= user.getId()%>">
                                <img src="./assets/user-unchose.svg" alt="">
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
                                    <input type="text" name="txtFirstName" value="<%= userDetail.getFirstName()%>">
                                </div>
                                <div>
                                    <p>Last Name</p>
                                    <input type="text" name="txtLastName" value="<%= userDetail.getLastName()%>" >
                                </div>
                            </div>
                            <div class="user-profile-public-content-birth">
                                <p>Birthday</p>
                                <input type="date" name="txtBirthDate" value="<%= userDetail.getBirthdate()%>">
                            </div>
                            <div class="user-profile-public-content-special">
                                <p>Specialties</p>
                                <textarea name="txtSpecialty" id="" cols="30" rows="3"><%= userDetail.getSpecialty()%></textarea>
                            </div>
                            <div class="user-profile-public-content-bio">
                                <p>Bio</p>
                                <textarea name="txtBio" id="" cols="30" rows="5"><%= userDetail.getBio()%></textarea>
                            </div>
                        </div>
                        <div class="user-profile-save-button">
                            <p class="error-popup">${requestScope.errorList[0]}</p>
                            <p>Save Changes?</p>
                            <button type="submit" value="saveUserPublicDetail" name="action">SAVE</button>
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
                            <input type="file" id="image-input" accept="image/*" onchange="previewImage(event)">
                        </div>
                    </div>
                </form>
            </div>
        </div>


<!--        <a href="userPrivateDetail.jsp?userId=<%= userId%>">Private</a>-->

        <!--        <form action="MainController" method="post" class="">
                    <input type="hidden" name="userId" value="<%= userId%>">
                    <div>
                        <p>First Name</p>
                        <input type="text" name="txtFirstName" placeholder="<%= userDetail.getFirstName()%>" required="">
                    </div>
                    <div>
                        <p>Last Name</p>
                        <input type="text" name="txtLastName" placeholder="<%= userDetail.getLastName()%>" required="">
                    </div>
                    <div>
                        <p>Specialty</p>
                        <input type="text" name="txtSpecialty" placeholder="<%= userDetail.getSpecialty()%>" required="">
                    </div>
                    <div>
                        <p>Bio</p>
                        <input type="text" name="txtBio" placeholder="<%= userDetail.getBio()%>" required="">
                    </div>
                    <div>
                        <p>Birth date</p>
                        <input type="text" name="txtBirthDate" placeholder="<%= userDetail.getBirthdate()%>" required="">
                    </div>
                    <div class='error-popup'>
                        <p>${requestScope.errorList[0]}</p>
                    </div>
                    <button type="submit" value="saveUserPublicDetail" name="action">SAVE</button>
                </form>-->

        <%@include file="footer.jsp" %>
        
        
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
