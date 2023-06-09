<%-- 
    Document   : recipeDetail
    Created on : May 30, 2023, 7:58:19 AM
    Author     : Admin
--%>

<%@page import="Recipe.RecipeDAO"%>
<%@page import="Direction.DirectionDAO"%>
<%@page import="User.UserDAO"%>
<%@page import="User.UserDTO"%>
<%@page import="Review.ReviewDAO"%>
<%@page import="Review.ReviewDTO"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="IngredientDetail.IngredientDetailDTO"%>
<%@page import="Direction.DirectionDTO"%>
<%@page import="java.util.ArrayList"%>
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

        <%
            ArrayList<IngredientDetailDTO> ingredientDetailList = (ArrayList) request.getAttribute("ingredientDetailList");
            ArrayList<DirectionDTO> directionList = (ArrayList) request.getAttribute("directionList");
            ArrayList<ReviewDTO> reviewList = (ArrayList) request.getAttribute("reviewList");
            RecipeDTO recipe = (RecipeDTO) request.getAttribute("recipe");
            int ownerId = recipe.getUser_id();
            UserDTO owner = UserDAO.getUserByUserId(ownerId);
            String link = "userCommunityProfile.jsp?accountName=" + owner.getUserName();
        %>

        <%@include file="header.jsp" %>
        <!--        Recipe Detail         -->
        <div class="blank-background">
            <div class="container ">
                <div class="row recipe-detail-info">
                    <header class="recipe-detail-info-main-header">
                        <%= recipe.getTitle()%>
                    </header>
                    <div class="recipe-detail-info-user">
                        <a href="<%=link%>"><img src="./assets/profile-pic.svg" alt=""></a>
                        <div>
                            <span>By</span>
                            <span><a href="<%=link%>"><%= request.getAttribute("owner")%></a></span>
                            <p>Published on <%= recipe.getCreate_at()%></p>
                        </div>
                    </div>
                    <div class="recipe-detail-info-interaction">
                        <div class="recipe-detail-info-review">
                            <%
                                double avaRating = (Double) request.getAttribute("avgRating");
                                for (double i = 0; i < avaRating; i++) {
                            %>
                            <img src="./assets/full-star.png" alt="">
                            <%
                                }
                            %>
                            <p><%= request.getAttribute("avgRating")%></p>
                            <p>|</p>
                            <p class=""><%= request.getAttribute("totalReview")%> ratings</p>
                        </div>
                        <form action="" class="recipe-detail-info-button-add">
                            <input type="text" hidden="">
                            <div>

                                <button type="submit" class="like-button">
                                    <img src="./assets/favorite.svg" alt="">
                                    Save
                                </button>
                            </div>
                        </form>
                        <button class="share-button">
                            <img src="./assets/share.svg" alt="">
                            Share
                        </button>
                    </div>
                    <div class="recipe-detail-main-pic">
                        <img src="<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                    </div>
                    <div class="recipe-detail-info-overview">
                        <div class="recipe-detail-info-overview-content">
                            <div class="recipe-detail-info-header">
                                <%= recipe.getTitle()%>
                            </div>
                            <div class="row recipe-detail-info-overview-content-info">
                                <div class="col-md-3">
                                    <p>Prep time:</p>
                                    <% if (recipe.getPrep_time() > 60) {
                                    %>
                                    <p><%= recipe.getPrep_time() / 60%> hr(s) <%= recipe.getPrep_time() % 60%> min(s)</p>
                                    <%
                                    } else {
                                    %>
                                    <p><%= recipe.getPrep_time()%> min(s)</p>
                                    <%
                                        }%>
                                </div>
                                <div class="col-md-3">
                                    <p>Cook time:</p>
                                    <% if (recipe.getCook_time() > 60) {
                                    %>
                                    <p><%= recipe.getCook_time() / 60%> hr(s) <%= recipe.getCook_time() % 60%> min(s)</p>
                                    <%
                                    } else {
                                    %>
                                    <p><%= recipe.getCook_time()%> min(s)</p>
                                    <%
                                        }%>
                                </div>
                                <div class="col-md-3">
                                    <p>Total time:</p>
                                    <% if ((recipe.getPrep_time() + recipe.getCook_time()) > 60) {
                                    %>
                                    <p><%= (recipe.getPrep_time() + recipe.getCook_time()) / 60%> hr(s) <%= (recipe.getPrep_time() + recipe.getCook_time()) % 60%> min(s)</p>
                                    <%
                                    } else {
                                    %>
                                    <p><%= (recipe.getPrep_time() + recipe.getCook_time())%> min(s)</p>
                                    <%
                                        }%>
                                </div>
                                <div class="col-md-3">
                                    <p>Serving:</p>
                                    <p><%= recipe.getServings()%></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="recipe-detail-info-ingredients">
                        <div class="recipe-detail-info-header">
                            Ingredients
                        </div>
                        <ul>
                            <%
                                if (ingredientDetailList.size() > 0 && ingredientDetailList != null) {
                                    for (IngredientDetailDTO o : ingredientDetailList) {
                            %>
                            <li><%= o.getDesc()%></li>
                                <%
                                        }
                                    }
                                %>
                        </ul>
                    </div>
                    <div class="recipe-detail-info-direction">
                        <div class="recipe-detail-info-header">
                            Directions
                        </div>
                        <div>
                            <%
                                DirectionDTO direction = DirectionDAO.getDirectionByRecipeId(recipe.getId());
                            %>

                            <p class="recipe-detail-info-direction-header"><%= direction.getDesc()%></p>


                        </div>
                    </div>
                    <% try {
                            String path = RecipeDAO.getImageByRecipeId(recipe.getId()).getImgPath();

                    %>
                    <div class="recipe-detail-secondary-pic">
                        <img src="<%= RecipeDAO.getImageByRecipeId(recipe.getId()).getImgPath()%>" alt="">
                    </div>
                    <% } catch (Exception e) {

                        }%>
                </div>

<<<<<<< HEAD
                <%@include file="reviewSection.jsp" %>
=======




                <!--        Reviews         -->
                <div class="row recipe-detail-review" id="scrollTarget">
                    <header class="recipe-detail-review-main-header">
                        REVIEWS
                    </header>
                    <%if (user != null) {%>
                    <form class="recipe-detail-review-self" id="ratingForm" action="MainController" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="recipe-detail-review-self-header">Your Rating</p>
                                <div class="recipe-detail-review-self-rating rate">
                                    <input type="text" name="recipeId" value="<%= recipe.getId()%>" hidden="">

                                    <input type="radio" id="star5" name="rating" value="5" />
                                    <label for="star5" title="text">5 stars</label>
                                    <input type="radio" id="star4" name="rating" value="4" />
                                    <label for="star4" title="text">4 stars</label>
                                    <input type="radio" id="star3" name="rating" value="3" />
                                    <label for="star3" title="text">3 stars</label>
                                    <input type="radio" id="star2" name="rating" value="2" />
                                    <label for="star2" title="text">2 stars</label>
                                    <input type="radio" id="star1" name="rating" value="1"/>
                                    <label for="star1" title="text">1 star</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <p class="recipe-detail-review-self-header">Your Review</p>
                                <textarea name="txtReview" id="" cols="1" rows="5" class="recipe-detail-review-self-review"
                                          placeholder="What do think of the recipe above? (Optional)"></textarea>
                            </div>
                        </div>
                        <div class="recipe-detail-review-self-button" >
                            <button name="action" value="getFeedback" id="submitButton" type="submit" disabled="">SUBMIT</button>
                        </div>
                    </form>

                    <script>
                        const ratingForm = document.getElementById('ratingForm');
                        const submitButton = document.getElementById('submitButton');

                        ratingForm.addEventListener('change', function () {
                            const stars = document.querySelectorAll('input[name="rating"]');
                            let starChecked = false;
                            for (let i = 0; i < stars.length; i++) {
                                if (stars[i].checked) {
                                    starChecked = true;
                                    break;
                                }
                            }
                            submitButton.disabled = !starChecked;
                        });

                    </script>

                    <%
                        //Only active scroll whenever needed.
                        String activeScroll = request.getParameter("activeScroll");
                        if (activeScroll != null) {
                    %>
                    <script>
                        window.onload = function () {
                            const scrollTarget = document.getElementById("scrollTarget");
                            scrollTarget.scrollIntoView({behavior: 'smooth'});
                        }
                    </script>
                    <%
                        }
                    %>


                    <%} else {%>
                    <p>You must <a href="login.jsp?recipeID=1">login</a> to review</p>
                    <% }%>
                    <div class="recipe-detail-review-others">

                        <%
                            if (reviewList.size() > 0 && reviewList != null) {
                                for (ReviewDTO o : reviewList) {
                        %>
                        <div class="recipe-detail-review-others-info">
                            <a href=""><img src="./assets/profile-pic.svg" alt=""></a>
                            <div class="recipe-detail-review-others-info-content">
                                <a href=""><%= ReviewDAO.getReviewOwnerByUserId(o.getUser_id())%></a>
                                <div class="recipe-detail-review-others-info-review">
                                    <%
                                        for (int i = 0; i < o.getRating(); i++) {
                                    %>
                                    <img src="./assets/full-star.png" alt="">
                                    <%
                                        }
                                    %>
                                    <div><%= o.getCreate_at()%></div>
                                </div>
                                <p>
                                    <%= o.getContent()%>
                                </p>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>



>>>>>>> khoa-admin-user-manage
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
</html>
