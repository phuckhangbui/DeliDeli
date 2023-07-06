<%-- 
    Document   : notFound.jsp
    Created on : Jul 3, 2023, 9:48:19 PM
    Author     : Admin
--%>

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
        href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&family=Pacifico&display=swap"
        rel="stylesheet">
    </head>
    <body>
        <div class="error-background">
            <div class="error-background-404">
                404
            </div>
            <div class="error-background-message">
                Oops, Something's Missing
            </div>
            <div class="error-background-explaination">
                It's seem that the page you're looking for doesn't exist or was loading incorrectly
            </div>
            <a class="error-background-go-back" href="">
                Back To Home<span>></span>
            </a>

        </div>
    </body>
</html>
