<%-- 
    Document   : addRecipeToPlan
    Created on : Jun 22, 2023, 9:08:19 AM
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
                <div class="row plan">
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


                    <div class=" plan-table">
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Monday
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
                                    <button class="plan-table-week-recipe-content" type="button" data-bs-toggle="modal" data-bs-target="#recipeNutritionModal">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="./pictures/egg1.jpeg" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title">Chicken Curry Alabama Style</p>
                                            <p class="plan-table-week-recipe-content-des-time">Time: 8:00</p>
                                        </div>
                                    </button>
                                    <!-- Modal -->
                                    <div class="modal fade" id="recipeNutritionModal" tabindex="-1" aria-labelledby="recipeNutritionModalLabel" aria-hidden="true">
                                        <form class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Chicken Curry Alabama Style</h1>
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

                                    <button class="plan-table-week-recipe-content">
                                        <div class="plan-table-week-recipe-content-image">
                                            <img src="./pictures/egg1.jpeg" alt="">
                                        </div>
                                        <div class="plan-table-week-recipe-content-des">
                                            <p class="plan-table-week-recipe-content-des-title">Wong Tong Chicken Noodle</p>
                                            <p class="plan-table-week-recipe-content-des-time">Time: 9:00</p>
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Tuesday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Wednesday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Thursday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Friday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Saturday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row plan-table-week">
                            <div class="col-md-12 plan-table-week-day">
                                Sunday
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-nutrition-header">Total Nutrition</div>
                                <div class="plan-table-week-nutrition">
                                    <p class="plan-table-calories">Calories: 0</p>
                                    <p class="plan-table-protein">Protein: 0g</p>
                                    <p class="plan-table-carb">Carbs: 0g</p>
                                    <p class="plan-table-fat">Fat: 0g</p>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Breakfast</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Lunch</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 plan-table-week-column">
                                <div class="plan-table-week-header">Dinner</div>
                                <div class="plan-table-week-recipe">
                                    <button class="plan-table-week-recipe-add" onclick="scrollToSection('addSection')">
                                        <div>
                                            <img src="./assets/add-icon.svg" alt="">
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>




                    <form class="plan-edit">
                        <div class="plan-edit-header">
                            Info Section
                        </div>
                        <div class="row add-plan-date ">
                            <div class="add-plan-info-header">
                                Plan Period <span class="add-plan-info-header-des">(Each plan will have a fixed period of 1
                                    week)</span>
                            </div>
                            <div class="col-md-6 add-plan-info-date">
                                Starting Date: <span>*</span>
                                <div>
                                    <input type="date" id="startingDate" onchange="calculateNewDate()">
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
                                        dateObj.setDate(dateObj.getDate() + 7);

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
                                <input type="text" class="input-full" placeholder="What's your plan called ?">
                            </div>
                        </div>
                        <div class="add-plan-info-header-picture add-plan-info">
                            Thumbnail Picture <span>*</span>
                            <div>
                                <input type="file" id="image" name="thumbnail" required>
                            </div>    
                        </div>
                        <div class="add-plan-info-header add-plan-info">
                            Plan Type <span>*</span>
                            <select name="" id="" class="add-plan-info-header-type">
                                <option value="">Healthy</option>
                                <option value="">Diet</option>
                                <option value="">Weight Gaining</option>
                            </select>
                        </div>
                        <div class="add-plan-info-header add-plan-info">
                            Description <span>*</span>
                            <textarea class="input-full" rows="2" name="description" required
                                      placeholder="Give a small description of your plan" maxlength="200"></textarea>

                        </div>
                        <div class="add-plan-info-header add-plan-info" >
                            Note <span >*</span>
                            <textarea class="input-full" rows="2" name="description" required
                                      placeholder="Anything that needs to note ?" maxlength="200"></textarea>

                        </div>
                        <div class="plan-edit-button" >
                            <button>SAVE</button>
                        </div>
                    </form>   
                </div>



                <div class="row add-recipe-to-plan-section" id="addSection">
                    <div class="add-recipe-to-plan">
                        <div class="add-recipe-to-plan-section-header">
                            Add Recipes Section
                        </div>
                        <div class="add-recipe-to-plan-search-bar">
                            <form action="MainController" method="post">
                                <button type="submit" name="action" value="search"><img src="assets/search2.svg"
                                                                                        alt=""></button>
                                <input type="text" name="txtsearch" placeholder="What recipes are you searching for ?">
                                <select name="searchBy" id="" class="">
                                    <option value="Title" selected="selected">TITLE</option>
                                    <option value="Category">CATEGORIES</option>
                                    <option value="Cuisine">CUISINES</option>
                                    <option value="Diet">DIETS</option>
                                </select>
                            </form>
                        </div>
                        <div class="row add-recipe-to-plan-content">
                            <div class="col-md-3">
                                <div href="" class="add-recipe-to-plan-content-recipe">
                                    <div class="add-recipe-to-plan-content-recipe-image">
                                        <img src="./pictures/egg1.jpeg" alt="">
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-title">Chicken Curry</div>
                                    <div class="add-recipe-to-plan-content-recipe-nutrients">
                                        <p><span class="plan-table-calories">Cals</span>20</p>
                                        <p><span class="plan-table-protein">P</span> 29g</p>
                                        <p><span class="plan-table-carb">C</span> 24g</p>
                                        <p><span class="plan-table-fat">F</span> 434g</p>
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-button">
                                        <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan">
                                            Add
                                        </button>
                                        <button type="button">
                                            <a href="https://www.youtube.com/" target="_blank">View</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal -->
                            <div class="modal fade" id="addRecipeToPlan" tabindex="-1"
                                 aria-labelledby="addRecipeToPlanModalLabel" aria-hidden="true">
                                <form class="modal-dialog add-recipe-to-plan-modal">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Adding Recipe To Plan</h1>
                                        </div>
                                        <div class="modal-body">
                                            <div>
                                                <div>What day do you want to cook this recipe ?</div>
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Monday" name="Monday" value="Bike">
                                                        <label for="Monday"> Monday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Tuesday" name="Tuesday" value="Car">
                                                        <label for="Tuesday"> Tuesday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Wednesday" name="Wednesday" value="Boat">
                                                        <label for="Wednesday"> Wednesday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Thursday" name="Thursday" value="Bike">
                                                        <label for="Thursday"> Thursday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Friday" name="Friday" value="Boat">
                                                        <label for="Friday"> Friday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Saturday" name="Saturday" value="Boat">
                                                        <label for="Saturday"> Saturday</label>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="checkbox" id="Sunday" name="Sunday" value="Boat">
                                                        <label for="Sunday"> Sunday</label>
                                                    </div>
                                                </div>
                                                <!--                                                <div>What part of the day do you want to have this meal ?</div>
                                                                                                <div class="row">
                                                                                                    <div class="col-md-3">
                                                                                                        <input type="checkbox" id="Breakfast" name="Breakfast" value="Bike">
                                                                                                        <label for="Breakfast"> Breakfast</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-3">
                                                                                                        <input type="checkbox" id="Lunch" name="Lunch" value="Car">
                                                                                                        <label for="Lunch"> Lunch</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-3">
                                                                                                        <input type="checkbox" id="Dinner" name="Dinner" value="Boat">
                                                                                                        <label for="Dinner"> Dinner</label>
                                                                                                    </div>
                                                                                                </div>-->
                                                <label for="eating-time">What time of the day do you want to have this meal ?</label>
                                                <br>
                                                <input type="time" id="eating-time" name="eating-time">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Close</button>
                                            <button type="button" class="add-recipe-to-plan-modal-button">Add</button>
                                        </div>
                                    </div>
                                </form>
                            </div>



                            <div class="col-md-3">
                                <div href="" class="add-recipe-to-plan-content-recipe">
                                    <div class="add-recipe-to-plan-content-recipe-image">
                                        <img src="./pictures/egg1.jpeg" alt="">
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-title">Chicken Curry</div>
                                    <div class="add-recipe-to-plan-content-recipe-nutrients">
                                        <p><span class="plan-table-calories">Cals</span>20</p>
                                        <p><span class="plan-table-protein">P</span> 29g</p>
                                        <p><span class="plan-table-carb">C</span> 24g</p>
                                        <p><span class="plan-table-fat">F</span> 434g</p>
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-button">
                                        <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan">
                                            Add
                                        </button>
                                        <button type="button">
                                            <a href="https://www.youtube.com/" target="_blank">View</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div href="" class="add-recipe-to-plan-content-recipe">
                                    <div class="add-recipe-to-plan-content-recipe-image">
                                        <img src="./pictures/egg1.jpeg" alt="">
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-title">Chicken Curry</div>
                                    <div class="add-recipe-to-plan-content-recipe-nutrients">
                                        <p><span class="plan-table-calories">Cals</span>20</p>
                                        <p><span class="plan-table-protein">P</span> 29g</p>
                                        <p><span class="plan-table-carb">C</span> 24g</p>
                                        <p><span class="plan-table-fat">F</span> 434g</p>
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-button">
                                        <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan">
                                            Add
                                        </button>
                                        <button type="button">
                                            <a href="https://www.youtube.com/" target="_blank">View</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div href="" class="add-recipe-to-plan-content-recipe">
                                    <div class="add-recipe-to-plan-content-recipe-image">
                                        <img src="./pictures/egg1.jpeg" alt="">
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-title">Chicken Curry</div>
                                    <div class="add-recipe-to-plan-content-recipe-nutrients">
                                        <p><span class="plan-table-calories">Cals</span>20</p>
                                        <p><span class="plan-table-protein">P</span> 29g</p>
                                        <p><span class="plan-table-carb">C</span> 24g</p>
                                        <p><span class="plan-table-fat">F</span> 434g</p>
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-button">
                                        <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan">
                                            Add
                                        </button>
                                        <button type="button">
                                            <a href="https://www.youtube.com/" target="_blank">View</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div href="" class="add-recipe-to-plan-content-recipe">
                                    <div class="add-recipe-to-plan-content-recipe-image">
                                        <img src="./pictures/egg1.jpeg" alt="">
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-title">Chicken Curry</div>
                                    <div class="add-recipe-to-plan-content-recipe-nutrients">
                                        <p><span class="plan-table-calories">Cals</span>20</p>
                                        <p><span class="plan-table-protein">P</span> 29g</p>
                                        <p><span class="plan-table-carb">C</span> 24g</p>
                                        <p><span class="plan-table-fat">F</span> 434g</p>
                                    </div>
                                    <div class="add-recipe-to-plan-content-recipe-button">
                                        <button type="button" class="" data-bs-toggle="modal" data-bs-target="#addRecipeToPlan">
                                            Add
                                        </button>
                                        <button type="button">
                                            <a href="https://www.youtube.com/" target="_blank">View</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
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
