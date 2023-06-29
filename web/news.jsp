<%-- 
    Document   : news
    Created on : Jun 1, 2023, 4:47:15 PM
    Author     : Admin
--%>

<%@page import="DTO.NewsDTO"%>
<%@page import="DAO.NewsDAO"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
              rel="stylesheet">
    </head>
    <body>
        <%@include file="header.jsp" %>

        <!--         The banner       -->
        <%@include file="banner.jsp" %>

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
        
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
