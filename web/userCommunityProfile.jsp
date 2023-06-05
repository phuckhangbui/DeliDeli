<%-- 
    Document   : userCommunityProfile
    Created on : Jun 2, 2023, 4:27:26 AM
    Author     : khang
--%>

<%@page import="Review.ReviewDAO"%>
<%@page import="Review.ReviewDTO"%>
<%@page import="Recipe.RecipeDAO"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDetailDAO"%>
<%@page import="User.UserDetailDTO"%>
<%@page import="User.UserDAO"%>
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



        <!--        User Community Profile        -->
        <div class="blank-background">
            <div class="container ">
                <div class="row user-community-profile">
                    <div class="col-md-3 user-community-profile-avatar">
                        <div>
                            <img src="./assets/profile-pic.svg" alt="">
                        </div>
                        <div>
                            <p><%=account.getUserName()%></p>
                        </div>
                    </div>
                    <div class="col-md-7 user-community-profile-bio">
                        <div class="row">
                            <div class="col-md-6">
                                <p>NAME</p>
                                <p><%=fullName%></p>
                            </div>
                            <div class="col-md-6">
                                <p>BIRTHDATE</p>
                                <p>31 - 02 - 2002</p> <!<!-- chua them vo db nen t de so dai -->
                            </div>
                            <div class="col-md-12">
                                <p>SPECIALTIES</p>
                                <p>Cajun Seafood, Beef Wellington, Chinese Stir Fry</p> 
                            </div>
                            <div class="col-md-12">
                                <p>ABOUT</p>
                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget
                                    dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes,
                                    nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,
                                    sem. Nulla consequat massa quis enim. Donec.</p> 
                            </div>
                        </div>
                    </div>
                </div>

                <!--        User Community Favorite Recipe       -->
                <div class="container user-community-recipe">
                    <div class="row ">
                        <header class="user-community-recipe-header">
                            <p>Favorite Recipes</p>
                        </header>
                    </div>
                    <div class="row user-community-favorite-recipe">
                        <a href="" class="col-md-4 recommendation-content-post">
                            <div class="recommendation-content-picture">
                                <img src="./pictures/egg1.jpeg" alt="">
                            </div>
                            <div>
                                <p>Indian</p>
                                <p>Chicken Curry</p>
                            </div>
                            <div class="recommendation-content-reciew">
                                <img src="./assets/full-star.png" alt="">
                                <img src="./assets/full-star.png" alt="">
                                <img src="./assets/full-star.png" alt="">
                                <img src="./assets/full-star.png" alt="">
                                <img src="./assets/full-star.png" alt="">
                                <p class="recommendation-content-reciew-rating">2 ratings</p>
                            </div>
                        </a>


                        <div class="user-community-recipe-button">
                            <button class="col-md-12">
                                <a href="">VIEW ALL</a>
                            </button>
                        </div>

                    </div>
                </div>

                <!--        User Community Own Recipe       -->
                <div class="container user-community-recipe">
                    <div class="row ">
                        <header class="user-community-recipe-header">
                            <p>User Own Recipes</p>
                        </header>
                    </div>
                    <div class="row user-community-own-recipe ">
                        <% int count = 0;
                            for (RecipeDTO r : accountRecipe) {
                                count++;
                                if (count < 4) {
                        %>
                        <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>" class="col-md-4 recommendation-content-post">
                            <div class="search-result-content-picture">
                                <img src="<%= RecipeDAO.getThumbnailByRecipeId(r.getId())%>" alt="">
                            </div>
                            <div>
                                <p><%= RecipeDAO.getCategoryByRecipeId(r.getId())%></p>
                                <p><%= r.getTitle()%></p>
                            </div>
                            <div class="recommendation-content-reciew">
                                <%
                                    for (int i = 0; i < RecipeDAO.getRatingByRecipeId(r.getId()); i++) {
                                %>
                                <img src="./assets/full-star.png" alt="">
                                <%
                                    }
                                %>
                                <p class="recommendation-content-reciew-rating"><%= RecipeDAO.getRatingByRecipeId(r.getId())%></p>
                            </div>
                        </a>
                        <%       }
                        %>
                        <div class="user-community-recipe-button">
                            <button class="col-md-12">
                                <a href="">VIEW ALL</a>
                            </button>
                        </div>
                        <%
                            }
                        %>









                    </div>
                </div>


                <!--        User Community Own Reviews       -->
                <div class="container user-community-recipe">
                    <div class="row ">
                        <header class="user-community-recipe-header">
                            <p>Recipes Reviews</p>
                        </header>
                    </div>
                    <div class="row user-community-recipe-review">
                        <% int count1 = 0;
                            for (ReviewDTO review : reviewList) {
                                count1++;
                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(review.getRecipe_id());

                        %>
                        <a href="MainController?action=getRecipeDetailById&id=<%= recipe.getId()%>&activeScroll=true" class="col-md-3 user-community-recipe-review-card">
                            <div class="user-community-recipe-review-card-picture">
                                <img src="<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId())%>" alt="">
                            </div>
                            <div class="user-community-recipe-review-card-title">
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
                            <div class="user-community-recipe-review-card-content">
                                <p><%=review.getContent()%></p>
                            </div>
                        </a>
                        <%
                            }%>


                    </div>
                </div>

                <div class="row user-community-favorite-recipe">

                </div>
                <div class="row ">

                </div>
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
