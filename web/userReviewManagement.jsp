<%-- 
    Document   : userReviewManagement
    Created on : Jun 8, 2023, 10:51:24 PM
    Author     : khang
--%>

<%@page import="Recipe.RecipeDAO"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="Review.ReviewDAO"%>
<%@page import="Review.ReviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">

    </head>

    <body>
        <%@include file="header.jsp" %>



        <!--        User Public Info Manage        -->
        <div class="blank-background">
            <div class="container ">
                <form class="row user-profile">

                    <%@include file="userManagementSideBar.jsp" %>

                    <div class="col-md-5 user-profile-column-2">
                        <div class="user-profile-header">
                            <div>
                                Personal Ratings
                            </div>
                            <p>
                                View your personal ratings on others recipes
                            </p>
                        </div>
                        <div class="row user-profile-recipes">
                            <%
                                ArrayList<ReviewDTO> reviewList = ReviewDAO.getReviewByUserId(user.getId());
                                for (ReviewDTO review : reviewList) {
                                    RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(review.getRecipe_id());
                            %>
                            <a href="MainController?action=getRecipeDetailById&id=<%= recipe.getId()%>&activeScroll=true" class="col-md-6 user-profile-recipe-review">
                                <div class="user-profile-recipe-post-picture">
                                    <img src="<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                </div>
                                <div class="user-profile-recipe-review-title">
                                    <p><%= recipe.getTitle()%></p>
                                </div>
                                <div class="recommendation-content-reciew">
                                    <%
                                        for (int i = 0; i < review.getRating(); i++) {
                                    %>
                                    <img src="./assets/full-star.png" alt="">
                                    <%
                                        }
                                    %>

                                </div>
                                <div class="user-profile-recipe-review-content">
                                    <p><%=review.getContent()%></p>
                                </div>
                            </a>
                            <%
                                }%>


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


        <!--         Footer       -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="website-social-media col-md-6">
                        <a href="homePage.html" class="website-social-media-logo">
                            <img src="./assets/Logo2.png" alt="">
                        </a>
                        <div class="website-social-media-icons">
                            <span>Follow us:</span>
                            <a href="#"><img src="./assets/facebook-icon.svg" alt="Facebook Logo"></a>
                            <a href="#"><img src="./assets/twitter-icon.svg" alt="Twitter Logo"></a>
                        </div>
                    </div>
                    <nav class="navigation-bar-footer col-md-3">
                        <ul class="navigation-bar-footer-content">
                            <li><a href="">CATEGORIES</a></li>
                            <li><a href="">INGREDIENTS</a></li>
                            <li><a href="">CUISINES</a></li>
                            <li><a href="">DIFFICULTIES</a></li>
                            <li><a href="">NEWS</a></li>
                        </ul>
                    </nav>
                    <nav class="website-infomation-bar col-md-3">
                        <ul class="website-infomation-bar-content">
                            <li><a href="">About us</a></li>
                            <li><a href="">Privacy Policies</a></li>
                            <li><a href="">Term of Services</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!--      Bootstrap for JS         -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
