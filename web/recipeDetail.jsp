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
            ArrayList<IngredientDetailDTO> ingredientDetailList = (ArrayList) request.getAttribute("ingredientDetailList");
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
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#"> Recipe Type</a></li> 
                            <li class="breadcrumb-item current-link" aria-current="page">Recipe Name</li>
                        </ol>
                    </nav>
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
                            <img src="./assets/full-star-icon.svg" alt="">
                            <%
                                }
                            %>
                            <p><%= request.getAttribute("avgRating")%></p>
                            <p>|</p>
                            <p class=""><%= request.getAttribute("totalReview")%> rating(s)</p>
                        </div>
                        <form action="" class="recipe-detail-info-button-add">
                            <input type="text" hidden="">
                            <div>

                                <button type="submit" class="like-button">
                                    <img src="./assets/favorite-icon.svg" alt="">
                                    Save
                                </button>
                            </div>
                        </form>
                        <button class="share-button">
                            <img src="./assets/share-icon.svg" alt="">
                            Share
                        </button>
                    </div>
                    <div class="recipe-detail-main-pic">
                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
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
                            Description
                        </div>
                        <p>
                            <%= recipe.getDescription()%>
                        </p>
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
                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getImageByRecipeId(recipe.getId()).getImgPath()%>" alt="">
                    </div>
                    <% } catch (Exception e) {

                        }%>
                </div>

                <%@include file="reviewSection.jsp" %>
            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
