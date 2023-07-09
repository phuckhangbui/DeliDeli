<%-- 
    Document   : userViewPlan
    Created on : Jun 22, 2023, 9:03:32 AM
    Author     : Walking Bag
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.util.TimerTask"%>
<%@page import="java.util.Timer"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DAO.MealDAO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.PlanDateDTO"%>
<%@page import="DTO.PlanDateDTO"%>
<%@page import="DTO.PlanDTO"%>
<%@page import="java.sql.Time"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <%
            PlanDTO plan = (PlanDTO) request.getAttribute("plan");
        %>
        <script>

            function redirectToEditPlan() {
                window.location.href = "UserController?action=editPlan&id=<%= plan.getId()%>&isSearch=false";
            }

        </script>
    </head>

    <body onload="startCountdown()">
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <!-- Tick Tock -->



        <!--         Recipe Plan       -->

        <div class="blank-background">
            <div class="container">
                <div class="row plan">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                            <li class="breadcrumb-item"><a href="planManagement.jsp"> Plan Management </a></li> 
                            <li class="breadcrumb-item current-link" aria-current="page">Current Plan Name Insert Here</li>
                        </ol>
                    </nav>
                    <div class="edit-plan-header">
                        <p>Title insert here</p>
                        <p>Description insert here</p>
                    </div>


                    <div class="plan-navbar">
                        <button type="button" class="plan-navbar-remove" data-bs-toggle="modal"
                                data-bs-target="#removeAllRecipes" onclick="redirectToEditPlan()">
                            Edit Plan
                        </button>


                        <!-- <button class="plan-navbar-edit">
                                <a href="userViewPlan.html"><img src="./assets/leave.svg" alt=""></a>
                            </button> -->
                    </div>

                    <div class=" plan-table">
                        <%                            ArrayList<PlanDateDTO> planDate = (ArrayList<PlanDateDTO>) request.getAttribute("planDate");
                            for (PlanDateDTO dateList : planDate) {
                                ArrayList<MealDTO> breakfastMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), true, false, false);
                                ArrayList<MealDTO> lunchMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, true, false);
                                ArrayList<MealDTO> dinnerMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, false, true);
                        %>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                <%
                                    SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("EEEE");
                                    String dayOfWeek = dayOfWeekFormat.format(dateList.getDate());
                                %>
                                <%= dayOfWeek%>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 12312</p>
                                    <p class="plan-table-protein">Protein: 232g</p>
                                    <p class="plan-table-carb">Carbs: 236g</p>
                                    <p class="plan-table-fat">Fat: 643g</p>
                                </div>
                            </div>


                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>

                                <div class="plan-table-week-recipe">
                                    <%
                                        if (breakfastMeals != null && breakfastMeals.size() != 0) {
                                            for (MealDTO list : breakfastMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                    %>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#recipeNutritionModal">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title"><%= recipe.getTitle()%></p>
                                            <%
                                                SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                                String formattedTime = timeFormat.format(list.getStart_time());
                                            %>
                                            <p class="plan-table-week-recipe-content-des-time"><%= formattedTime%></p>
                                        </div>
                                    </button>



                                    <!-- Modal -->
                                    <div class="modal fade" id="recipeNutritionModal" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="./pictures/egg1.jpeg" alt="">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="remove-recipe-from-plan-button">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%                                            }
                                        }
                                    %>
                                </div>
                            </div>



                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>

                                <div class="plan-table-week-recipe">
                                    <%
                                        if (lunchMeals != null && lunchMeals.size() != 0) {
                                            for (MealDTO list : lunchMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                    %>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#recipeNutritionModal">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title"><%= recipe.getTitle()%></p>
                                            <%
                                                SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                                String formattedTime = timeFormat.format(list.getStart_time());
                                            %>
                                            <p class="plan-table-week-recipe-content-des-time"><%= formattedTime%></p>
                                        </div>
                                    </button>



                                    <!-- Modal -->
                                    <div class="modal fade" id="recipeNutritionModal" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="./pictures/egg1.jpeg" alt="">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="remove-recipe-from-plan-button">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%                                            }
                                        }
                                    %>
                                </div>

                            </div>


                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>

                                <div class="plan-table-week-recipe">
                                    <%
                                        if (dinnerMeals != null && dinnerMeals.size() != 0) {
                                            for (MealDTO list : dinnerMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                    %>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#recipeNutritionModal">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title"><%= recipe.getTitle()%></p>
                                            <%
                                                SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                                String formattedTime = timeFormat.format(list.getStart_time());
                                            %>
                                            <p class="plan-table-week-recipe-content-des-time"><%= formattedTime%></p>
                                        </div>
                                    </button>



                                    <!-- Modal -->
                                    <div class="modal fade" id="recipeNutritionModal" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="./pictures/egg1.jpeg" alt="">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="remove-recipe-from-plan-button">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>


                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>


        <!--         Footer       -->
        <%@include file="footer.jsp" %>


        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
