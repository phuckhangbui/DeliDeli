<%-- Document : home Created on : May 23, 2023, 8:09:36 AM Author : Admin --%>
<%@page import="Utils.NavigationBarUtils" %>
<%@page import="java.time.LocalTime" %>
<%@page import="Suggestion.SuggestionDAO" %>
<%@page import="RecipeImage.RecipeImageDAO" %>
<%@page import="User.UserDTO" %>
<%@page import="Recipe.RecipeDAO" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Recipe.RecipeDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <!--         The banner       -->
        <%@include file="banner.jsp" %>

        <!--         The news section      -->
        <div class="new">
            <div class="container">
                <div class="row">
                    <header>
                        <a href="" class="header">
                            <p>What's New</p>
                            <img src="./assets/arrow.svg" alt="">
                        </a>
                    </header>
                </div>
                <div class="row">
                    <a href="" class="col-md-8 first-new ">
                        <img src="./pictures/gorden.jpg" alt="">
                        <p>Gordon Ramsey's recipes that can help you lose
                            weight
                            effectively</p>
                    </a>
                    <div class="col-md-4 other-news">
                        <a href="" class="second-new">
                            <img src="./pictures/banana.jpg" alt="">
                            <p>6 nutritional benefits that bananas can give
                                you</p>
                        </a>
                        <a href="" class="third-new">
                            <img src="./pictures/fried-food.png" alt="">
                            <p>Fried foods: To eat or not to eat</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>





        <!--         Recommendation 1       -->
        <div class="recommendation-1">
            <div class="container ">
                <div class="row">
                    <header class="search-result-header">
                        <p>Mr. Worldwide</p>
                    </header>
                </div>
                <div class="row recommendation-content">
                    <% ArrayList<RecipeDTO> listRecipe
                                = RecipeDAO.getAllRecipes();
                        if (listRecipe != null && listRecipe.size() != 0) {
                            for (RecipeDTO r : listRecipe) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">

                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath()%>"
                                 alt="">
                        </div>
                        <div>
                            <p>
                                <%=RecipeDAO.getCategoryByRecipeId(r.getId())%>
                            </p>
                            <p>
                                <%= r.getTitle()%>
                            </p>
                        </div>
                        <div class="recommendation-content-reciew">
                            <% for (int i = 0; i
                                        < RecipeDAO.getRatingByRecipeId(r.getId());
                                        i++) { %>
                                        <img src="./assets/full-star-icon.svg"
                                 alt="">
                            <% }%>
                            <p
                                class="recommendation-content-reciew-rating">
                                <%=RecipeDAO.getRatingByRecipeId(r.getId())%>
                            </p>
                        </div>
                    </a>
                    <% }
                        } %>
                </div>
            </div>
        </div>


        <!--         Recommendation 2       -->
        <div class="recommendation-2">
            <div class="container">
                <div class="row">
                    <% LocalTime currentTime = LocalTime.now();
                        String time = "";
                        System.out.println("Current Time: " + currentTime);

                        ArrayList<RecipeDTO> recommendList = null;
                        //Time define
                        LocalTime MorningStartTime = LocalTime.of(6, 0);
                        LocalTime AfternoonStartTime = LocalTime.of(12, 0);
                        LocalTime EveningStartTime = LocalTime.of(17, 0);
                        LocalTime NightStartTime = LocalTime.of(20, 0);

                        if (currentTime.isAfter(MorningStartTime) && currentTime.isBefore(AfternoonStartTime)) {
                            recommendList = NavigationBarUtils.searchRecipes(" Breakfast", "Category");
                            time = "breakfast";
                        } else if (currentTime.isAfter(AfternoonStartTime)
                                && currentTime.isBefore(EveningStartTime)) {
                            recommendList = NavigationBarUtils.searchRecipes("Snack", "Category"
                            );
                            time = "lunch";
                        } else if (currentTime.isAfter(EveningStartTime)
                                && currentTime.isBefore(NightStartTime)) {
                            recommendList = NavigationBarUtils.searchRecipes("Dinner", "Category"
                            );
                            time = "dinner";
                        } else if (currentTime.isAfter(NightStartTime)
                                || currentTime.isBefore(MorningStartTime)) {
                            recommendList = NavigationBarUtils.searchRecipes("Snack", "Category"
                            );
                            time = "midnight snacks";
                        }%>
                    <header class="search-result-header">
                        <p>What's for <%= time%> today? </p>
                    </header>
                </div>
                <div class="row recommendation-content">
                    <% if (recommendList != null && recommendList.size() != 0) {
                            for (RecipeDTO list : recommendList) {%>
                    <a href=""
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">
                            <img src="<%= RecipeDAO.getThumbnailByRecipeId(list.getId()).getThumbnailPath()%>"
                                 alt="">
                        </div>
                        <div>
                            <p>
                                <%=RecipeDAO.getCategoryByRecipeId(list.getId())%>
                            </p>
                            <p>
                                <%= list.getTitle()%>
                            </p>
                        </div>
                        <div class="recommendation-content-reciew">
                            <% for (int i = 0; i
                                        < RecipeDAO.getRatingByRecipeId(list.getId());
                                        i++) { %>
                                        <img src="./assets/full-star-icon.svg">
                            <% }%>
                            <p
                                class="recommendation-content-reciew-rating">
                                <%=RecipeDAO.getRatingByRecipeId(list.getId())%>
                            </p>
                        </div>
                    </a>
                    <% }
                        } else {
                            System.out.println("[TIME BASED RECIPE]: The recipe recieved is null");
                        } %>
                </div>
            </div>
        </div>

        <div class="recommendation-3">
            <div class="container">
                <% ArrayList<RecipeDTO> suggestionRecipeList;

                    String selectedSuggestion = (String) session.getAttribute("selectedSuggestion");
                    if (selectedSuggestion == null) {
                        suggestionRecipeList
                                = SuggestionDAO.getDefaultSuggestionRecipe();
                        selectedSuggestion
                                = SuggestionDAO.getDefaultSuggestionTitle();
                    } else {
                        suggestionRecipeList
                                = SuggestionDAO.getAllRecipesBySuggestion(selectedSuggestion);
                    }
                %>
                <div class="row">
                    <header class="search-result-header">
                            <p>
                                <%= selectedSuggestion%> Recipe(s)
                            </p>
                    </header>
                </div>
                <div class="row recommendation-content">
                    <% if (suggestionRecipeList != null
                                && suggestionRecipeList.size() > 0) {
                            for (RecipeDTO r : suggestionRecipeList) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">

                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath()%>"
                                 alt="">
                        </div>
                        <div>
                            <p>
                                <%=RecipeDAO.getCategoryByRecipeId(r.getId())%>
                            </p>
                            <p>
                                <%= r.getTitle()%>
                            </p>
                        </div>
                        <div class="recommendation-content-reciew">
                            <% for (int i = 0; i
                                        < RecipeDAO.getRatingByRecipeId(r.getId());
                                        i++) { %>
                                        <img src="./assets/full-star-icon.svg">
                            <% }%>
                            <p
                                class="recommendation-content-reciew-rating">
                                <%=RecipeDAO.getRatingByRecipeId(r.getId())%>
                            </p>
                        </div>
                    </a>
                    <% }
                        }%>
                </div>
            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <script src="bootstrap/js/bootstrap.min.js" ></script>

    </body>

</html>