<%-- 
    Document   : error
    Created on : May 29, 2023, 3:33:34 PM
    Author     : Daiisuke
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
                500
            </div>
            <div class="error-background-message">
                Oops, Delideli's Server Error
            </div>
            <div class="error-background-explaination">
                It's seem that the server is hitting a brick wall, go back before to late!!!
            </div>
            <a class="error-background-go-back" href="TriggerAppServlet" onclick="redirectToServlet()">
                Back To Home<span>></span>
            </a>

            <script>
                function redirectToServlet() {
                    window.location.href = "TriggerAppServlet";
                }
            </script>
        </div>
    </body>
</html>
