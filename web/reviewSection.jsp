<%-- 
    Document   : reviewSection
    Created on : Jun 6, 2023, 8:00:15 PM
    Author     : khang
--%>

<%@page import="DTO.DisplayReviewDTO"%>
<%@page import="DAO.UserDAO"%>
<%@page import="DAO.ReviewDAO"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="java.util.ArrayList"%>
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

        <div class="row recipe-detail-review" id="scrollTarget">

            <%
//                RecipeDTO recipe = (RecipeDTO) request.getAttribute("recipe");
//                int ownerId = recipe.getUser_id();
//                UserDTO user = UserDAO.getUserByUserId(ownerId);
//                ArrayList<ReviewDTO> reviewList = (ArrayList) request.getAttribute("reviewList");
            %>

            <%
                String activeScroll = request.getParameter("activeScroll");
                if (user != null) {
                    DisplayReviewDTO userDisplayReview =  (DisplayReviewDTO) request.getAttribute("userDisplayReview");
                    if (userDisplayReview != null) {
            %>
            <header class="recipe-detail-review-main-header">
                EDIT YOUR REVIEWS
            </header>
            <form class="recipe-detail-review-self" id="ratingForm" action="UserController" method="post">
                <div class="row">
                    <div class="col-md-6">
                        <p class="recipe-detail-review-self-header">Your Rating</p>
                        <div class="recipe-detail-review-self-rating rate">
                            <input type="text" name="reviewId" value="<%= userDisplayReview.getId()%>" hidden="">
                            <input type="text" name="recipeId" value="<%= userDisplayReview.getRecipeId()%>" hidden="">
                            <input type="text" name="userId" value="<%= user.getId()%>" hidden="">


                            <% for (int i = 5; i > 0; i--) {

                                    if (userDisplayReview.getReviewRating()== i) {%>
                            <input type="radio" id="star<%=i%>" name="rating" value="<%=i%>" checked/>
                            <label for="star<%=i%>" title="text"><%=i%> stars</label>
                            <%} else {%>



                            <input type="radio" id="star<%=i%>" name="rating" value="<%=i%>" />
                            <label for="star<%=i%>" title="text"><%=i%> stars</label>


                            <% }
                                }%>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <p class="recipe-detail-review-self-header">Your Review</p>
                        <textarea name="txtReview" id="" cols="1" rows="5" class="recipe-detail-review-self-review"
                                  ><%= userDisplayReview.getReviewContent()%></textarea>
                    </div>
                </div>
                <div class="recipe-detail-review-self-button" >
                    <button name="action" value="editFeedback" id="editButton" type="submit">EDIT</button>
                    <span></span>
                    <button name="action" value="deleteFeedBack" id="deleteButton" type="submit">DELETE</button>
                </div>
            </form>

            <%
                //Only active scroll whenever needed.
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
            } else {
            %>
            <header class="recipe-detail-review-main-header">
                REVIEWS
            </header>
            <form class="recipe-detail-review-self" id="ratingForm" action="UserController" method="post">
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
                }

            } else {%>
            <header class="recipe-detail-review-main-header">
                REVIEWS
            </header>
            <p class="recipe-detail-review-link">You must <a href="login.jsp?recipeID=1">login</a> to review</p>
            <% }%>
            <div class="recipe-detail-review-others">

                <%
                    ArrayList<DisplayReviewDTO> displayReviewList = (ArrayList<DisplayReviewDTO> ) request.getAttribute("displayReviewList");

                    if (displayReviewList.size() > 0 && displayReviewList != null) {
                        for (DisplayReviewDTO o : displayReviewList) {
                %>
                <div class="recipe-detail-review-others-info">
                    <a href="LoadPublicProfileServlet?accountName=<%= o.getReviewOwner().getUserName()%>"> 
                        <img src="ServletImageLoader?identifier=<%= o.getReviewOwner().getAvatar()%>" alt="">
                    </a>
                    <div class="recipe-detail-review-others-info-content">
                        <a href="LoadPublicProfileServlet?accountName=<%= o.getReviewOwner().getUserName()%>">
                            <%= o.getReviewOwner().getUserName()%>
                        </a>
                        <div class="recipe-detail-review-others-info-review">
                            <%
                                for (int i = 0; i < o.getReviewRating(); i++) {
                            %>
                            <img src="./assets/full-star-icon.svg" alt="">
                            <%
                                }
                            %>
                            <div><%if (o.getUpdate_at() != null) {
                                %>Update at <%=o.getUpdate_at()%>
                                <% } else {%>
                                <%=o.getCreate_at()%>
                                <% }%>
                            </div>
                        </div>
                        <p>
                            <%= o.getReviewContent()%>
                        </p>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>


        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
