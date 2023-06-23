<%-- 
    Document   : resetPassword
    Created on : May 25, 2023, 4:14:20 PM
    Author     : Daiisuke
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
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
        <%@include file="header.jsp" %>

        <!--        Reset Password Form         -->
        <!--        <div class="blank-background">
                    <div class="container">
                        <div class="row form">
                            <header class="form-header col-md-12">
                                RESET PASSWORD
                            </header>
                            <div>
                                <form
                                    action="MainController"
                                    method="POST"
                                    class="sign-in-form">
                                    <div>
                                        <p>
                                            <span>Enter Password</span> <span>*</span>
                                        </p>
                                        <input
                                            type="password"
                                            name="txtPassword"
                                            placeholder="Your password" />
                                    </div>
                                    <div>
                                        <p>
                                            <span>Re-Enter Password</span>
                                            <span>*</span>
                                        </p>
                                        <input
                                            type="password"
                                            name="txtRePassword"
                                            placeholder="Your password" />
                                        <p class="error-popup">${requestScope.PASS_INCORRECT}</p>
                                    </div>
                                    <button type='submit' value='updatePassByToken' name='action'>SAVE</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>-->


        <div class="blank-background">
            <div class="container user-form">
                <form class="row" action="MainController" method="POST">
                    <div class="col-md-3 user-form-picture-left">
                        <img src="pictures/form-picture-3.jpg"/>
                    </div>
                    <div class="col-md-6 user-form-content">
                        <div class="user-form-content-header">
                            RESET PASSWORD
                        </div>
                        <div class="user-form-content-input">
                            <span>New Password</span> <span>*</span>
                            <input type="password" name="txtPassword" required="" placeholder="Must have 1 uppercase and 1 number (Length: 8-16)"/>
                        </div>
                        <div class="user-form-content-input">
                            <span>Re-enter New Password</span> <span>*</span>
                            <input type="password" name="txtRePassword" required="" placeholder="Re-enter your new password"/>
                        </div>
                        <p class="error-popup">${requestScope.PASS_INCORRECT}</p>
                        <button  type='submit' value='updatePassByToken' name='action' class="user-form-content-button">RESET</button>
                    </div>
                    <div class="col-md-3 user-form-picture-right">
                        <img src="pictures/form-picture-6.jpg"/>
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

