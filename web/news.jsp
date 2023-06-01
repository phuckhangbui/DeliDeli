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
        <div class="container-fluid banner">
            <div class="container">
                <a href="" class="row ">
                    <div class="banner-content col-md-3">
                        <p>All new</p>
                        <p>Perfect Breakfast</p>
                        <p>Try out our new recipes for an easy and delicious breakfast that everybody can enjoy</p>
                    </div>
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
                            <img src="<%= news.getImage()%>" alt="">
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
    </body>
</html>
