<%-- 
    Document   : userViewPlan
    Created on : Jun 22, 2023, 9:03:32 AM
    Author     : Walking Bag
--%>

<%@page import="Diet.DietDTO"%>
<%@page import="DateFormat.DateNameChanger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Plan.PlanDAO"%>
<%@page import="Plan.PlanDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

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
                    PlanDTO plan = (PlanDTO) request.getAttribute("plan");
                    DietDTO diet = (DietDTO) request.getAttribute("diet");
                %>
                <div class="row plan">
                    <div class="plan-header">
                        <%= plan.getName()%>
                    </div>
                    <div class="plan-info">
                        <div class="row">
                            <div class="plan-info-period col-md-6">
                                <%
                                    Date start_date = plan.getStart_at();
                                    Date end_date = plan.getEnd_at();
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d", Locale.ENGLISH);
                                    String formattedStartDate = DateNameChanger.formatDateWithOrdinalIndicator(start_date, dateFormat);
                                    String formattedEndDate = DateNameChanger.formatDateWithOrdinalIndicator(end_date, dateFormat);
                                %>
                                <p><span>Period:</span> <%= formattedStartDate %> - <%= formattedEndDate %> </p>
                            </div>
                            <div class="plan-info-type col-md-6">
                                <p><span>Type:</span><%= diet.getTitle() %> </p>
                            </div>
                        </div>
                        <div class="plan-info-description">
                            <p><span>Description:</span> <%= plan.getDescription() %></p>
                        </div>
                    </div>
                    <div class="plan-navbar">
                        <button class="plan-navbar-edit">
                            <a href="addRecipesToPlan.jsp"><img src="./assets/edit.svg" alt=""></a>
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
        <%@include file="footer.jsp" %>

        <!--      Bootstrap for JS         -->
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
