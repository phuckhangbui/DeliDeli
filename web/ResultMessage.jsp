<%-- 
    Document   : ResultMessage
    Created on : May 25, 2023, 5:55:58 PM
    Author     : Daiisuke
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Delideli</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--      Bootstrap         -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
        <!--      CSS         -->
        <link
            rel="stylesheet"
            href="./styles/userStyle.css" />
        <link
            rel="preconnect"
            href="https://fonts.googleapis.com" />
        <link
            rel="preconnect"
            href="https://fonts.gstatic.com"
            crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">

        <style>
            h1 {
                font-size: 2.5rem;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 65vh;
            }
        </style>
    </head>
    <body>
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>


        <h1 style="text-align: center">Your mail has been sent, check your Mailbox/Spam folder.</h1>


        <!--         Footer       -->
        <%@include file="footer.jsp" %>
        
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>

