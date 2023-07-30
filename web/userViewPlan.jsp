<%-- 
    Document   : userViewPlan
    Created on : Jun 22, 2023, 9:03:32 AM
    Author     : Walking Bag
--%>

<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="DTO.DietDTO"%>
<%@page import="DAO.DietDAO"%>
<%@page import="Utils.DateNameChanger"%>
<%@page import="DAO.PlanDAO"%>
<%@page import="DTO.NutritionDTO"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.TimerTask"%>
<%@page import="java.util.Timer"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DAO.MealDAO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.DateDTO"%>
<%@page import="DTO.DateDTO"%>
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
            LocalDate currentDate = LocalDate.now();
            java.sql.Date startDateSQL = plan.getStart_at();
            LocalDate startLocalDate = startDateSQL.toLocalDate();

            // This exist only to redirect page based on selected date.
            int distanceInDays = (int) ChronoUnit.DAYS.between(startLocalDate, currentDate);

            String distanceInDaysParam = request.getParameter("distanceInDays");
            if (distanceInDaysParam != null) {
                distanceInDays = Integer.parseInt(distanceInDaysParam);
            }
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

        <!--         Recipe Plan       -->

        <div class="blank-background">
            <div class="container">
                <div class="row plan">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                            <li class="breadcrumb-item"><a href="UserController?action=planManagement&userId=<%=user.getId()%>"> Plans List </a></li> 
                            <li class="breadcrumb-item current-link" aria-current="page"><%= plan.getName()%></li>
                        </ol>
                    </nav>
                    <div class="plan-header">
                        <p><%= plan.getName()%></p>
                        <p>View your eating schedule that you have planned out for yourself</p>
                    </div>

                    <div class="plan-info">
                        <div class="row">

                            <%
                                // Simple date format converter -> 06-23 => June 23rd
                                Date start_date = plan.getStart_at();
                                Date end_date = plan.getEnd_at();
                                SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d", Locale.ENGLISH);
                                String formattedStartDate = DateNameChanger.formatDateWithOrdinalIndicator(start_date, dateFormat);
                                String formattedEndDate = DateNameChanger.formatDateWithOrdinalIndicator(end_date, dateFormat);
                            %>

                            <div class="plan-info-period col-md-6">
                                <p>
                                    <span>Period:</span>                                           
                                    <%= formattedStartDate%> - <%= formattedEndDate%>
                                </p>
                            </div>
                            <div class="plan-info-type col-md-6">
                                <%
                                    DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
                                %>
                                <p><span>Type:</span><%= diet.getTitle()%></p>
                            </div>
                        </div>
                        <div class="plan-info-description">
                            <p><span>Description:</span> <%= plan.getDescription()%></p>
                        </div>
                    </div>



                    <div class="plan-navbar">
                        <div class="plan-navbar-edit-info">
                            <form action="UserController">
                                <input name="id" value="<%= plan.getId()%>" hidden=""/>
                                <button type="submit" name="action" value="loadEditPlanDetail" class="plan-navbar-remove">Edit Plan's Detail</button>
                            </form>
                            <% if (plan.isDaily()) {%>
                            <form action="UserController">
                                <input name="id" value="<%= plan.getId()%>" hidden="">
                                <button type="submit" name="action" value="loadEditDailyTemplate" class="plan-navbar-remove">Template</button>
                            </form>
                            <%} else {%>
                            <form action="UserController">
                                <input name="id" value="<%= plan.getId()%>" hidden="">
                                <button type="submit" name="action" value="loadEditDailyTemplate" disabled="">Template</button>
                            </form>
                            <%}%>
                        </div>
                        <!--                        <button type="button" class="plan-navbar-remove" data-bs-toggle="modal"
                                                        data-bs-target="#removeAllRecipes" onclick="redirectToEditPlan()">
                                                    Edit Plan
                                                </button>-->
                        <div>
                            <button id="planButton" type="button" class="plan-navbar-activate" onclick="disableActivatePlan()">
                                <% if (plan.isStatus()) { %>
                                Disable
                                <% } else { %>
                                Activate
                                <% }%>
                            </button>
                            <script>
                                // Disable/Activate the plan using AJAX
                                function disableActivatePlan() {
                                    var planId = '<%= plan.getId()%>';
                                    var button = document.getElementById("planButton");

                                    var xhr = new XMLHttpRequest();
                                    xhr.open("POST", "DisablePlanServlet", true);
                                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                                    xhr.onload = function () {
                                        if (xhr.status === 200) {
                                            // Update button text based on the response
                                            if (button.innerText === "Disable") {
                                                button.innerText = "Activate";
                                            } else {
                                                button.innerText = "Disable";
                                            }
                                        } else {
                                            console.error("Failed to disable/activate the plan.");
                                        }
                                    };

                                    xhr.send("plan_id=" + encodeURIComponent(planId));
                                }
                            </script>
                            <button type="button" class="plan-navbar-delete" data-bs-toggle="modal"
                                    data-bs-target="#deletePlanConfirm">
                                Delete Plan
                            </button>
                            <!-- Modal -->
                            <div class="modal fade" id="deletePlanConfirm" tabindex="-1"
                                 aria-labelledby="deletePlanConfirmModalLabel" aria-hidden="true">
                                <form action="UserController" method="POST" class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="removeAllRecipesModalLabel">Delete Plan</h1>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure you want to delete this plan ?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">No, I changed my mind</button>

                                            <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                                            <input type="hidden" name="user_id" value="<%= user.getId()%>" />

                                            <button type="submit" name="action" value="deletePlanConfirmed" class="remove-recipe-from-plan-button">Yes, delete it</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <a href="UserController?action=editPlan&id=<%= plan.getId()%>&isSearch=false&distanceInDays=<%= distanceInDays%>">
                                <img src="./assets/edit-icon.svg" alt="">
                            </a>
                        </div>

                        <!-- <button class="plan-navbar-edit">
                                <a href="userViewPlan.html"><img src="./assets/leave.svg" alt=""></a>
                            </button> -->
                    </div>
                    <%
                        ArrayList<DateDTO> planDate = (ArrayList<DateDTO>) request.getAttribute("planDate");
                        ArrayList<DateDTO> allPlanDate = (ArrayList<DateDTO>) request.getAttribute("allPlanDate");
                    %>
                    <div class="date-changer"> 
                        <input type="date" name="dateChanger" id="dateInput" min="<%= allPlanDate.get(0).getDate()%>" max="<%= allPlanDate.get(allPlanDate.size() - 1).getDate()%>" onchange="updateDate(this.value)">
                    </div>
                    <script>
                        function updateDate(dateValue) {
                            var distanceInDays = 0;

                            var selectedDate = new Date(dateValue);
                            var startDate = new Date("<%= allPlanDate.get(0).getDate()%>");

                            var distanceInTime = Math.abs(selectedDate.getTime() - startDate.getTime());
                            var distanceInDays = Math.ceil(distanceInTime / (1000 * 3600 * 24));

                            console.log("Distance between selected date and start date:", distanceInDays, "days");

                            var servletURL = "PlanDetailServlet?id=" + <%= plan.getId()%> + "&distanceInDays=" + distanceInDays;
                            window.location.href = servletURL;
                        }
                    </script>

                    <div class=" plan-table">
                        <%
                            for (DateDTO dateList : planDate) {
                                String formattedDate = DateNameChanger.formatDateWithOrdinalIndicator(dateList.getDate(), dateFormat);
                                ArrayList<MealDTO> breakfastMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), true, false, false);
                                ArrayList<MealDTO> lunchMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, true, false);
                                ArrayList<MealDTO> dinnerMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, false, true);
                                ArrayList<NutritionDTO> recipeNutrition = MealDAO.getSumNutritionValuesByDateId(dateList.getId());
                        %>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                <%
                                    SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("EEEE");
                                    dateList.getDate();
                                    String dayOfWeek = dayOfWeekFormat.format(dateList.getDate());
                                %>
                                <%= dayOfWeek%> (<%= formattedDate%>)
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <%
                                    for (NutritionDTO nutrition : recipeNutrition) {
                                %>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: <%= nutrition.getCalories()%></p>
                                    <p class="plan-table-protein">Proteins: <%= nutrition.getProtein()%> g</p>
                                    <p class="plan-table-carb">Carbs: <%= nutrition.getCarbs()%> g</p>
                                    <p class="plan-table-fat">Fats: <%= nutrition.getFat()%> g</p>
                                </div>
                                <%
                                    }
                                %>
                            </div>

                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Morning</div>

                                <div class="plan-table-week-recipe">
                                    <% if (breakfastMeals != null && breakfastMeals.size() != 0) {
                                            for (MealDTO list : breakfastMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId(); // Generate unique modal ID for each recipe
%>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#<%= modalId%>">
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
                                    <div class="modal fade" id="<%= modalId%>" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <a class="recipe-nutriton-modal-image" href="MainController?action=getRecipeDetailById&id=<%= recipe.getId()%>" target="_blank">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                        <h3><%= recipe.getTitle()%></h3>
                                                    </a>

                                                    <div class="row recipe-nutrtion-modal-time-view">
                                                        <div class="col-md-12">
                                                            <div >Start time: <%= formattedTime%></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>

                                    <div class="plan-table-week-empty-recipe">
                                        <div>
                                            No Recipe
                                        </div>
                                    </div>


                                    <% } %>
                                </div>
                            </div>



                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Afternoon</div>

                                <div class="plan-table-week-recipe">
                                    <% if (lunchMeals != null && lunchMeals.size() != 0) {
                                            for (MealDTO list : lunchMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId(); // Generate unique modal ID for each recipe
%>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#<%= modalId%>">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title"><%= recipe.getTitle()%></p>
                                            <% SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                                String formattedTime = timeFormat.format(list.getStart_time());
                                            %>
                                            <p class="plan-table-week-recipe-content-des-time"><%= formattedTime%></p>
                                        </div>
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="<%= modalId%>" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%

                                        }
                                    } else {
                                    %>

                                    <div class="plan-table-week-empty-recipe">
                                        <div>
                                            No Recipe
                                        </div>
                                    </div>


                                    <% } %>
                                </div>
                            </div>


                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Night</div>

                                <div class="plan-table-week-recipe">
                                    <% if (dinnerMeals != null && dinnerMeals.size() != 0) {
                                            for (MealDTO list : dinnerMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId(); // Generate unique modal ID for each recipe
                                    %>
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#<%= modalId%>">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title"><%= recipe.getTitle()%></p>
                                            <% SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                                String formattedTime = timeFormat.format(list.getStart_time());
                                            %>
                                            <p class="plan-table-week-recipe-content-des-time"><%= formattedTime%></p>
                                        </div>
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="<%= modalId%>" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>

                                    <div class="plan-table-week-empty-recipe">
                                        <div>
                                            No Recipe
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            </div>


                        </div>
                        <%
                            }
                        %>
                    </div>
                    <%
                        if (plan.getNote() == null || plan.getNote().equals("")) {
                        } else {
                    %>
                    <div class="plan-note">
                        <p>Note:</p>
                        <p><%= plan.getNote()%></p>
                    </div>
                    <%
                        }
                    %>


                </div>
            </div>
        </div>


        <!--         Footer       -->
        <%@include file="footer.jsp" %>


        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
