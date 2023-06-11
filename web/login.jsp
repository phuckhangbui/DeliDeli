<%-- 
    Document   : login
    Created on : May 23, 2023, 7:55:44 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
              rel="stylesheet">
    </head>
    <body>
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        
        <!--        Log in Form         -->
        <div class="blank-background">
            <div class="container user-form">
                <form class="row" action="MainController" method="post">
                    <div class="col-md-6 user-form-picture-left">
                        <img src="pictures/form-picture.jpg"/>
                    </div>
                    <div class="col-md-6 user-form-content">
                        <div class="user-form-content-header">
                            SIGN IN
                        </div>
                        <div class="user-form-content-input">
                            <p>Email</p>
                            <input type="text" name="txtEmail" required=""/>
                        </div>
                        <div class="user-form-content-input">
                            <p>Password</p>
                            <input type="password" name="txtPass" required="" />
                        </div>
                        <div class="user-form-content-remember">
                            <input type="checkbox" /><span>Remember me</span>
                        </div>

                        <%
                            String recipeID = request.getParameter("recipeID");
                            //Prevent from nulling.
                            if (recipeID != null) {
                        %>
                        <input type="hidden" name="recipeID" value="<%= recipeID%>" />
                        <%
                            }
                        %>
                        <p class="error-popup">${requestScope.errorList[0]}</p>
                        <button type="submit" value="login" name="action" class="user-form-content-button">SIGN IN</button>
                        <a href="forgotPassword.jsp" class="user-form-content-forgot">
                            Forgot password?
                        </a>
                        <div class="user-form-content-sign-up">
                            Don't have an account? Sign up <a href="registration.jsp">here</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>



        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
</html>
