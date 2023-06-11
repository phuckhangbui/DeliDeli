<%-- 
    Document   : forgotPassword
    Created on : May 25, 2023, 4:17:09 PM
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous" />
        <!--      CSS         -->
        <link rel="stylesheet" href="./styles/userStyle.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
              rel="stylesheet" />
    </head>

    <body>
        <%@include file="header.jsp" %>

        <!--        Forgot Password         -->
        
        <div class="blank-background">
            <div class="container user-form">
                <form class="row" action="MainController" method="POST">
                    <div class="col-md-3 user-form-picture-left">
                        <img src="pictures/form-picture-5.jpg"/>
                    </div>
                    <div class="col-md-6 user-form-content">
                        <div class="user-form-content-header">
                            FORGOT PASSWORD
                        </div>
                        <div class="user-form-content-input">
                            <span>Email</span> <span>*</span>
                            <input class="" type="email" name="txtEmail" required=""/>
                        </div>
                        <p class="user-form-content-description">We will send a request to reset your password via entered email</p>
                        <button  type='submit' value='forgotPass' name='action' class="user-form-content-button">SEND</button>
                        <div class="user-form-content-sign-up">
                            Remember already? Sign in <a href="login.jsp">here</a>
                        </div>
                    </div>
                    <div class="col-md-3 user-form-picture-right">
                        <img src="pictures/form-picture-4.jpg"/>
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
