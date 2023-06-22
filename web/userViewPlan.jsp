<%-- 
    Document   : userViewPlan
    Created on : Jun 22, 2023, 9:03:32 AM
    Author     : Walking Bag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

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
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">

    </head>

    <body>
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <!--         Recipe Plan       -->
        <div class="blank-background">
            <div class="container">
                <%
                    
                %>
                <div class="row plan">
                    <div class="plan-header">
                        This Week's Plan
                    </div>
                    <div class="plan-info">
                        <div class="row">
                            <div class="plan-info-period col-md-6">
                                <p><span>Period:</span>June 18th - June 24th</p>
                            </div>
                            <div class="plan-info-type col-md-6">
                                <p><span>Type:</span>Healthy</p>
                            </div>
                        </div>
                        <div class="plan-info-description">
                            <p><span>Description:</span>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean
                                commodo ligula eget dolor. Aenean m</p>
                        </div>
                    </div>
                    <div class="plan-navbar">
                        <button class="plan-navbar-edit">
                            <a href="addRecipesToPlan.html"><img src="./assets/edit.svg" alt=""></a>
                        </button>
                    </div>
                    <div class="col-md-12 plan-table ">
                        <div class="plan-table-header plan-table-row">
                            <div></div>
                            <div>Monday</div>
                            <div>Tuesday</div>
                            <div>Wednesday</div>
                            <div>Thursday</div>
                            <div>Friday</div>
                            <div>Saturday</div>
                            <div>Sunday</div>
                        </div>
                        <div class="plan-table-row plan-table-nutrition">
                            <div class="plan-table-content-header">
                                Nutrition
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                            <div class="plan-table-nutrition-content">
                                <div>
                                    <p><span class="plan-table-calories">Cals</span>(Calories): </p>
                                    <p><span class="plan-table-protein">P</span>(Protein): </p>
                                    <p><span class="plan-table-carb">C</span>(Carb): </p>
                                    <p><span class="plan-table-fat">F</span>(Fat): </p>
                                </div>
                                <div>
                                    <p>20</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                    <p>20g</p>
                                </div>
                            </div>
                        </div>
                        
                        
                        <!-- BREAKFAST -->
                        <div class="plan-table-row plan-table-recipe">
                            <div class="plan-table-content-header">
                                Breakfast
                            </div>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry sda asd</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                        </div>
                        <div class="plan-table-row">
                            <div class="plan-table-content-header">
                                Lunch
                            </div>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                        </div>
                        <div class="plan-table-row">
                            <div class="plan-table-content-header">
                                Dinner
                            </div>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                            <a href="" class="plan-table-recipe-content">
                                <div class="plan-table-recipe-content-image">
                                    <img src="./pictures/egg1.jpeg" alt="">
                                </div>
                                <div class="plan-table-recipe-content-title">Chicken Curry</div>
                                <div class="plan-table-recipe-content-nutrients">
                                    <p><span class="plan-table-calories">Cals</span>20</p>
                                    <p><span class="plan-table-protein">P</span> 29g</p>
                                    <p><span class="plan-table-carb">C</span> 24g</p>
                                    <p><span class="plan-table-fat">F</span> 434g</p>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="plan-note">
                        <p>Note:</p>
                        <p>
                            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
                            eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur
                            ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla
                            consequat massa quis enim. Donec.
                        </p>
                    </div>
                    <!-- <div class="plan-navbar">
                        <button class="plan-navbar-delete">
                            Delete
                        </button>
                    </div> -->
                </div>
            </div>
        </div>




        <!--         Footer       -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="website-social-media col-md-4">
                        <div class="footer-header">
                            <p>We Are</p>
                        </div>
                        <a href="homePage.html" class="website-social-media-logo">
                            <img src="./assets/Logo2.png" alt="">
                        </a>
                        <div class="website-social-media-icons">
                            <span>Follow us:</span>
                            <a href="#"><img src="./assets/facebook-icon.svg" alt="Facebook Logo"></a>
                            <a href="#"><img src="./assets/twitter-icon.svg" alt="Twitter Logo"></a>
                        </div>
                    </div>
                    <nav class="navigation-bar-footer col-md-4">
                        <div class="footer-header">
                            <p>Explore</p>
                        </div>
                        <ul class="navigation-bar-footer-content">
                            <li><a href="">INGREDIENTS</a></li>
                            <li><a href="">CATEGORIES</a></li>
                            <li><a href="">INGREDIENTS</a></li>
                            <li><a href="">CUISINES</a></li>
                            <li><a href="">DIFFICULTIES</a></li>
                            <li><a href="">NEWS</a></li>
                        </ul>
                    </nav>
                    <nav class="website-infomation-bar col-md-4">
                        <div class="footer-header">
                            <p>Know More</p>
                        </div>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
