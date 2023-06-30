<%-- 
    Document   : searchResultPage
    Created on : May 24, 2023, 7:31:28 PM
    Author     : khang
--%>

<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
              rel="stylesheet">

    </head>

    <body>
        <%@include file="header.jsp" %>

        <!--         The banner       -->
        <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <a class="carousel-item active" href="" data-bs-interval="4000">
                    <div class="banner-content">
                        <p>All new</p>
                        <p>Perfect Breakfast</p>
                        <p>Try out our new recipes for an easy and delicious breakfast that everybody can enjoy</p>
                    </div>
                    <img src="./pictures/banner.svg" class="d-block w-100" alt="...">
                </a>
                <a class="carousel-item" href="" data-bs-interval="4000">
                    <div class="banner-content ">
                        <p>All new</p>
                        <p>It's fry-day!</p>
                        <p>Get yourself some all new fried recipes so you can oil up for your next perfect weekend</p>
                    </div>
                    <img src="./pictures/fried-banner.svg" class="d-block w-100 " alt="...">
                </a>
                <a class="carousel-item" href="" data-bs-interval="4000">
                    <div class="banner-content ">
                        <p>All new</p>
                        <p>Pasta La Vista, baby!</p>
                        <p>Try out these new pasta recipes that are so good it will make you pasta way</p>
                    </div>
                    <img src="./pictures/pasta-banner.svg" class="d-block w-100" alt="...">
                </a>
                <a class="carousel-item" href="" data-bs-interval="4000">
                    <div class="banner-content ">
                        <p>All new</p>
                        <p>Udon know anything!</p>
                        <p>That's why we've prepared for you some delicious Japanese recipes to try out</p>
                    </div>
                    <img src="./pictures/udon-banner.svg" class="d-block w-100" alt="...">
                </a>
            </div>
        </div>


        <%  ArrayList<DisplayRecipeDTO> list = (ArrayList<DisplayRecipeDTO>) request.getAttribute("searchRecipesList");
            request.setAttribute("searchRecipesList", null);
            String type = "";
            int id = 0;

            if (list == null) {
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                    type = request.getParameter("type");
                    list = (ArrayList<DisplayRecipeDTO>) request.getAttribute("typeRecipeList");
                } catch (Exception e) {

                }
            }

            String ERROR_MSG = (String) session.getAttribute("ERROR_MSG");
            String SUCCESS_MSG = (String) session.getAttribute("SUCCESS_MSG");
            session.setAttribute("ERROR_MSG", null);
            session.setAttribute("SUCCESS_MSG", null);
            String typeName = "";

            if (SUCCESS_MSG == null) {
                switch (type.trim()) {
                    case "Ingredient":
                        typeName = ingredientMap.get(id);
                        break;
                    case "Category":
                        typeName = cateMap.get(id);
                        break;
                    case "Level":
                        typeName = levelMap.get(id);
                        break;
                    case "Cuisine":
                        typeName = cuisineMap.get(id);
                        break;
                    case "Diet":
                        typeName = dietMap.get(id);
                        break;
                }
                SUCCESS_MSG = "Result of " + type + ": " + typeName;
            }

            if (ERROR_MSG == null) {
                switch (type.trim()) {
                    case "Ingredient":
                        typeName = ingredientMap.get(id);
                        break;
                    case "Category":
                        typeName = cateMap.get(id);
                        break;
                    case "Level":
                        typeName = levelMap.get(id);
                        break;
                    case "Cuisine":
                        typeName = cuisineMap.get(id);
                        break;
                    case "Diet":
                        typeName = dietMap.get(id);
                        break;
                }
                ERROR_MSG = typeName + " " + type + " is not available";
            }
            if (list == null || list.size() == 0) {

        %>
        <!--         Search Result      -->
        <div class="search-result">
            <div class="container ">
                <div class="row">
                    <header class="search-result-header">
                        <p><%= ERROR_MSG%></p>
                    </header>
                </div>
            </div>
        </div>
        <% }
            if (list != null && list.size() > 0) {%>
        <div class="search-result">
            <div class="container ">
                <div class="row">
                    <header class="search-result-header">
                        <p><%= SUCCESS_MSG%></p>
                    </header>
                </div>

                <div class="row search-result-content">
                    <% for (DisplayRecipeDTO r : list) {
                    %>
                    <a href="MainController?action=getRecipeDetailById&id=<%= r.getId()%>" class="col-md-3 search-result-content-post">
                        <div class="search-result-content-picture">
                            <img src="ServletImageLoader?identifier=<%= r.getThumbnailPath() %>" alt="">

                        </div>
                        <div>
                            <p><%= r.getCategory() %></p>
                            <p><%= r.getTitle()%></p>
                        </div>
                        <div class="search-result-content-reciew">
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
                            <p class="recommendation-content-reciew-rating"><%= r.getRating() %></p>
                        </div>
                    </a>
                    <%
                        }

                    %>
                </div>

            </div>
        </div>
        <%}%>






        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
