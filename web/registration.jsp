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
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
            crossorigin="anonymous" />
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

        <!--        Log in Form         -->
        <div class="blank-background">
            <div class="container">
                <div class="row form">
                    <header class="form-header col-md-12">REGISTRATION</header>
                    <div>
                        <form
                            action="MainController"
                            method="POST"
                            class="register-form">
                            <div class="row  register-form-content">
                                <div class="register-form-content-input">
                                    <p>
                                        <span>Username</span>
                                        <span>*</span>
                                    </p>
                                    <input type="text" name="txtUserName" placeholder="Enter your username" />
                                    <p class="error-popup">${requestScope.MSG_INCORRECT_USERNAME}${requestScope.MSG_USERNAME_EXIST}</p>
                                </div>
                                <div class=" register-form-content-input">
                                    <p>
                                        <span>Email</span>
                                        <span>*</span>
                                    </p>
                                    <input type="text" name="txtEmail" placeholder="Enter your email" />
                                    <p class="error-popup">${requestScope.MSG_EMAIL_EXIST}${requestScope.MSG_INCORRECT_EMAIL}</p>
                                </div>
                                <div class="register-form-content-input">
                                    <p>
                                        <span>Password</span>
                                        <span>*</span>
                                    </p>
                                    <input type="password" name="txtPass" placeholder="Must have 1 uppercase and 1 number (Max letters: 18)" />
                                    <p class="error-popup">${requestScope.MSG_INCORRECT_PASSWORD}</p>
                                </div>
                                <div class="register-form-content-input">
                                    <p>
                                        <span>Re-enter password</span>
                                        <span>*</span>
                                    </p>
                                    <input type="password" name="txtConfirmPass" placeholder="Re-enter your password" />
                                    <p class="error-popup">${requestScope.MSG_INCORRECT_CONFIRM_PASSWORD}</p>
                                </div>
                            </div>
                                <button type="submit" value="signup" name="action">SIGN UP</button>
                            <div class="register-already-have-account">
                                <span> Already have an account? </span>
                                <span>
                                    <a href="login.jsp">Sign In</a>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--         Footer       -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="website-social-media col-md-6">
                        <a
                            href="homePage.html"
                            class="website-social-media-logo">
                            <img
                                src="./assets/Logo2.png"
                                alt="" />
                        </a>
                        <div class="website-social-media-icons">
                            <span>Follow us:</span>
                            <a href="#"
                               ><img
                                    src="./assets/facebook-icon.svg"
                                    alt="Facebook Logo"
                                    /></a>
                            <a href="#"
                               ><img
                                    src="./assets/twitter-icon.svg"
                                    alt="Twitter Logo"
                                    /></a>
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

        <!--      Bootstrap for JS         -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
</html>
