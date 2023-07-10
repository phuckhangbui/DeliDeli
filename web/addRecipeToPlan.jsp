<%-- 
    Document   : addRecipeToPlan
    Created on : Jun 22, 2023, 9:08:19 AM
    Author     : Walking Bag
--%>

<%@page import="DTO.NutritionDTO"%>
<%@page import="DTO.DisplayRecipeDTO"%>
<%@page import="DAO.DietDAO"%>
<%@page import="DTO.DietDTO"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.MealDAO"%>
<%@page import="DTO.MealDTO"%>
<%@page import="DTO.PlanDTO"%>
<%@page import="DTO.PlanDateDTO"%>
<%@page import="DTO.PlanDateDTO"%>
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


                    <div class="plan-navbar">
                        <button type="button" class="plan-navbar-remove" data-bs-toggle="modal"
                                data-bs-target="#removeAllRecipes">
                            Remove All Recipes
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="removeAllRecipes" tabindex="-1"
                             aria-labelledby="removeAllRecipesModalLabel" aria-hidden="true">
                            <form class="modal-dialog">
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
                                        <button type="button" class="remove-recipe-from-plan-button">Yes, remove all of them</button>
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
                            <form class="modal-dialog">
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
                                        <button type="button" class="remove-recipe-from-plan-button">Yes, delete it</button>
                                    </div>
                                </div>
                            </form>
                        </div>


                        <!-- <button class="plan-navbar-edit">
                                <a href="userViewPlan.html"><img src="./assets/leave.svg" alt=""></a>
                            </button> -->
                    </div>


                    <%
                        boolean SEARCH_PLAN_REAL = (boolean) request.getAttribute("SEARCH_PLAN_REAL");
                    %>
                    <div class=" plan-table">
                        <%
                            ArrayList<PlanDateDTO> planDate = (ArrayList<PlanDateDTO>) request.getAttribute("planDate");
                            for (PlanDateDTO dateList : planDate) {
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


                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>

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
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                                <div class="modal-footer">
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
                                <div class="plan-table-week-header">Lunch</div>

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
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                                <div class="modal-footer">
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
                                <div class="plan-table-week-header">Dinner</div>

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
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body recipe-nutriton-modal">
                                                    <div class="recipe-nutriton-modal-image">
                                                        <img src="ServletImageLoader?identifier=<%= RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath()%>" alt="">
                                                    </div>
                                                </div>

                                                <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="meal_id" value="<%= list.getId()%>">
                                                <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                                <div class="modal-footer">
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
                                <select name="searchBy" id="">
                                    <option value="Title" selected="selected">TITLE</option>
                                    <option value="Category">CATEGORIES</option>
                                    <option value="Cuisine">CUISINES</option>
                                    <option value="Diet">DIETS</option>
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
                                <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan<%= list.getId()%>">
                                    Add
                                </button>
                                <!--     <button type="button">
                                         View
                                     </button>
                                -->
                            </div>
                        </div>


                        <!-- Modal -->
                        <div class="modal fade" id="addRecipeToPlan<%= list.getId()%>" tabindex="-1"
                             aria-labelledby="addRecipeToPlanModalLabel<%= list.getId()%>" aria-hidden="true">
                            <form action="UserController" method="post" class="modal-dialog add-recipe-to-plan-modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel<%= list.getId()%>">Adding Recipe To Plan</h1>
                                    </div>
                                    <div class="modal-body">
                                        <div>
                                            <div>What day do you want to cook this recipe ?</div>
                                            <div class="row choose-week-day">
                                                <%
                                                    for (PlanDateDTO dateList : planDate) {
                                                        SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("EEEE");
                                                        String dayOfWeek = dayOfWeekFormat.format(dateList.getDate());

                                                        SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd");
                                                        String formattedDate = dateFormat.format(dateList.getDate());
                                                %>
                                                <div class="col-md-4">
                                                    <input type="checkbox" id="date_id<%= dateList.getId()%>" name="date_id" value="<%= dateList.getId()%>">
                                                    <label for="dateOfWeek<%= dateList.getId()%>"> <%= dayOfWeek%> (<%= formattedDate%>) </label>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <label for="eating-time">What time of the day do you want to have this meal ?</label>
                                            <br>
                                            <input type="time" id="start_time" name="start_time">
                                            <br>
                                            <label for="eating-time">Time to stop having this meal ?</label>
                                            <br>
                                            <input type="time" id="end_time" name="end_time">
                                        </div>
                                    </div>

                                    <input type="hidden" id="recipeIdInput<%= list.getId()%>" name="recipe_id" value="<%= list.getId()%>">
                                    <input type="hidden" name="plan_id" value="<%= plan.getId()%>" />

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Close</button>
                                        <button type="submit" name="action" value="addPlanRecipe" class="add-recipe-to-plan-modal-button" data-recipeid="<%= list.getId()%>" onclick="setRecipeId(this, '<%= list.getId()%>')">
                                            Add
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
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
