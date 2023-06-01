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

        <div class="navigator-bar">
            <div class="container ">
                <div class="row navigation-bar-first">
                    <a href="homePage.html" class="logo col-md-3">
                        <img src="./assets/Logo2.png" alt="">
                    </a>
                    <div class="search-bar col-md-6">
                        <form action="" method="post" class="search-bar-content">
                            <input type="text" placeholder="What are you searching for ?">
                            <select name="" id="">
                                <option value="">TITLE</option>
                                <option value="">CATEGORY</option>
                                <option value="">INGREDIENT</option>
                                <option value="">CUISINES</option>
                            </select>
                            <button type="submit"><img src="./assets/search-button.svg" alt="Search Icon"></button>
                        </form>
                    </div>
                    <div class="account col-md-3">
                        <a href="">
                            <img src="assets/profile-pic.svg" alt="">
                            <span>My Account</span>
                        </a>
                    </div>

                </div>
                <div class="row navigation-bar-last">
                    <ul class="navigation-bar-content">
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CATEGORIES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CUISINES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">DIFFICULTIES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li><a href="newsPage.html">NEWS</a></li>
                        <li><a href="">ABOUT US</a></li>
                    </ul>
                </div>
            </div>
        </div>

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
    </body>
</html>
