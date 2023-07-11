<%-- 
    Document   : privateRecipeManagement
    Created on : Jun 8, 2023, 9:15:37 PM
    Author     : khang
--%>

<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DTO.UserDetailDTO"%>
<%@page import="DAO.UserDetailDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

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
                <form class="row user-profile">
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
                            <a href="UserController?action=userEmailSetting&userId=<%=user.getId()%>">
                                <img src="./assets/user-unchosen-icon.svg" alt="">
                                Personal Setting
                            </a>
                            <a href="UserController?action=userPasswordSetting&userId=<%=user.getId()%>">
                                <img src="./assets/password-unchosen-icon.svg" alt="">
                                Change Password
                            </a>
                            <a href="#">
                                <img src="./assets/favorite-unchosen-icon.svg" alt="">
                                Saved Recipes
                            </a>
                            <div class="dropdown" id="dropdownUserRecipe">
                                <a href="#" class="active-link">
                                    <img src="./assets/my-recipe-icon.svg" alt="">
                                    My Own Recipes
                                </a>
                                <div class="dropdown-content-right">
                                    <a href="UserController?action=loadRecipeManagement&page=private&userId=<%= userId%>" >Private Recipes</a>
                                    <a href="UserController?action=loadRecipeManagement&page=pending&userId=<%= userId%>">Pending Recipes</a>
                                    <a href="UserController?action=loadRecipeManagement&page=public&userId=<%= userId%>" class="active-link">Public Recipes</a>
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

                     <%
                        ArrayList<DisplayRecipeDTO> displayList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("displayRecipeList");
                    %>

                    <div class="col-md-5 user-profile-column-2">
                        <div class="user-profile-header">
                            <div>
                                Public Recipes
                            </div>
                            <p>
                                View your own recipes that you made for everyone to see
                            </p>
                        </div>
                        <div class="row user-profile-recipes">
                            <%
                                for (DisplayRecipeDTO r : displayList) {
                            %>
                            <div  class="col-md-6 user-profile-recipe-post">
                                <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                                   class="user-profile-recipe-post-picture" data-page="editRecipe.jsp?recipeId=<%=r.getId()%>">
                                    <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath() %>" alt="">
                                </a>

                                <div>
                                    <div class="user-profile-recipe-post-description">
                                        <p><%= r.getCategory() %></p>
                                        <a href="UserController?action=loadEditRecipe&recipeId=<%=r.getId()%>">
                                            <img src="./assets/edit-icon.svg"/>
                                        </a>
                                    </div>
                                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"><%= r.getTitle()%></a>
                                </div>
                                <div class="recommendation-content-reciew">
                                    <%
                                        double avaRating = r.getRating();
                                        int fullStars = (int) avaRating;
                                        boolean hasHalfStar = avaRating - fullStars >= 0.5;

                                        for (int i = 0; i < fullStars; i++) {
                                    %>
                                    <img src="./assets/full-star-icon.svg" alt="">
                                    <%
                                        }

                                        if (hasHalfStar) {
                                    %>
                                    <img src="./assets/half-star-icon.svg" alt="" style="width: 17px">
                                    <%
                                        }

                                        int remainingStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

                                        for (int i = 0; i < remainingStars; i++) {
                                    %>
                                    <img src="./assets/empty-star-icon.svg" alt="">
                                    <%
                                        }
                                    %>
                                    <p class="recommendation-content-reciew-rating"><%= r.getRating()%></p>
                                </div>
                            </div>
                            <% }%>

                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    // Get references to all edit buttons
                                    var editButtons = document.querySelectorAll('.editButton');

                                    editButtons.forEach(function (editButton) {
                                        editButton.addEventListener('click', function () {
                                            // Find the parent recipe element
                                            var recipe = editButton.closest('.user-profile-recipe-post-picture');

                                            // Get the data-page attribute value from the recipe element
                                            var page = recipe.getAttribute('data-page');

                                            // Navigate to the corresponding page
                                            window.location.href = page;
                                        });
                                    });
                                });
                            </script>
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


        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>

    </body>
</html>
