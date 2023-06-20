<%-- Document : showRecipeDetail Created on : Jun 10, 2023, 9:04:47 AM Author : Admin --%>

    <%@page import="User.UserDTO" %>
        <%@page import="Direction.DirectionDAO" %>
            <%@page import="Recipe.RecipeDAO" %>
                <%@page import="Direction.DirectionDTO" %>
                    <%@page import="User.UserDAO" %>
                        <%@page import="Recipe.RecipeDTO" %>
                            <%@page import="Review.ReviewDTO" %>
                                <%@page import="IngredientDetail.IngredientDetailDTO" %>
                                    <%@page import="java.util.ArrayList" %>
                                        <%@page contentType="text/html" pageEncoding="UTF-8" %>
                                            <!DOCTYPE html>
                                            <html>

                                            <head>
                                                <title>Delideli</title>
                                                <meta charset="utf-8">
                                                <meta name="viewport" content="width=device-width, initial-scale=1">
                                                <!--      Bootstrap         -->
                                                <link
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
                                                    rel="stylesheet"
                                                    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
                                                    crossorigin="anonymous">
                                                <!--      CSS         -->
                                                <link rel="stylesheet" href="./styles/userStyle.css">
                                                <link rel="stylesheet" href="./styles/adminStyle.css">
                                                <link rel="preconnect" href="https://fonts.googleapis.com">
                                                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                                                <link
                                                    href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
                                                    rel="stylesheet">
                                            </head>

                                            <body>

                                                <div class="container-fluid">

                                                    <% ArrayList<IngredientDetailDTO> ingredientDetailList = (ArrayList)
                                                        request.getAttribute("ingredientDetailList");
                                                        ArrayList<ReviewDTO> reviewList = (ArrayList)
                                                            request.getAttribute("reviewList");
                                                            RecipeDTO recipe = (RecipeDTO)
                                                            request.getAttribute("recipe");
                                                            int ownerId = recipe.getUser_id();
                                                            UserDTO owner = UserDAO.getUserByUserId(ownerId);
                                                            String link = "userCommunityProfile.jsp?accountName=" +
                                                            owner.getUserName();
                                                            %>

                                                            <div class="row">
                                                                <nav class="nav-left-bar col-md-2">
                                                                    <a class="logo" href="">
                                                                        <img src="assets/Logo3.svg" alt="">
                                                                    </a>
                                                                    <div>
                                                                        <a href="admin.jsp">
                                                                            <img src="./assets/public.svg" alt="">
                                                                            Dashboard
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="MainController?action=manageAccount">
                                                                            <img src="./assets/user-unchose.svg" alt="">
                                                                            User
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="MainController?action=manageRecipe"
                                                                            class="active">
                                                                            <img src="./assets/post-unchose.svg" alt="">
                                                                            Posts
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="#">
                                                                            <img src="./assets/content-unchose.svg"
                                                                                alt="">
                                                                            Content
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="MainController?action=manageNews">
                                                                            <img src="./assets/news-unchose.svg" alt="">
                                                                            News
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="#">
                                                                            <img src="./assets/policies-unchose.svg"
                                                                                alt="">
                                                                            Policies
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="#">
                                                                            <img src="./assets/broadcast-unchose.svg"
                                                                                alt="">
                                                                            Broadcast
                                                                        </a>
                                                                    </div>
                                                                    <div>
                                                                        <a href="#">
                                                                            <img src="./assets/bug-report-unchose.svg"
                                                                                alt="">
                                                                            Report
                                                                        </a>
                                                                    </div>


                                                                </nav>

                                                                <div class="col-md-10 recipe-detail-admin">
                                                                    <% UserDTO user=(UserDTO)
                                                                        session.getAttribute("user"); if (user==null ||
                                                                        user.getRole() !=2) {
                                                                        response.sendRedirect("error.jsp"); } else { %>
                                                                        <nav class="navbar">
                                                                            <div class="nav-top-bar">
                                                                                <div
                                                                                    class="nav-top-bar-account dropdown">
                                                                                    <img src="./assets/profile-pic.svg"
                                                                                        alt="">
                                                                                    <div>
                                                                                        <p>
                                                                                            <%= user.getUserName()%>
                                                                                        </p>
                                                                                        <p>Admin</p>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </nav>

                                                                        <% } %>

                                                                            <div class="container ">
                                                                                <div class="row recipe-detail-info">
                                                                                    <header
                                                                                        class="recipe-detail-info-main-header">
                                                                                        <%= recipe.getTitle()%>
                                                                                    </header>
                                                                                    <div
                                                                                        class="recipe-detail-info-user">
                                                                                        <a href="<%=link%>"><img
                                                                                                src="./assets/profile-pic.svg"
                                                                                                alt=""></a>
                                                                                        <div>
                                                                                            <span>By</span>
                                                                                            <span><a href="<%=link%>">
                                                                                                    <%=
                                                                                                        request.getAttribute("owner")%>
                                                                                                </a></span>
                                                                                            <p>Published on <%=
                                                                                                    recipe.getCreate_at()%>
                                                                                            </p>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div
                                                                                        class="recipe-detail-info-interaction">
                                                                                        <div
                                                                                            class="recipe-detail-info-review">
                                                                                            <% double avaRating=(Double)
                                                                                                request.getAttribute("avgRating");
                                                                                                for (double i=0; i <
                                                                                                avaRating; i++) { %>
                                                                                                <img src="./assets/full-star.png"
                                                                                                    alt="">
                                                                                                <% } %>
                                                                                                    <p>
                                                                                                        <%=
                                                                                                            request.getAttribute("avgRating")%>
                                                                                                    </p>
                                                                                                    <!--<p>|</p>-->
                                                                                                    <!--<p class=""><%= request.getAttribute("totalReview")%> ratings</p>-->
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="recipe-detail-main-pic">
                                                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>"
                                                                                            alt="">
                                                                                    </div>
                                                                                    <div
                                                                                        class="recipe-detail-info-overview">
                                                                                        <div
                                                                                            class="recipe-detail-info-overview-content">
                                                                                            <div
                                                                                                class="recipe-detail-info-header">
                                                                                                <%= recipe.getTitle()%>
                                                                                            </div>
                                                                                            <div
                                                                                                class="row recipe-detail-info-overview-content-info">
                                                                                                <div class="col-md-3">
                                                                                                    <p>Prep time:</p>
                                                                                                    <% if
                                                                                                        (recipe.getPrep_time()>
                                                                                                        60) {
                                                                                                        %>
                                                                                                        <p>
                                                                                                            <%= recipe.getPrep_time()
                                                                                                                / 60%>
                                                                                                                hr(s)
                                                                                                                <%= recipe.getPrep_time()
                                                                                                                    %
                                                                                                                    60%>
                                                                                                                    min(s)
                                                                                                        </p>
                                                                                                        <% } else { %>
                                                                                                            <p>
                                                                                                                <%=
                                                                                                                    recipe.getPrep_time()%>
                                                                                                                    min(s)
                                                                                                            </p>
                                                                                                            <% }%>
                                                                                                </div>
                                                                                                <div class="col-md-3">
                                                                                                    <p>Cook time:</p>
                                                                                                    <% if
                                                                                                        (recipe.getCook_time()>
                                                                                                        60) {
                                                                                                        %>
                                                                                                        <p>
                                                                                                            <%= recipe.getCook_time()
                                                                                                                / 60%>
                                                                                                                hr(s)
                                                                                                                <%= recipe.getCook_time()
                                                                                                                    %
                                                                                                                    60%>
                                                                                                                    min(s)
                                                                                                        </p>
                                                                                                        <% } else { %>
                                                                                                            <p>
                                                                                                                <%=
                                                                                                                    recipe.getCook_time()%>
                                                                                                                    min(s)
                                                                                                            </p>
                                                                                                            <% }%>
                                                                                                </div>
                                                                                                <div class="col-md-3">
                                                                                                    <p>Total time:</p>
                                                                                                    <% if
                                                                                                        ((recipe.getPrep_time()
                                                                                                        +
                                                                                                        recipe.getCook_time())>
                                                                                                        60) {
                                                                                                        %>
                                                                                                        <p>
                                                                                                            <%= (recipe.getPrep_time()
                                                                                                                +
                                                                                                                recipe.getCook_time())
                                                                                                                / 60%>
                                                                                                                hr(s)
                                                                                                                <%= (recipe.getPrep_time()
                                                                                                                    +
                                                                                                                    recipe.getCook_time())
                                                                                                                    %
                                                                                                                    60%>
                                                                                                                    min(s)
                                                                                                        </p>
                                                                                                        <% } else { %>
                                                                                                            <p>
                                                                                                                <%= (recipe.getPrep_time()
                                                                                                                    +
                                                                                                                    recipe.getCook_time())%>
                                                                                                                    min(s)
                                                                                                            </p>
                                                                                                            <% }%>
                                                                                                </div>
                                                                                                <div class="col-md-3">
                                                                                                    <p>Serving:</p>
                                                                                                    <p>
                                                                                                        <%=
                                                                                                            recipe.getServings()%>
                                                                                                    </p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div
                                                                                        class="recipe-detail-info-ingredients">
                                                                                        <div
                                                                                            class="recipe-detail-info-header">
                                                                                            Description
                                                                                        </div>
                                                                                        <p>
                                                                                            <%=
                                                                                                recipe.getDescription()%>
                                                                                        </p>
                                                                                    </div>

                                                                                    <div
                                                                                        class="recipe-detail-info-ingredients">
                                                                                        <div
                                                                                            class="recipe-detail-info-header">
                                                                                            Ingredients
                                                                                        </div>
                                                                                        <ul>
                                                                                            <% if
                                                                                                (ingredientDetailList.size()>
                                                                                                0 &&
                                                                                                ingredientDetailList !=
                                                                                                null) {
                                                                                                for (IngredientDetailDTO
                                                                                                o :
                                                                                                ingredientDetailList) {
                                                                                                %>
                                                                                                <li>
                                                                                                    <%= o.getDesc()%>
                                                                                                </li>
                                                                                                <% } } %>
                                                                                        </ul>
                                                                                    </div>
                                                                                    <div
                                                                                        class="recipe-detail-info-direction">
                                                                                        <div
                                                                                            class="recipe-detail-info-header">
                                                                                            Directions
                                                                                        </div>
                                                                                        <div>
                                                                                            <% DirectionDTO
                                                                                                direction=DirectionDAO.getDirectionByRecipeId(recipe.getId());
                                                                                                %>

                                                                                                <p
                                                                                                    class="recipe-detail-info-direction-header">
                                                                                                    <%=
                                                                                                        direction.getDesc()%>
                                                                                                </p>


                                                                                        </div>
                                                                                    </div>
                                                                                    <% try { String
                                                                                        path=RecipeDAO.getImageByRecipeId(recipe.getId()).getImgPath();
                                                                                        %>
                                                                                        <div
                                                                                            class="recipe-detail-secondary-pic">
                                                                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getImageByRecipeId(recipe.getId()).getImgPath()%>"
                                                                                                alt="">
                                                                                        </div>
                                                                                        <% } catch (Exception e) { }%>

                                                                                            <div
                                                                                                class="recipe-detail-admin-action">
                                                                                                <form
                                                                                                    action="MainController"
                                                                                                    method="post"
                                                                                                    class="recipe-table-button">
                                                                                                    <input type="hidden"
                                                                                                        value="<%= recipe.getId()%>"
                                                                                                        name="recipeId">
                                                                                                    <input type="hidden"
                                                                                                        name="admin"
                                                                                                        value="admin">
                                                                                                    <!--<button type="submit" value="showRecipeDetail" name="action">Show</button>-->
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        value="deleteRecipe"
                                                                                                        name="action"
                                                                                                        class="recipe-table-button-delete">Delete</button>
                                                                                                    <% if
                                                                                                        (recipe.getStatus()==2)
                                                                                                        { %>
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            value="confirmRecipe"
                                                                                                            name="action">Confirm</button>
                                                                                                        <% } %>
                                                                                                </form>
                                                                                            </div>
                                                                                </div>
                                                                            </div>
                                                                </div>
                                                            </div>
                                                </div>
                                            </body>

                                            </html>