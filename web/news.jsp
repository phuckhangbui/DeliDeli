<%-- 
    Document   : news
    Created on : Jun 1, 2023, 4:47:15 PM
    Author     : Admin
--%>

<%@page import="News.NewsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="News.NewsDTO"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
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

        <!--       News Result     -->
        <div class="new-result">
            <div class="container ">
                <div class="row">
                    <header class="new-result-header">
                        <p>What's New on The Board</p>
                    </header>
                </div>
                <div class="row new-result-content">
                    <%
                        ArrayList<NewsDTO> listNews = NewsDAO.getAllNews();
                        if (listNews.size() > 0 && listNews != null) {
                            for (NewsDTO news : listNews) {
                    %>
                    <a href="MainController?action=getNewsDetail&id=<%= news.getId()%>" class="col-md-3 new-result-content-post">
                        <div class="new-result-content-picture">
                            <img src="ServletImageLoader?identifier=<%= news.getImage()%>" alt="">
                        </div>
                        <div >
                            <p><%= NewsDAO.getNewsCategoryByNewsId(news.getId())%></p>
                            <p class="new-result-content-post-title"><%= news.getTitle()%></p>
                        </div>
                    </a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>







        <!--         Footer       -->
        <%@include file="footer.jsp" %>
        
        
    </body>
</html>
