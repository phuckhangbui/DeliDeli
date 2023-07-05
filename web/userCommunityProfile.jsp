<%-- 
    Document   : userCommunityProfile
    Created on : Jun 2, 2023, 4:27:26 AM
    Author     : khang
--%>

<%@page import="DTO.DisplayReviewDTO"%>
<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.FavoriteDAO"%>
<%@page import="DAO.ReviewDAO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.UserDetailDTO"%>
<%@page import="DAO.UserDetailDAO"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="DTO.FavoriteDTO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.UserDAO"%>
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

        <%
            UserDTO account = (UserDTO) request.getAttribute("account");
            UserDetailDTO accountDetail = (UserDetailDTO) request.getAttribute("accountDetail");
            ArrayList<DisplayRecipeDTO> accountPublicRecipe = (ArrayList<DisplayRecipeDTO>) request.getAttribute("accountPublicRecipe");
            ArrayList<DisplayRecipeDTO> favoriteList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("favoriteList");
            ArrayList<DisplayReviewDTO> reviewList = (ArrayList<DisplayReviewDTO>) request.getAttribute("reviewList");
            String fullname = accountDetail.getFirstName() + " " + accountDetail.getLastName();
        %>
        <%@include file="header.jsp" %>



        <!--        User Community Profile        -->
        <div class="blank-background">
            <div class="container ">
                <div class="row user-community-profile">
                    <div class="col-md-3 user-community-profile-avatar">
                        <div>
                            <img src="ServletImageLoader?identifier=<%= user.getAvatar()%>" alt="">
                        </div>
                        <div>
                            <p><%=account.getUserName()%></p>
                        </div>
                    </div>
                    <div class="col-md-7 user-community-profile-bio">
                        <div class="row">
                            <div class="col-md-6">
                                <p>NAME</p>
                                <%
                                    if (fullname != null) {
                                %> 
                                <p><%=fullname%></p>
                                <%
                                } else {
                                %>
                                <p class="unspecified">Unspecified</p>
                                <%
                                    }
                                %>

                            </div>
                            <div class="col-md-6">
                                <p>BIRTHDATE</p>
                                <%
                                    if (accountDetail.getBirthdate() != null) {
                                %> 

                                <p><%= accountDetail.getBirthdate()%></p>
                                <%
                                } else {
                                %>
                                <p class="unspecified">Unspecified</p>
                                <%
                                    }
                                %>

                            </div>
                            <div class="col-md-12">
                                <p>SPECIALTIES</p>

                                <%
                                    if (accountDetail.getSpecialty().equals("")) { %>
                                <p class="unspecified">Unspecified</p>
                                <%
                                } else {
                                %>
                                <p><%= accountDetail.getSpecialty()%></p> 
                                <%}%>
                            </div>
                            <div class="col-md-12">
                                <p>ABOUT</p>
                                <%
                                    if (accountDetail.getBio().equals("")) { %>
                                <p class="unspecified">Unspecified</p>
                                <%
                                } else {
                                %>
                                <p><%= accountDetail.getBio()%></p> 
                                <%}%>

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
                    <div class="row user-community-favorite-recipe" id="favoriteRecipe">
                        <%
                            int count = 0;
                            for (DisplayRecipeDTO r : favoriteList) {
                                count++;
                                if (count < 4) {
                        %>
                        <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>" class="col-md-4 recommendation-content-post">
                            <div class="recommendation-content-picture">
                                <img src="<%= r.getThumbnailPath()%>" alt="">
                            </div>
                            <div>
                                <p><%= r.getCategory()%></p>
                                <p><%= r.getTitle()%></p>
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
                                <p class="recommendation-content-reciew-rating">
                                    <%= r.getRating()%>
                                </p>
                            </div>
                        </a>

                        <%}
                            }
                            if (count > 3) {
                        %>

                        <div class="user-community-recipe-button">
                            <button id="toggleButtonFavorite" onclick="toggleExpandCollapseFavorite()" class="col-md-12">
                                <a href="javascript:void(0)">SHOW MORE</a>
                            </button>
                        </div>

                        <% } %>



                    </div>
                    <script>
                        function toggleExpandCollapseFavorite() {
                            var container = document.getElementById("favoriteRecipe");
                            var hiddenElements = container.querySelectorAll(".hidden");
                            var toggleButton = document.getElementById("toggleButtonFavorite");

                            if (hiddenElements.length > 0) {
                                hiddenElements.forEach(element => {
                                    element.classList.remove("hidden");
                                    element.style.opacity = "0";
                                });

                                setTimeout(function () {
                                    container.style.height = container.scrollHeight + "px";
                                    hiddenElements.forEach(element => {
                                        element.style.opacity = "1";
                                    });
                                }, 10);

                                setTimeout(function () {
                                    container.style.height = "auto";
                                    container.style.overflow = "";
                                }, 300);

                                toggleButton.querySelector("a").textContent = "SHOW LESS";
                            } else {
                                container.style.height = container.offsetHeight + "px";
                                container.style.overflow = "hidden";




                                var defaultElements = document.querySelectorAll("#favoriteRecipe > a:not(.hidden)");
                                setTimeout(function () {
                                    defaultElements.forEach((element, index) => {
                                        if (index >= 3) {
                                            element.classList.add("hidden");
                                        }
                                    });
                                }, 300);


                                toggleButton.querySelector("a").textContent = "SHOW MORE";
                                setTimeout(function () {
                                    container.style.height = "auto";
                                    container.style.overflow = "";
                                }, 300);

                            }
                        }


                    </script>
                </div>

                <!--        User Community Own Recipe       -->
                <div class="container user-community-recipe">
                    <div class="row ">
                        <header class="user-community-recipe-header">
                            <p>User Own Recipes</p>
                        </header>
                    </div>
                    <div class="row user-community-own-recipe" id="ownRecipe">
                        <% int count1 = 0;
                            for (DisplayRecipeDTO r : accountPublicRecipe) {
                                count++;
                                if (count < 4) {
                        %>
                        <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>" class="col-md-4 recommendation-content-post">
                            <div class="recommendation-content-picture">
                                <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath()%>" alt="">
                            </div>
                            <div>
                                <p><%= r.getCategory()%></p>
                                <p><%= r.getTitle()%></p>
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
                        </a>
                        <%       } else {%>
                        <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>" class="col-md-4 recommendation-content-post hidden">
                            <div class="search-result-content-picture">
                                <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath()%>" alt="">
                            </div>
                            <div>
                                <p><%= r.getCategory()%></p>
                                <p><%= r.getTitle()%></p>
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
                        </a>

                        <%}
                            }
                            if (count > 3) {
                        %>

                        <div class="user-community-recipe-button">
                            <button id="toggleButtonOwn" onclick="toggleExpandCollapseOwn()" class="col-md-12">
                                <a href="javascript:void(0)">SHOW MORE</a>
                            </button>
                        </div>
                        <% } %>
                    </div>
                </div>

                <script>
                    function toggleExpandCollapseOwn() {
                        var container = document.getElementById("ownRecipe");
                        var hiddenElements = container.querySelectorAll(".hidden");
                        var toggleButton = document.getElementById("toggleButtonOwn");

                        if (hiddenElements.length > 0) {
                            hiddenElements.forEach(element => {
                                element.classList.remove("hidden");
                                element.style.opacity = "0";
                            });

                            setTimeout(function () {
                                container.style.height = container.scrollHeight + "px";
                                hiddenElements.forEach(element => {
                                    element.style.opacity = "1";
                                });
                            }, 10);

                            setTimeout(function () {
                                container.style.height = "auto";
                                container.style.overflow = "";
                            }, 300);

                            toggleButton.querySelector("a").textContent = "SHOW LESS";
                        } else {
                            container.style.height = container.offsetHeight + "px";
                            container.style.overflow = "hidden";




                            var defaultElements = document.querySelectorAll("#ownRecipe > a:not(.hidden)");
                            setTimeout(function () {
                                defaultElements.forEach((element, index) => {
                                    if (index >= 3) {
                                        element.classList.add("hidden");
                                    }
                                });
                            }, 300);


                            toggleButton.querySelector("a").textContent = "SHOW MORE";
                            setTimeout(function () {
                                container.style.height = "auto";
                                container.style.overflow = "";
                            }, 300);

                        }
                    }


                </script>            

                <style>
                    .hidden {
                        display: none;
                    }

                </style>

                <div class="row user-community-favorite-recipe">

                </div>
                <div class="row ">

                </div>





                <!--        User Community Own Reviews       -->
                <div class="container user-community-recipe">
                    <div class="row ">
                        <header class="user-community-recipe-header">
                            <p>Recipes Reviews</p>
                        </header>
                    </div>
                    <div class="row user-community-recipe-review" id="review">
                        <% int count2 = 0;
                            for (DisplayReviewDTO review : reviewList) {
                                count1++;
                                if (count1 < 5) {
                        %>
                        <a href="MainController?action=getRecipeDetailById&id=<%= review.getRecipeId()%>&activeScroll=true" class="col-md-3 user-community-recipe-review-card">
                            <div class="user-community-recipe-review-card-picture">
                                <img src="ServletImageLoader?identifier=<%= review.getThumbnailPath()%>" alt="">
                            </div>
                            <div class="user-community-recipe-review-card-title">
                                <p><%= review.getRecipeTitle()%></p>
                            </div>
                            <div class="recommendation-content-reciew">
                                <%
                                    int fullStars = review.getReviewRating();
                                    for (int i = 0; i < fullStars; i++) {
                                %>
                                <img src="./assets/full-star-icon.svg" alt="">
                                <%
                                    }
                                    int remainingStars = 5 - fullStars;

                                    for (int i = 0; i < remainingStars; i++) {
                                %>
                                <img src="./assets/empty-star-icon.svg" alt="">
                                <%
                                    }
                                %>


                            </div>
                            <div class="user-community-recipe-review-card-content">
                                <p><%=review.getReviewContent()%></p>
                            </div>
                        </a>
                        <%
                        } else {%>

                        <a href="MainController?action=getRecipeDetailById&id=<%= review.getRecipeId()%>&activeScroll=true" class="col-md-3 user-community-recipe-review-card hidden">
                            <div class="user-community-recipe-review-card-picture">
                                <img src="ServletImageLoader?identifier=<%= review.getThumbnailPath()%>" alt="">
                            </div>
                            <div class="user-community-recipe-review-card-title">
                                <p><%= review.getRecipeTitle()%></p>
                            </div>
                            <div class="recommendation-content-reciew">
                                <%
                                    int fullStars = review.getReviewRating();
                                    for (int i = 0; i < fullStars; i++) {
                                %>
                                <img src="./assets/full-star-icon.svg" alt="">
                                <%
                                    }
                                    int remainingStars = 5 - fullStars;

                                    for (int i = 0; i < remainingStars; i++) {
                                %>
                                <img src="./assets/empty-star-icon.svg" alt="">
                                <%
                                    }
                                %>
                            </div>
                            <div class="user-community-recipe-review-card-content">
                                <p><%=review.getReviewContent()%></p>
                            </div>
                        </a>
                        <% }
                            }
                            if (count1 > 4) {%>
                        <div class="user-community-recipe-button">
                            <button id="toggleButtonReview" onclick="toggleExpandCollapseReview()" class="col-md-12">
                                <a href="javascript:void(0)">SHOW MORE</a>
                            </button>
                        </div>
                        <% }%>

                    </div>
                </div>

                <script>
                    function toggleExpandCollapseReview() {
                        var container = document.getElementById("review");
                        var hiddenElements = container.querySelectorAll(".hidden");
                        var toggleButton = document.getElementById("toggleButtonReview");

                        if (hiddenElements.length > 0) {
                            hiddenElements.forEach(element => {
                                element.classList.remove("hidden");
                                element.style.opacity = "0";
                            });

                            setTimeout(function () {
                                container.style.height = container.scrollHeight + "px";
                                hiddenElements.forEach(element => {
                                    element.style.opacity = "1";
                                });
                            }, 10);

                            setTimeout(function () {
                                container.style.height = "auto";
                                container.style.overflow = "";
                            }, 300);

                            toggleButton.querySelector("a").textContent = "SHOW LESS";
                        } else {
                            container.style.height = container.offsetHeight + "px";
                            container.style.overflow = "hidden";




                            var defaultElements = document.querySelectorAll("#review > a:not(.hidden)");
                            setTimeout(function () {
                                defaultElements.forEach((element, index) => {
                                    if (index >= 4) {
                                        element.classList.add("hidden");
                                    }
                                });
                            }, 300);


                            toggleButton.querySelector("a").textContent = "SHOW MORE";
                            setTimeout(function () {
                                container.style.height = "auto";
                                container.style.overflow = "";
                            }, 300);

                        }
                    }



                </script>


            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
