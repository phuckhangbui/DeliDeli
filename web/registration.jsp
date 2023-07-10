<%-- 
    Document   : registration
    Created on : May 23, 2023, 5:07:08 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delideli</title>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1" />
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
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
            rel="stylesheet" />
    </head>
    <body>
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <!--        Register Form         -->
        <div class="blank-background">
            <div class="container user-form">
                <form class="row" action="MainController" method="POST">
                    <div class="col-md-6 user-form-content">
                        <div class="user-form-content-header">
                            REGISTRATION
                        </div>
                        <div class="user-form-content-input">
                            <span>User Name</span> <span>*</span>
                            <input type="text" name="txtUserName" placeholder="Enter your username" />
                        </div>
                        <div class="user-form-content-input">
                            <span>Email</span> <span>*</span>
                            <input type="text" name="txtEmail" placeholder="Enter your email" />
                        </div>
                        <div class="user-form-content-input">
                            <span>Password</span> <span>*</span>
                            <input type="password" name="txtPass" value="" placeholder="Must have 1 uppercase and 1 number (Length: 8-16)" />
                        </div>
                        <div class="user-form-content-input">
                            <span>Re-enter Password</span> <span>*</span>
                            <input type="password" name="txtConfirmPass" value="" placeholder="Re-enter your password" />
                        </div>
                            <p class="error-popup">${requestScope.errorList[0]}</p>
                        <button type="submit" value="signup" name="action" class="user-form-content-button">SIGN UP</button>
                        <a href="forgotPassword.jsp" class="user-form-content-forgot">
                            Forgot password?
                        </a>
                        <div class="user-form-content-sign-up">
                            Already have an account? Sign in <a href="login.jsp">here</a>
                        </div>
                    </div>
                    <div class="col-md-6 user-form-picture-right">
                        <img src="pictures/form-picture-2.jpg"/>
                    </div>
                </form>
            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
