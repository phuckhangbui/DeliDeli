<%-- Document : showRecipeDetail Created on : Jun 10, 2023, 9:04:47 AM Author : Admin --%>

<%@page import="DAO.UserDAO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DAO.DirectionDAO"%>
<%@page import="DTO.DirectionDTO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="DTO.NutritionDTO"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="DTO.IngredientDetailDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
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
        <link rel="stylesheet" href="./styles/adminStyle.css">
        <link rel="stylesheet" href="./styles/notificationStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>
    <body>

        <div class="container-fluid">

            <%
                ArrayList<IngredientDetailDTO> ingredientDetailList = (ArrayList) request.getAttribute("ingredientDetailList");
                ArrayList<ReviewDTO> reviewList = (ArrayList) request.getAttribute("reviewList");
                NutritionDTO nutrition = (NutritionDTO) request.getAttribute("nutrition");
                RecipeDTO recipe = (RecipeDTO) request.getAttribute("recipe");
                int ownerId = recipe.getUser_id();
                UserDTO owner = UserDAO.getUserByUserId(ownerId);
                String link = "userCommunityProfile.jsp?accountName=" + owner.getUserName();
            %>

            <div class="row">
                <%
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if (user == null || user.getRole() == 1) {
                        response.sendRedirect("error.jsp");
                    } else if (user.getRole() == 2) {
                %>

                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="admin.jsp" >
                            <img src="./assets/public-unchosen-icon.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageAccount" >
                            <img src="./assets/user-unchosen-icon.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageRecipe" class="active">
                            <img src="./assets/post-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion">
                            <img src="./assets/content-unchosen-icon.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageNews">
                            <img src="./assets/news-unchosen-icon.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/policies-unchosen-icon.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/bug-report-unchosen-icon.svg" alt="">
                            Report
                        </a>
                    </div>
                </nav>

                <div class="col-md-10 recipe">

                    <nav class="navbar">
                        <div class="nav-top-bar">
                            <div class="nav-top-bar-account dropdown">
                                <img src="./assets/profile-pic.svg" alt="">
                                <div>
                                    <p><%= user.getUserName()%></p>
                                    <p>Admin</p>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <%
                    } else if (user.getRole() == 3) {
                    %>
                    <nav class="nav-left-bar col-md-2">
                        <a class="logo" href="">
                            <img src="assets/Logo3.svg" alt="">
                        </a>
                        <!--                        <div>
                                                    <a href="admin.jsp">
                                                        <img src="./assets/public-unchose.svg" alt="">
                                                        Dashboard
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="AdminController?action=manageAccount">
                                <img src="./assets/user-unchose.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageRecipe" class="active">
                                <img src="./assets/post-unchose.svg" alt="">
                                Posts
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion">
                                <img src="./assets/content-unchose.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageNews">
                                <img src="./assets/news.svg" alt="">
                                News
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/policies-unchose.svg" alt="">
                                                        Policies
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="#">
                                <img src="./assets/broadcast-unchose.svg" alt="">
                                Broadcast
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/bug-report-unchose.svg" alt="">
                                                        Report
                                                    </a>
                                                </div>-->
                    </nav>

                    <div class="col-md-10 recipe">
                        <nav class="navbar">
                            <div class="nav-top-bar">
                                <div class="nav-top-bar-account dropdown">
                                    <img src="./assets/profile-pic.svg" alt="">
                                    <div>
                                        <p><%= user.getUserName()%></p>
                                        <p>Moderator</p>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <%
                            }
                        %>

                        <div class="container ">

                            <div class="row recipe-detail-info">
                                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="AdminController?action=manageRecipe">Recipes List</a></li>
                                        <li class="breadcrumb-item current-link" aria-current="page"><%= recipe.getTitle()%></li>
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
                                            <%
                                                Timestamp timestamp = null;
                                                if (recipe.getUpdate_at() == null) {
                                                    timestamp = recipe.getCreate_at();
                                                } else {
                                                    timestamp = recipe.getUpdate_at();
                                                }
                                                SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                String date = dateFormat.format(timestamp);
                                            %>
                                        <p>Published on <%= date%></p>
                                    </div>
                                </div>
                                <div class="recipe-detail-info-interaction">
                                    <div class="recipe-detail-info-review">
                                        <%
                                            double avaRating = (Double) request.getAttribute("avgRating");
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
                                        <p><%= request.getAttribute("avgRating")%></p>
                                        <!--<p>|</p>-->
                                        <!--<p class=""><%= request.getAttribute("totalReview")%> ratings</p>-->
                                    </div>
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

                                            <!-- Nutrition Content-->
                                            <div class="col-md-3">
                                                <p>Calories</p>
                                                <p><%= nutrition.getCalories()%></p>
                                            </div>
                                            <div class="col-md-3">
                                                <p>Fat:</p>
                                                <p><%= nutrition.getFat()%> gram(s)</p>
                                            </div>
                                            <div class="col-md-3">
                                                <p>Carbs: </p>
                                                <p><%= nutrition.getCarbs()%> gram(s)</p>
                                            </div>
                                            <div class="col-md-3">
                                                <p>Protein:</p>
                                                <p><%= nutrition.getProtein()%> gram(s)</p>
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

                                <div class="recipe-detail-admin-action">
                                    <form action="AdminController" method="post" class="recipe-table-button">
                                        <input type="hidden" value="<%= recipe.getId()%>" name="recipeId">
                                        <input type="text" name="userId" value="<%= ownerId%>" hidden>
                                        <input type="hidden" name="admin" value="admin">
                                        <button type="button" value="rejectRecipe" name="action" class="recipe-table-button-delete btn-disapprove" data-bs-toggle="modal" data-bs-target="#disapprove">Reject</button>
                                        <%
                                            if (recipe.getStatus() == 2) {
                                        %>
                                        <button type="submit" value="confirmRecipe" name="action">Confirm</button>
                                        <%
                                            }
                                        %> 
                                    </form>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="disapprove" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                 aria-labelledby="deletePlanModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form action="AdminController" method="post"class="modal-content modal-content-self">
                        <div class="modal-header form-header">
                            <div class="form-title disapprove-style" id="exampleModalLabel">
                                Reject Recipe
                            </div>
                        </div>
                        <div class="modal-body">

                            <p class="title-text">Message Title:<br><input type="text" class="title" maxlength="100" name="txtTitle">
                            </p>
                            <p>Message body: </p>
                            <textarea rows="4" class="form-body-content" name="txtDesc">
                            </textarea>
                            <!-- Here to store hidden input base on the type of the notification-->
                            <!-- Should always have userId, except system notification-->
                            <input type="text" name="userId" value="<%= ownerId%>" hidden>
                            <input type="text" name="notificationType" value="1" hidden>
                            <!-- For example, when accept or reject a recipe, pass recipeId here-->
                            <input type="text" name="recipeId" value="<%= recipe.getId()%>" hidden>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger" data-bs-dismiss="modal" name="action"
                                    value="rejectRecipe">Reject</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
