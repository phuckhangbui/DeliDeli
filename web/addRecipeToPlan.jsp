<%-- 
    Document   : addRecipeToPlan
    Created on : Jun 22, 2023, 9:08:19 AM
    Author     : Walking Bag
--%>

<%@page import="java.util.Calendar"%>
<%@page import="DAO.DateDAO"%>
<%@page import="DTO.DateDTO"%>
<%@page import="DTO.NutritionDTO"%>
<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.DietDAO"%>
<%@page import="DTO.DietDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.MealDAO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.PlanDTO"%>
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

        <script>
            function setRecipeId(button, recipeId) {
                document.getElementById("recipeIdInput" + recipeId).value = recipeId;
            }
        </script>
    </head>

    <body>

        <%
            PlanDTO plan = (PlanDTO) request.getAttribute("plan");
            boolean SEARCH_PLAN_REAL = (boolean) request.getAttribute("SEARCH_PLAN_REAL");
            ArrayList<DateDTO> planDate = (ArrayList<DateDTO>) request.getAttribute("planDate");
            ArrayList<DateDTO> allPlanDate = (ArrayList<DateDTO>) request.getAttribute("allPlanDate");
        %>

        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <!--         Recipe Plan       -->
        <div class="blank-background">
            <div class="container">
                <div class="row plan">  
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
<!--                            <li class="breadcrumb-item"><a href="UserController?action=editPlan&id=<%= plan.getId()%>&isSearch=false"> Plan - <%= plan.getName()%> </a></li>-->
                            <li class="breadcrumb-item"><a href="UserController?action=planManagement&userId=<%=user.getId()%>"> Plans List </a></li> 
                            <li class="breadcrumb-item" aria-current="page"><a href="UserController?action=getPlanDetailById&id=<%= plan.getId()%>"> <%= plan.getName()%> </a></li>
                            <li class="breadcrumb-item current-link" aria-current="page">Edit</li>
                        </ol>
                    </nav>
                    <div class="edit-plan-header">
                        <p>Edit Plan</p>
                        <p>Edit, add or remove recipes from your plan to fit more with your eating schedule</p>
                    </div>

                    Synchronize with your template?        
                    <input type="checkbox" id="isSync" name="isSync" value="1" onchange="activateSync(this, <%= plan.getId()%>)">
                    <% for (DateDTO dateList : planDate) {%>
                    <input type="hidden" class="dateIdInput" name="date_id" value="<%= dateList.getId()%>" />
                    <% }%>

                    <script>
                        function activateSync(checkbox, planId) {
                            var xhr = new XMLHttpRequest();
                            var url = "SychronizeTemplateServlet";
                            var parameterValue = checkbox.checked ? "checked" : "unchecked";
                            var params = "plan_id=" + planId + "&checkbox_state=" + parameterValue;

                            var dateIdInputs = document.getElementsByClassName("dateIdInput");
                            for (var i = 0; i < dateIdInputs.length; i++) {
                                params += "&date_id=" + dateIdInputs[i].value;
                            }

                            xhr.open("GET", url + "?" + params, true);
                            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === XMLHttpRequest.DONE) {
                                    if (xhr.status === 200) {
                                        console.log("AJAX request success.");
                                    } else {
                                        console.error("AJAX request failed.");
                                    }
                                }
                            };
                            xhr.send();
                        }
                    </script>

                    <div class="plan-navbar">
                        <button type="button" class="plan-navbar-remove" data-bs-toggle="modal"
                                data-bs-target="#removeAllRecipes">
                            Remove All Recipes
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="removeAllRecipes" tabindex="-1"
                             aria-labelledby="removeAllRecipesModalLabel" aria-hidden="true">
                            <form action="UserController" method="POST" class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="removeAllRecipesModalLabel">Remove All Recipes</h1>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to remove all recipes in this plan ?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">No, I changed my mind</button>

                                        <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                        <button type="submit" name="action" value="removeAllRecipeConfirmed" class="remove-recipe-from-plan-button">Yes, remove all of them</button>
                                    </div>
                                </div>  
                            </form>
                        </div>

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

                        <button id="planButton" type="button" class="plan-navbar-disable" onclick="disableActivatePlan()">
                            <% if (plan.isStatus()) { %>
                            Disable Plan
                            <% } else { %>
                            Activate Plan
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
                                        if (button.innerText === "Disable Plan") {
                                            button.innerText = "Activate Plan";
                                        } else {
                                            button.innerText = "Disable Plan";
                                        }
                                    } else {
                                        console.error("Failed to disable/activate the plan.");
                                    }
                                };

                                xhr.send("plan_id=" + encodeURIComponent(planId));
                            }
                        </script>

                        <!-- <button class="plan-navbar-edit">
                                <a href="userViewPlan.html"><img src="./assets/leave.svg" alt=""></a>
                            </button> -->
                    </div>

                    <input type="date" name="dateChanger" id="dateInput" min="<%= allPlanDate.get(0).getDate()%>" max="<%= allPlanDate.get(allPlanDate.size() - 1).getDate()%>" onchange="updateDate(this.value)">
                    <script>
                        function updateDate(dateValue) {
                            var distanceInDays = 0;

                            var selectedDate = new Date(dateValue);
                            var startDate = new Date("<%= allPlanDate.get(0).getDate()%>");

                            var distanceInTime = Math.abs(selectedDate.getTime() - startDate.getTime());
                            var distanceInDays = Math.ceil(distanceInTime / (1000 * 3600 * 24));

                            console.log("Distance between selected date and start date:", distanceInDays, "days");

                            var servletURL = "PlanEditServlet?id=" + <%= plan.getId()%> + "&distanceInDays=" + distanceInDays;
                            window.location.href = servletURL;
                        }
                    </script>
                    <div class=" plan-table">
                        <%
                            for (DateDTO dateList : planDate) {
                                ArrayList<MealDTO> breakfastMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), true, false, false);
                                ArrayList<MealDTO> lunchMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, true, false);
                                ArrayList<MealDTO> dinnerMeals = MealDAO.getAllMealsTimeBased(plan.getId(), dateList.getId(), false, false, true);
                                ArrayList<NutritionDTO> recipeNutrition = MealDAO.getSumNutritionValuesByDateId(dateList.getId());
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
                                <%
                                    for (NutritionDTO nutrition : recipeNutrition) {
                                %>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: <%= nutrition.getCalories()%></p>
                                    <p class="plan-table-protein">Protein: <%= nutrition.getProtein()%></p>
                                    <p class="plan-table-carb">Carbs: <%= nutrition.getCarbs()%></p>
                                    <p class="plan-table-fat">Fat: <%= nutrition.getFat()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>

                            <%
                                DateDTO date = DateDAO.getDateByPlanID(plan.getId());
                            %>

                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Morning</div>

                                <div class="plan-table-week-recipe">
                                    <% if (breakfastMeals != null && breakfastMeals.size() != 0) {
                                            for (MealDTO list : breakfastMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId();
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
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Start time: <%= list.getStart_time()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <div class="modal-body recipe-nutriton-modal">
                                                    <label for="start_time">Chose the time again if you want:</label>
                                                    <!--<select id="start_time" name="start_time"></select>-->
                                                    <input type="time" id="start_time" name="start_time">
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                                <input type="hidden" name="date_id" value="<%= date.getId()%>" />

                                                <div class="modal-footer">
                                                    <button type="submit" name="action" value="editStartTimeRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Change time</button>
                                                    <button type="submit" name="action" value="removePlanRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                    <% } %>
                                </div>
                            </div>




                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Afternoon</div>

                                <div class="plan-table-week-recipe">
                                    <% if (lunchMeals != null && lunchMeals.size() != 0) {
                                            for (MealDTO list : lunchMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId();
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
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Start time: <%= list.getStart_time()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <div class="modal-body recipe-nutriton-modal">
                                                    <label for="start_time">Chose the time again if you want:</label>
                                                    <!--<select id="start_time" name="start_time"></select>-->
                                                    <input type="time" id="start_time" name="start_time">
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                                                <input type="hidden" name="date_id" value="<%= date.getId()%>" />

                                                <div class="modal-footer">
                                                    <button type="submit" name="action" value="editStartTimeRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Change time</button>
                                                    <button type="submit" name="action" value="removePlanRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                    <% } %>
                                </div>
                            </div>



                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Night</div>

                                <div class="plan-table-week-recipe">
                                    <% if (dinnerMeals != null && dinnerMeals.size() != 0) {
                                            for (MealDTO list : dinnerMeals) {
                                                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(list.getRecipe_id());
                                                String modalId = "recipeNutritionModal" + list.getId();
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
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel"><%= recipe.getTitle()%></h1>
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Start time: <%= list.getStart_time()%></h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <div class="modal-body recipe-nutriton-modal">
                                                    <label for="start_time">Chose the time again if you want:</label>
                                                    <!--<select id="start_time" name="start_time"></select>-->
                                                    <input type="time" id="start_time" name="start_time">
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                                                <input type="hidden" name="date_id" value="<%= date.getId()%>" />

                                                <div class="modal-footer">
                                                    <button type="submit" name="action" value="editStartTimeRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Change time</button>
                                                    <button type="submit" name="action" value="removePlanRecipe" class="remove-recipe-from-plan-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">Remove</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                    <% } %>
                                </div>
                            </div>



                        </div>
                        <%
                            }
                        %>
                    </div>




                    <!-- plan-edit -->
                    <form action="UserController" method="post" class="plan-edit">
                        <div class="plan-edit-header">
                            Info Section
                        </div>
                        <div class="row add-plan-date ">
                            <div class="add-plan-info-header">
                                Plan Period <span class="add-plan-info-header-des">(Each plan will have a fixed period of 1 week)</span>
                            </div>
                            <div class="col-md-6 add-plan-info-date">
                                Starting Date: <span>*</span>
                                <div>
                                    <input type="date" id="startingDate" name="start_date" value="<%= plan.getStart_at()%>" onchange="calculateNewDate()" min="<%= LocalDate.now()%>">
                                </div>
                            </div>
                            <div class="col-md-6 add-plan-info-date">
                                Ending Date:
                                <script>
                                    function calculateNewDate() {
                                        const inputDate = document.getElementById("startingDate").value;

                                        // Convert the input date to a JavaScript Date object
                                        const dateObj = new Date(inputDate);

                                        // Add 7 days to the input date
                                        dateObj.setDate(dateObj.getDate() + 6);

                                        // Format the new date as "YYYY-MM-DD"
                                        const newDate = dateObj.toISOString().split('T')[0];

                                        // Display the new date
                                        document.getElementById("endingDate").textContent = newDate;
                                    }
                                </script>
                                <div class="add-plan-info-header-date" id="endingDate">
                                </div>
                            </div>
                        </div>
                        <div class="add-plan-info-header add-plan-info">
                            Plan Title <span>*</span>
                            <div>
                                <input type="text" class="input-full" name="plan_title" value="<%= plan.getName()%>" placeholder="What's your plan called ?">
                            </div>
                            <p class="error-popup">${requestScope.errorList[0]}</p>
                        </div>


                        <!--            <div class="add-plan-info-header-picture add-plan-info">
                                        Thumbnail Picture <span>*</span>
                                        <div>
                                            <input type="file" id="image" name="thumbnail" required>
                                        </div>    
                                    </div>-->


                        <div class="add-plan-info-header add-plan-info">
                            Plan Type <span>*</span>
                            <select name="recipeDietId" id="" class="add-plan-info-header-type" required>
                                <%
                                    ArrayList<DietDTO> dietList = DietDAO.getAllDietType();
                                    if (dietList != null && dietList.size() != 0) {
                                        for (DietDTO list : dietList) {
                                %>
                                <option value="<%= list.getId()%>"> <%= list.getTitle()%> </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="add-plan-info-header add-plan-info">
                            Description <span>*</span>
                            <textarea class="input-full" rows="2" name="plan_description" required
                                      placeholder="Give a small description of your plan" maxlength="200"><%= plan.getDescription()%></textarea>
                        </div>
                        <div class="add-plan-info-header add-plan-info">
                            Note
                            <textarea class="input-full" rows="2" name="plan_note" maxlength="200"
                                      placeholder="Anything that needs to note ?"
                                      ><%= (plan.getNote() != null) ? plan.getNote() : ""%>
                            </textarea>
                        </div>


                        <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                        <input type="hidden" name="user_id" value="<%= user.getId()%>" />

                        <div class="plan-edit-button" >
                            <button type="submit" name="action" value="editPlanSave">SAVE</button>
                        </div>
                    </form> 
                </div>






                <!-- Add recipe -->
                <div class="row add-recipe-to-plan-section" id="addSection">
                    <% if (SEARCH_PLAN_REAL) { %>
                    <script>
                        window.onload = function () {
                            const scrollTarget = document.getElementById("scrollTarget");
                            scrollTarget.scrollIntoView({behavior: 'smooth'});
                        }
                    </script>
                    <% }%>
                    <div class="add-recipe-to-plan">
                        <div class="add-recipe-to-plan-section-header">
                            Add Recipes Section
                        </div>
                        <div class="add-recipe-to-plan-search-bar">
                            <form action="UserController" method="post">
                                <button type="submit" name="action" value="recipePlanSearch">
                                    <img src="assets/search-icon.svg" alt="">
                                </button>
                                <input type="text" name="txtsearch" placeholder="What recipes are you searching for ?">
                                <input type="hidden" name="isPlan" value="true" />
                                <input type="hidden" name="planId" value="<%= plan.getId()%>"/>
                                <input type="hidden" name="user_id" value="<%= user.getId()%>"/>
                                <input type="hidden" name="dietId" value="<%= plan.getDiet_id()%>"/>

                                <select name="searchBy" id="">
                                    <option value="Public" selected="selected">Public</option>
                                    <option value="Personal">Personal</option>
                                    <option value="Saved">Saved</option>
                                </select>
                            </form>
                        </div>
                    </div>
                    <div id="scrollTarget"></div> <!-- Added scrollTarget element -->




                    <div class="row add-recipe-to-plan-content">
                        <%
                            ArrayList<DisplayRecipeDTO> searchRecipesList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("SEARCH_LIST");
                            if (searchRecipesList != null && !searchRecipesList.isEmpty()) {
                                for (DisplayRecipeDTO list : searchRecipesList) {
                                    ArrayList<NutritionDTO> recipeNutrition = RecipeDAO.getNutritionValuesByRecipeID(list.getId());
                        %>
                        <div href="" class=" col-md-3 add-recipe-to-plan-content-recipe">
                            <a href="MainController?action=getRecipeDetailById&id=<%= list.getId()%>" target="_blank">
                                <div class="add-recipe-to-plan-content-recipe-image">
                                    <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(list.getId()).getThumbnailPath()%>" alt="">
                                </div>
                                <div class="add-recipe-to-plan-content-recipe-title"><%= list.getTitle()%></div>

                                <%
                                    for (NutritionDTO nutrition : recipeNutrition) {
                                %>
                                <div class="add-recipe-to-plan-content-recipe-nutrients">
                                    <p class="plan-table-calories">Calories: <%= nutrition.getCalories()%></p>
                                    <p class="plan-table-protein">Protein: <%= nutrition.getProtein()%></p>
                                    <p class="plan-table-carb">Carbs: <%= nutrition.getCarbs()%></p>
                                    <p class="plan-table-fat">Fat: <%= nutrition.getFat()%></p>
                                </div>
                                <%
                                    }
                                %>
                            </a>
                            <div class="add-recipe-to-plan-content-recipe-button">
<!--                                <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan<%= list.getId()%>">
                                    Add
                                </button>
                                -->
                                <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addMultiplesMealToPlan<%= list.getId()%>">
                                    Add multiples
                                </button>
                            </div>
                        </div>

                        <!-- Multiples Meal-->
                        <div class="modal fade" id="addMultiplesMealToPlan<%= list.getId()%>" tabindex="-1"
                             aria-labelledby="addRecipeToPlanModalLabel<%= list.getId()%>" aria-hidden="true">
                            <form action="UserController" method="post" class="modal-dialog add-recipe-to-plan-modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel<%= list.getId()%>">Adding Multiples Meals To Plan</h1>
                                    </div>
                                    <div class="modal-body">
                                        <div>What day do you want to cook this recipe?</div>
                                        <div class="row choose-week-day flex-column">
                                            <% for (DateDTO dateList : planDate) {
                                                    SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("EEEE");
                                                    String dayOfWeek = dayOfWeekFormat.format(dateList.getDate());

                                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                    String formattedDate = dateFormat.format(dateList.getDate());

                                                    // Get the end date of the plan
                                                    Date endDate = plan.getEnd_at();
                                                    Calendar calendar = Calendar.getInstance();
                                                    calendar.setTime(dateList.getDate());

                                                    // Loop through the days between the selected day and the end date
                                                    //while (calendar.getTime().before(endDate) || calendar.getTime().equals(endDate)) {
                                                    // Generate the checkboxes
                                            %>
                                            <!--                                            <div class="col-md-4">
                                                                                            <div class="d-flex">
                                                                                                <input type="checkbox" id="date_id<%= dateList.getId()%>" name="date_id" value="<%= formattedDate%>">
                                                                                                <label for="dateOfWeek<%= dateList.getId()%>"> <%= dayOfWeek%> (<%= formattedDate%>) </label>
                                                                                            </div>
                                                                                        </div>
                                            -->
                                            <%

                                                    // Increment the calendar by 1 day
                                                    //calendar.add(Calendar.DAY_OF_MONTH, 1);
                                                    //dayOfWeek = dayOfWeekFormat.format(calendar.getTime());
                                                    //formattedDate = dateFormat.format(calendar.getTime());
                                                    //}
                                                }%>
                                        </div>
                                        <div class="row add-recipe-info-ingredient">
                                            <div class="draggable-container-time col-md-8 add-recipe-info-ingredient-content">
                                                <div class="add-recipe-info-header">Time <span>*</span></div>
                                                <div class="draggable-time-container">
                                                    <!-- Existing draggable time elements -->
                                                </div>
                                            </div>
                                            <div class="col-md-4 add-recipe-info-ingredient-button">
                                                <button type="button" id="btnToggleTime">
                                                    <img src="assets/drag-icon.svg" alt="">
                                                </button>
                                                <button type="button" id="btnAddTime">
                                                    Add Time
                                                </button>
                                            </div>
                                        </div>

                                        <!--                                        <label for="recipe_count">Number of Recipes per meal:</label>
                                                                                <select id="recipe_count" name="recipe_count">
                                                                                    <option value="1">1</option>
                                                                                    <option value="2">2</option>
                                                                                    <option value="3">3</option>
                                                                                </select>-->
                                        <br><br>

                                    </div>

                                    <div class="plan-table">
                                        <% for (DateDTO dateList : planDate) {%>
                                        <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="recipe_id" value="<%= list.getId()%>">
                                        <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                                        <input type="hidden" name="week_id" value="<%= dateList.getWeek_id()%>" />
                                        <input type="hidden" name="plan_start" value="<%= plan.getStart_at()%>" />
                                        <input type="hidden" name="date_id" value="<%= dateList.getId()%>" />
                                        <% }%>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" name="action" value="addPlanRecipe" class="add-recipe-to-plan-modal-button"
                                                data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>');">Add</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Modal -->
<!--                        <div class="modal fade" id="addRecipeToPlan<%= list.getId()%>" tabindex="-1"
                             aria-labelledby="addRecipeToPlanModalLabel<%= list.getId()%>" aria-hidden="true">
                            <form action="UserController" method="post" class="modal-dialog add-recipe-to-plan-modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel<%= list.getId()%>">Adding Recipe To Plan</h1>
                                    </div>
                                    <div class="modal-body">
                                                                                <div>
                                                                                    <h1> Time is <span id="currentTime" ></span></h1>
                                                                                </div>
                                        <div>What day do you want to cook this recipe ?</div>
                                        <div class="row choose-week-day">
                        <% for (DateDTO dateList : planDate) {
                                SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("EEEE");
                                String dayOfWeek = dayOfWeekFormat.format(dateList.getDate());

                                SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd");
                                String formattedDate = dateFormat.format(dateList.getDate());
                        %>
                        <div class="col-md-4">
                            <input type="checkbox" id="date_id<%= dateList.getId()%>" name="date_id" value="<%= dateList.getId()%>">
                            <label for="dateOfWeek<%= dateList.getId()%>"> <%= dayOfWeek%> (<%= formattedDate%>) </label>
                        </div>
                        <% }%>
                    </div>
                                                            <label for="meal">Select Meal:</label>
                                                            <select id="meal" name="meal" onchange="updateTimeOptions()">
                                                                <option value="breakfast">Breakfast</option>
                                                                <option value="lunch">Lunch</option>
                                                                <option value="dinner">Dinner</option>
                                                            </select>
                                                            <br><br>
                    
                    <label for="recipe_count">Number of Recipes:</label>
                    <select id="recipe_count" name="recipe_count">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                    <br><br>
                    <label for="start_time">Select Start Time:</label>
                    <select id="start_time" name="start_time"></select>
                    <input type="time" id="start_time" name="start_time">
                    <br><br>
                </div>

                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="recipe_id" value="<%= list.getId()%>">
                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />
                        <% //DateDTO date = DateDAO.getDateByPlanID(plan.getId());%>
                        <input type="hidden" name="date_id" value="" />

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" name="action" value="addPlanRecipe" class="add-recipe-to-plan-modal-button"
                                    data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>');">Add</button>
                        </div>
                    </div>
                </form>
            </div>-->

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const modal = document.getElementById("addMultiplesMealToPlan<%= list.getId()%>");

                                let draggablesTime = []; // Array to store draggable time elements
                                let dragTime = false; // Flag to track drag mode

                                // Function to toggle drag mode
                                function toggleDragModeTime(enableDragMode) {
                                    dragTime = enableDragMode;
                                    draggablesTime.forEach((draggable) => {
                                        draggable.draggable = dragTime;
                                        draggable.classList.toggle('drag-mode-disabled', !dragTime);
                                        draggable.style.cursor = dragTime ? 'grab' : 'default';
                                    });
                                }

                                // Function to create options for select element
                                function createOptions(selectElement, timeOptions) {
                                    selectElement.innerHTML = ''; // Clear existing options

                                    for (let i = 0; i < timeOptions.length; i++) {
                                        const option = document.createElement('option');
                                        option.value = timeOptions[i];
                                        option.text = timeOptions[i];
                                        selectElement.appendChild(option);
                                    }

                                    selectElement.setAttribute('required', true); // Add the "required" attribute
                                }

                                // Add event listener to the toggle button
                                modal.querySelector("#btnToggleTime").addEventListener('click', () => {
                                    toggleDragModeTime(!dragTime); // Toggle the drag mode
                                });

                                // Add event listener to the add button
                                modal.querySelector("#btnAddTime").addEventListener('click', () => {
                                    if (!dragTime && draggablesTime.length < 6) { // Check the maximum limit
                                        const draggableContainer = modal.querySelector('.draggable-container-time');
                                        const newDraggable = document.createElement('p');
                                        newDraggable.classList.add('draggable-time');
                                        newDraggable.classList.add('draggable');
                                        newDraggable.draggable = dragTime;

                                        const newSelect = document.createElement('select');
                                        newSelect.classList.add('timeList');
                                        newSelect.name = 'timeId';
                                        const timeOptions = ['08:00', '12:00', '16:00', '20:00']; // Your custom time list
                                        createOptions(newSelect, timeOptions);

                                        const deleteButton = document.createElement('button');
                                        deleteButton.type = 'button';
                                        deleteButton.classList.add('btnDeleteTime');

                                        const deleteImage = document.createElement('img');
                                        deleteImage.src = 'assets/close-icon.svg';
                                        deleteImage.alt = 'Delete';

                                        deleteButton.appendChild(deleteImage);
                                        deleteButton.addEventListener('click', () => {
                                            newDraggable.remove();
                                            draggablesTime = draggableContainer.querySelectorAll('.draggable-time'); // Update the draggable elements
                                            if (draggablesTime.length === 1) {
                                                disableDeleteButtons();
                                            }
                                        });

                                        newDraggable.appendChild(newSelect);
                                        newDraggable.appendChild(deleteButton);

                                        draggableContainer.appendChild(newDraggable);
                                        draggablesTime = draggableContainer.querySelectorAll('.draggable-time'); // Update the draggable elements

                                        enableDeleteButtons();
                                    }
                                });

                                // Function to get the closest element during drag and drop
                                function getDragAfterElement(container, y) {
                                    const draggableElements = [...container.querySelectorAll('.draggable:not(.dragging)')];
                                    return draggableElements.reduce((closest, child) => {
                                        const box = child.getBoundingClientRect();
                                        const offset = y - box.top - box.height / 2;
                                        if (offset < 0 && offset > closest.offset) {
                                            return {offset: offset, element: child};
                                        } else {
                                            return closest;
                                        }
                                    }, {offset: Number.NEGATIVE_INFINITY}).element;
                                }

                                // Function to enable delete buttons
                                function enableDeleteButtons() {
                                    modal.querySelectorAll('.btnDeleteTime').forEach((button) => {
                                        button.addEventListener('click', () => {
                                            button.parentNode.remove();
                                            draggablesTime = draggableContainer.querySelectorAll('.draggable-time'); // Update the draggable elements
                                            if (draggablesTime.length === 1) {
                                                disableDeleteButtons();
                                            }
                                        });
                                    });
                                }

                                // Function to disable delete buttons
                                function disableDeleteButtons() {
                                    modal.querySelectorAll('.btnDeleteTime').forEach((button) => {
                                        button.disabled = true;
                                    });
                                }

                                // Add event listener to the modal's shown event
                                modal.addEventListener('shown.bs.modal', function () {
                                    const draggableContainer = modal.querySelector('.draggable-container-time');
                                    const btnToggleTime = modal.querySelector('#btnToggleTime');
                                    const btnAddTime = modal.querySelector('#btnAddTime');
                                    const btnDeleteTime = modal.querySelectorAll('.btnDeleteTime');

                                    draggablesTime = draggableContainer.querySelectorAll('.draggable-time');

                                    toggleDragModeTime(dragTime);

                                    btnToggleTime.addEventListener('click', () => {
                                        toggleDragModeTime(!dragTime);
                                    });

                                    btnAddTime.addEventListener('click', () => {
                                        // Rest of the code...
                                    });

                                    enableDeleteButtons();

                                    draggableContainer.addEventListener('dragover', (e) => {
                                        e.preventDefault();
                                        const afterElement = getDragAfterElement(draggableContainer, e.clientY);
                                        const draggable = document.querySelector('.dragging');
                                        if (afterElement == null) {
                                            draggableContainer.appendChild(draggable);
                                        } else {
                                            draggableContainer.insertBefore(draggable, afterElement);
                                        }
                                    });
                                });
                            });
                        </script>



                        <script>
//                            const mealSelect = document.getElementById("meal");
//                            const startTimeSelect = document.getElementById("start_time");
//
//                            // Map of time options based on meal
//                            const timeOptions = {
//                                breakfast: ["08:00", "08:30", "09:00", "09:30"],
//                                lunch: ["12:00", "12:30", "13:00", "13:30"],
//                                dinner: ["18:00", "18:30", "19:00", "19:30"]
//                            };
//
//                            // Function to update time options based on selected meal
//                            function updateTimeOptions() {
//                                const selectedMeal = mealSelect.value;
//                                const options = timeOptions[selectedMeal];
//
//                                // Clear existing options
//                                startTimeSelect.innerHTML = "";
//
//                                // Add new options
//                                options.forEach(time => {
//                                    const option = document.createElement("option");
//                                    option.text = time;
//                                    option.value = time;
//                                    startTimeSelect.add(option);
//                                });
//                            }
//
//                            // Event listener for modal open
//                            const modal = document.getElementById("addRecipeToPlan<%= list.getId()%>");
//                            modal.addEventListener("shown.bs.modal", updateTimeOptions);
                        </script>

                        <script>
//                            function updateTimeSelects() {
//                                const selectedMeal = mealSelect.value;
//                                const options = timeOptions[selectedMeal];
//
//                                const recipeCount = parseInt(recipeCountSelect.value);
//
//                                // Clear the existing time selects container
//                                timeSelectsContainer.innerHTML = "";
//
//                                // Generate the time selects based on the recipe count
//                                for (let i = 1; i <= recipeCount; i++) {
//                                    const startTimeLabel = document.createElement("label");
//                                    startTimeLabel.setAttribute("for", `start_time_${i}`);
//                                    startTimeLabel.textContent = `Select Start Time for Recipe ${i}:`;
//
//                                    const startTimeSelect = document.createElement("select");
//                                    startTimeSelect.setAttribute("id", `start_time_${i}`);
//                                    startTimeSelect.setAttribute("name", `start_time_${i}`);
//
//                                    // Add new options for the current time select
//                                    options.forEach(time => {
//                                        const option = document.createElement("option");
//                                        option.text = time;
//                                        option.value = time;
//                                        startTimeSelect.add(option);
//                                    });
//
//                                    // Add the label and select to the time selects container
//                                    timeSelectsContainer.appendChild(startTimeLabel);
//                                    timeSelectsContainer.appendChild(startTimeSelect);
//                                    timeSelectsContainer.appendChild(document.createElement("br"));
//                                    timeSelectsContainer.appendChild(document.createElement("br"));
//                                }
//                            }

                        </script>

                        <%
                                }
                            } else {
                                System.out.println("The search list is null");
                            }
                        %>
                    </div>
                </div>

            </div>
        </div>

        <script>
//                            function openModal(recipeId) {
//// Get the modal element
//                                var modal = document.getElementById("addRecipeToPlan" + recipeId);
//
//// Set the selected meal to "breakfast" by default
//                                var mealSelectt = modal.querySelector("#meal");
//                                mealSelectt.value = "breakfast";
//
//// Update the time options based on the selected meal
//                                updateTimeOptions();
//
//// Show the modal
//                                var modalInstance = new bootstrap.Modal(modal);
//                                modalInstance.show();
//                            }
        </script>

        <script>
//            const start_time = document.getElementById("start_time");
//
//            // Check if the start time is in the past
//            function checkStartTime() {
//                const selectedTime = start_time.value;
//                const now = new Date();
//                const currentHour = now.getHours();
//                const currentMinute = now.getMinutes();
//
//                const selectedHour = parseInt(selectedTime.split(":")[0]);
//                const selectedMinute = parseInt(selectedTime.split(":")[1]);
//
//                if (selectedHour < currentHour || (selectedHour === currentHour && selectedMinute < currentMinute)) {
//                    alert("The start time must be in the future.");
//                    start_time.focus();
//                    return false;
//                }
//
//                return true;
//            }

            // Open the modal
//            function openModal(recipeId) {
//                var modal = document.getElementById("addRecipeToPlan" + recipeId);
//                var currentTime = modal.querySelector("#currentTime");
//                currentTime.innerText = getCurrentTime(); // Set current time
//                modal.style.display = "block";
//            }
//
//            // Get the current time
//            function getCurrentTime() {
//                var now = new Date();
//                var hours = now.getHours();
//                var minutes = now.getMinutes();
//                var seconds = now.getSeconds();
//
//                // Add leading zeros if necessary
//                if (hours < 10)
//                    hours = "0" + hours;
//                if (minutes < 10)
//                    minutes = "0" + minutes;
//                if (seconds < 10)
//                    seconds = "0" + seconds;
//
//                return hours + ":" + minutes + ":" + seconds;
//            }

//            function validateTime() {
//                var selectedTimeInput = document.getElementById("start_time");
//                var selectedTime = selectedTimeInput.value;
//                var currentTime = new Date();
//                var currentHour = currentTime.getHours();
//                var currentMinute = currentTime.getMinutes();
//
//                var selectedHour = parseInt(selectedTime.split(":")[0]);
//                var selectedMinute = parseInt(selectedTime.split(":")[1]);
//
//                if (selectedHour < currentHour || (selectedHour === currentHour && selectedMinute < currentMinute)) {
//                    alert("Please select a time in the future.");
//                    selectedTimeInput.value = ""; // Clear the input value
//                    selectedTimeInput.focus(); // Set focus back to the input field
//                    return false; // Prevent form submission
//                }
//
//                return true; // Allow form submission
//            }
//
//            function setCurrentTime() {
//                var currentTime = getCurrentTime();
//                var currentTimeInput = document.getElementById("currentTimeInput");
//                currentTimeInput.value = currentTime;
//            }
        </script>



        <script>
            // Function to scroll to a specific section
            function scrollToSection(addSection) {
                const section = document.getElementById(addSection);
                section.scrollIntoView({behavior: 'smooth'});
            }
        </script>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>


        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
