<%-- Document : home Created on : May 23, 2023, 8:09:36 AM Author : Admin --%>
<%@page import="DTO.NewsDTO"%>
<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.SuggestionDAO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="Utils.NavigationBarUtils" %>
<%@page import="java.time.LocalTime" %>
<%@page import="java.util.ArrayList" %>
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
                    <header class="search-result-header">
                        <p>
                            What's New
                        </p>
                    </header>
                </div>
                <div class="row">
                    <%
                        ArrayList<NewsDTO> listNews = (ArrayList) request.getAttribute("listNews");
                        ArrayList<String> listNewsCategories = (ArrayList) request.getAttribute("listNewsCategories");
                        NewsDTO latestNews = (NewsDTO) request.getAttribute("latestNews");
                    %>
                    <a href="MainController?action=getNewsDetail&id=<%= latestNews.getId()%>" class="col-md-8 first-new ">
                        <img src="ServletImageLoader?identifier=<%= latestNews.getImage()%>" alt="">
                        <p><%= latestNews.getTitle()%></p>
                    </a>
                    <%
                        if (listNews.size() > 0 && listNews != null) {
                            NewsDTO news;
                            String newsCategory;
                    %>
                    <div class="col-md-4 other-news">
                        <%
                            news = listNews.get(0);
                            newsCategory = listNewsCategories.get(0);
                        %>
                        <a href="MainController?action=getNewsDetail&id=<%= news.getId()%>" class="second-new">
                            <img src="ServletImageLoader?identifier=<%= news.getImage()%>" alt="">
                            <p><%= news.getTitle()%></p>
                        </a>

                        <%
                            news = listNews.get(1);
                            newsCategory = listNewsCategories.get(1);
                        %>
                        <a href="MainController?action=getNewsDetail&id=<%= news.getId()%>" class="third-new">
                            <img src="ServletImageLoader?identifier=<%= news.getImage()%>" alt="">
                            <p><%= news.getTitle()%></p>
                        </a>
                    </div>
                    <%
                        }
                    %>

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
                    <% ArrayList<DisplayRecipeDTO> listRecipe = (ArrayList) request.getAttribute("displayRecipeList");
                        if (listRecipe != null && listRecipe.size() != 0) {
                            for (DisplayRecipeDTO r : listRecipe) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">

                            <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath()%>"
                                 alt="">
                        </div>
                        <div>
                            <p>
                                <%= r.getCategory()%>
                            </p>
                            <p>
                                <%= r.getTitle()%>
                            </p>
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
                            <p
                                class="recommendation-content-reciew-rating">
                                <%= r.getRating()%>
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
                    <%
                        ArrayList<DisplayRecipeDTO> timeRecommendDisplay = (ArrayList) request.getAttribute("timeRecommendDisplay");
                        String time = (String) request.getAttribute("timeTitle");
                    %>
                    <header class="search-result-header">
                        <p>What's for <%= time%> today? </p>
                    </header>
                </div>
                <div class="row recommendation-content">
                    <%
                        if (timeRecommendDisplay != null && timeRecommendDisplay.size() != 0) {
                            for (DisplayRecipeDTO r : timeRecommendDisplay) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">
                            <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath()%>"
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
                        } else {
                            System.out.println("[TIME BASED RECIPE]: The recipe recieved is null");
                        } %>
                </div>
            </div>
        </div>

        <div class="recommendation-3">
            <div class="container">
                <%
                    ArrayList<DisplayRecipeDTO> suggestionRecipeList = (ArrayList) request.getAttribute("displaySuggestionList");
                    String selectedSuggestion = (String) request.getAttribute("selectedSuggestion");

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
                            for (DisplayRecipeDTO r : suggestionRecipeList) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>"
                       class="col-md-4 recommendation-content-post">
                        <div class="recommendation-content-picture">

                            <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath()%>"
                                 alt="">
                        </div>
                        <div>
                            <p>
                                <%= r.getCategory()%>
                            </p>
                            <p>
                                <%= r.getTitle()%>
                            </p>
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
                            <img src="./assets/empty-star-icon.svg" alt="" >
                            <%
                                }
                            %>
                            <p
                                class="recommendation-content-reciew-rating">
                                <%= r.getRating()%>
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