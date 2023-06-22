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
        <div class="navigator-bar">
            <div class="container ">
                <div class="row navigation-bar-first">
                    <a href="homePage.html" class="logo col-md-3">
                        <img src="./assets/Logo2.png" alt="">
                    </a>
                    <div class="search-bar col-md-6">
                        <form action="" method="post" class="search-bar-content">
                            <input type="text" placeholder="What are you searching for ?">
                            <select name="" id="">
                                <option value="">TITLE</option>
                                <option value="">CATEGORY</option>
                                <option value="">INGREDIENT</option>
                                <option value="">CUISINES</option>
                            </select>
                            <button type="submit"><img src="./assets/search-button.svg" alt="Search Icon"></button>
                        </form>
                    </div>
                    <div class="account col-md-3">
                        <span><a href="logIn.html">Sign in</a></span>
                        <span>|</span>
                        <span><a href="register.html">Register</a></span>
                    </div>

                </div>
                <div class="row navigation-bar-last">
                    <ul class="navigation-bar-content">
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">INGREDIENTS</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CATEGORIES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CUISINES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">DIFFICULTIES</button>
                                <div class="dropdown-content">
                                    <a href="">1</a>
                                    <a href="">2</a>
                                    <a href="">3</a>
                                    <a href="searchResultPage.html">View More</a>
                                </div>
                            </div>
                        </li>
                        <li><a href="newsPage.html">NEWS</a></li>
                        <li><a href="">ABOUT US</a></li>
                    </ul>
                </div>
            </div>
        </div>


        <!--         Recipe Plan       -->
        <div class="blank-background">
            <div class="container">
                <div class="row plan">
                    <div class="edit-plan-header">
                        <p>Edit Plan</p>
                        <p>
                            Edit, add or remove recipes from your plan to fit more with your eating schedule
                        </p>
                    </div>



                    <div class="plan-edit">
                        <div class="add-plan-info-header add-plan-info">
                            Plan Title <span>*</span>
                            <div>
                                <input type="text" class="input-full" placeholder="What's your plan called ?">
                            </div>
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
                        <div class="add-plan-info-header add-plan-info">
                            Note <span>*</span>
                            <textarea class="input-full" rows="2" name="description" required
                                      placeholder="Anything that needs to note ?" maxlength="200"></textarea>

                        </div>
                    </div>



                    <div class="plan-navbar">
                        <button type="button" class="plan-navbar-remove" data-bs-toggle="modal"
                                data-bs-target="#removeAllRecipes">
                            Remove All Recipes
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="removeAllRecipes" tabindex="-1"
                             aria-labelledby="removeAllRecipesModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ...
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <button type="button" class="plan-navbar-delete" data-bs-toggle="modal"
                                data-bs-target="#deletePlanConfirm">
                            Delete Plan
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="deletePlanConfirm" tabindex="-1"
                             aria-labelledby="deletePlanConfirmModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ...
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- <button class="plan-navbar-edit">
                                <a href="userViewPlan.html"><img src="./assets/leave.svg" alt=""></a>
                            </button> -->
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
                </div>
                <div class="row add-recipe-to-plan-section">
                    <div class="add-recipe-to-plan">
                        <div class="add-recipe-to-plan-search-bar">
                            <form action="MainController" method="post">
                                <button type="submit" name="action" value="search"><img src="assets/search2.svg"
                                                                                        alt=""></button>
                                <input type="text" name="txtsearch" placeholder="What are you searching for ?">
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
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            ...
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
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
