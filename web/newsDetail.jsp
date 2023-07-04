<%-- 
    Document   : newsDetail
    Created on : Jun 1, 2023, 5:15:25 PM
    Author     : Admin
--%>
<%@page import="DTO.NewsDTO"%>
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

        <!--       News Result     -->
        <div class="blank-background">
            <div class="container ">
                <div class="row recipe-detail-info">
                    <%
                        NewsDTO news = (NewsDTO) request.getAttribute("news");
                        String category = (String) request.getAttribute("category");
                    %>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                            <li class="breadcrumb-item"><a href="LoadNewsList?id=<%= news.getNews_category()%>"><%= category%></a></li>
                            <li class="breadcrumb-item current-link" aria-current="page"><%= news.getTitle()%></li>
                        </ol>
                    </nav>
                    <header class="recipe-detail-info-main-header">
                        <p><%= news.getTitle()%></p>
                    </header>
                    <div class="recipe-detail-info-user">
                        <a href=""><img src="./assets/profile-pic.svg" alt=""></a>
                        <div>
                            <span>By</span>
                            <span><a href=""> <%= request.getAttribute("author")%></a></span>
                            <%
                                if (news.getCreateAt().equals(news.getUpdateAt())) {
                            %>
                            <p>Create at: <%= news.getCreateAt()%></p>
                            <%
                            } else {
                            %>
                            <p>Update at: <%= news.getUpdateAt()%></p>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="row new-result-content new-result-content-link">
                        <!--                        <div>
                                                    <p class="new-result-content-post-title"><%= news.getTitle()%></p>
                                                    <p class="new-result-content-post-title">By: <%= request.getAttribute("author")%></p>
                        <%
                            if (news.getCreateAt().equals(news.getUpdateAt())) {
                        %>
                        <p>Create at: <%= news.getCreateAt()%></p>
                        <%
                        } else {
                        %>
                        <p>Update at: <%= news.getUpdateAt()%></p>
                        <%
                            }
                        %>
                    </div>-->
                        <div class="recipe-detail-main-pic">
                            <img src="ServletImageLoader?identifier=<%= news.getImage()%>" alt="">
                        </div>
                        <p><%= news.getDesc()%></p>
                    </div>
                </div>
            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
