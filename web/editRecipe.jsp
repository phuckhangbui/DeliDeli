<%-- 
    Document   : editRecipe
    Created on : Jun 8, 2023, 3:03:20 PM
    Author     : khang
--%>

<%@page import="java.util.Set"%>
<%@page import="Nutrition.NutritionDAO"%>
<%@page import="Nutrition.NutritionDTO"%>
<%@page import="Nutrition.NutritionDTO"%>
<%@page import="RecipeDiet.RecipeDietDTO"%>
<%@page import="RecipeDiet.RecipeDietDTO"%>
<%@page import="RecipeDiet.RecipeDietDAO"%>
<%@page import="Direction.DirectionDAO"%>
<%@page import="IngredientDetail.IngredientDetailDAO"%>
<%@page import="IngredientDetail.IngredientDetailDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="Recipe.RecipeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html lang="en">

    <head>
        <title>Edit Recipe</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--      Bootstrap         -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>

        <link rel="stylesheet" href="./styles/recipeStyle.css">
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <script src="https://cdn.ckeditor.com/4.16.2/basic/ckeditor.js"></script>
        <script src="./script/ingredientScript.js" defer></script>
        <script src="./script/directionScript.js" defer></script>

    </head>

    <body>
        <!--         The navigation bar       -->
        <%@include file="header.jsp" %>

        <%
            Gson gson = new Gson();
            String ingredientJson = gson.toJson(ingredientMap);
        %>
        <script>
            // Access the JSON string in JavaScript
            var hashMap = JSON.parse('<%= ingredientJson%>');
            // Now, you can work with the hashMap object in JavaScript
            // ...
        </script>

        <%
            int recipeId = Integer.parseInt(request.getParameter("recipeId"));
            try {
                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(recipeId);
                if (recipe.getUser_id() == user.getId()) {

        %>
        <div class="blank-background">
            <div class="container">
                <div class="row add-recipe-info">
                    <form id="addRecipe" action="MainController" enctype="multipart/form-data" method="post">
                        <div class="add-recipe-header">

                            <p>Edit Recipe</p>
                            <p>
                                Customize your very own recipe to share with the world your own unique flavor
                            </p>
                        </div>
                        <input name="recipeId" value="<%=recipe.getId()%>" type="text" hidden=""/>
                        <div class="add-recipe-info-overview">
                            <div class="add-recipe-info-header">
                                Recipe Title
                                <div>
                                    <input class="input-full" type="text" name="title" required
                                           placeholder="What's your recipe called ?" maxlength="100"
                                           value="<%= recipe.getTitle()%>">
                                </div>
                            </div>
                            <div class="add-recipe-info-header">
                                Description
                                <textarea class="input-full" rows="5" name="description" required
                                          placeholder="Give us a summary of your recipe" maxlength="500"><%= recipe.getDescription()%>
                                </textarea>
                            </div>


                            <div class="row add-recipe-info-overview-picture">
                                <div class="col-md-6 add-recipe-info-overview-picture-main">
                                    <div class="add-recipe-info-header-secondary">
                                        Thumbnail Picture
                                    </div> <!-- ti chinh lại thành required-->
                                    <input type="file" id="image" name="thumbnail">
                                </div>
                                <div class="col-md-6 add-recipe-info-overview-picture-optional">
                                    <div class="add-recipe-info-header-secondary">
                                        Additional Picture <p>(optional)</p>
                                    </div>
                                    <input type="file" id="image" name="picture">
                                </div>

                                <script>
                                    // Get all file input elements
                                    var fileInputs = document.querySelectorAll('input[type="file"]');

                                    // Add event listeners for the "change" event
                                    fileInputs.forEach(function (fileInput) {
                                        fileInput.addEventListener('change', validateFile);
                                    });

                                    // File validation function
                                    function validateFile(event) {
                                        var file = event.target.files[0];
                                        if (file) {
                                            if (file.type.startsWith('image/')) {
                                            } else {
                                                alert('Please select an image file.');
                                                event.target.value = ''; // Reset the file input value
                                            }
                                        } else {
                                            alert('Please select a file.');
                                        }
                                    }
                                </script>

                                <p>(Add nothing if you want to keep the old one)</p>
                            </div>
                        </div>
                        <div class="row add-recipe-info-number">
                            <div class="add-recipe-info-header">Overview</div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Serving:</div>
                                <input type="text" name="servings" required
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="3" value="<%= recipe.getServings()%>">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Prep Time:</div>
                                <input type="text" id="prepTime" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5" value="<%=recipe.getPrep_time()%>">
                                <select id="prepTimeUnit">
                                    <option value="minutes" checked="">minutes</option>
                                    <option value="hours">hours</option>
                                    <option value="days">days</option>
                                </select>
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Cook Time:</div>
                                <input type="text" id="cookTime" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5" value="<%=recipe.getCook_time()%>">
                                <select id="cookTimeUnit">
                                    <option value="minutes" selected="">minutes</option>
                                    <option value="hours">hours</option>
                                    <option value="days">days</option>
                                </select>
                            </div>
                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Total Time:
                                    <p id="totalTime"></p>
                                    <script>
                                        calculateTotalTime();
                                        function calculateTotalTime() {
                                            var prepTime = parseInt(document.getElementById("prepTime").value);
                                            var cookTime = parseInt(document.getElementById("cookTime").value);
                                            var prepTimeUnit = document.getElementById("prepTimeUnit").value;
                                            var cookTimeUnit = document.getElementById("cookTimeUnit").value;

                                            // Check if the input values are valid numbers
                                            if (isNaN(prepTime)) {
                                                prepTime = 0;
                                            }
                                            if (isNaN(cookTime)) {
                                                cookTime = 0;
                                            }

                                            // Calculate prep time in minutes
                                            var prepTimeMinute = 0;

                                            if (prepTimeUnit === "minutes") {
                                                prepTimeMinute = prepTime;
                                            } else if (prepTimeUnit === "hours") {
                                                prepTimeMinute = prepTime * 60;
                                            } else if (prepTimeUnit === "days") {
                                                prepTimeMinute = prepTime * 60 * 24;
                                            }

                                            // Calculate total minutes
                                            var cookTimeMinute = 0;

                                            if (cookTimeUnit === "minutes") {
                                                cookTimeMinute = cookTime;
                                            } else if (cookTimeUnit === "hours") {
                                                cookTimeMinute = cookTime * 60;
                                            } else if (cookTimeUnit === "days") {
                                                cookTimeMinute = cookTime * 60 * 24;
                                            }

                                            var totalMinutes = prepTimeMinute + cookTimeMinute;
                                            var form = document.getElementById("addRecipe");
                                            // Create hidden input field for prep time in minutes
                                            // Check if the prepTimeMinutes input field exists
                                            var prepTimeMinutesInput = document.querySelector('input[name="prepTimeMinutes"]');
                                            if (prepTimeMinutesInput !== null) {
                                                // Update the value of the existing input field
                                                prepTimeMinutesInput.value = prepTimeMinute;
                                            } else {
                                                // Create a new hidden input field
                                                prepTimeMinutesInput = document.createElement("input");
                                                prepTimeMinutesInput.type = "hidden";
                                                prepTimeMinutesInput.name = "prepTimeMinutes";
                                                prepTimeMinutesInput.value = prepTimeMinute;

                                                // Append the new input field to the form

                                                form.appendChild(prepTimeMinutesInput);
                                            }

// Repeat the same process for cookTimeMinutes input field
                                            var cookTimeMinutesInput = document.querySelector('input[name="cookTimeMinutes"]');
                                            if (cookTimeMinutesInput !== null) {
                                                cookTimeMinutesInput.value = cookTimeMinute;
                                            } else {
                                                cookTimeMinutesInput = document.createElement("input");
                                                cookTimeMinutesInput.type = "hidden";
                                                cookTimeMinutesInput.name = "cookTimeMinutes";
                                                cookTimeMinutesInput.value = cookTimeMinute;

                                                form.appendChild(cookTimeMinutesInput);
                                            }



                                            // Convert minutes to days, hours, and minutes
                                            var days = Math.floor(totalMinutes / (60 * 24));
                                            var hours = Math.floor((totalMinutes % (60 * 24)) / 60);
                                            var minutes = totalMinutes % 60;

                                            // Display the total time
                                            var totalTimeText = "";
                                            if (days > 0) {
                                                totalTimeText += days + " day ";
                                            }
                                            if (hours > 0) {
                                                totalTimeText += hours + " hour ";
                                            }
                                            if (minutes > 0) {
                                                totalTimeText += minutes + " mins";
                                            }
                                            document.getElementById("totalTime").textContent = totalTimeText.trim();
                                        }
                                        // Attach event listener to cookTime input
                                        document.getElementById("cookTime").addEventListener("input", calculateTotalTime);
                                        document.getElementById("cookTimeUnit").addEventListener("change", calculateTotalTime);

                                        document.getElementById("prepTime").addEventListener("input", calculateTotalTime);
                                        document.getElementById("prepTimeUnit").addEventListener("change", calculateTotalTime);

                                    </script>
                                </div>
                            </div>


                            <div class="row add-recipe-info-type">

                                <div class="col-md-3 add-recipe-info-type-content">
                                    <div>Category:</div>
                                    <select name="category">
                                        <%for (Map.Entry<Integer, String> entry : cateMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();
                                                if (recipe.getCategory_id() == key) {
                                        %>

                                        <option value="<%=key%>" selected=""><%=value%></option>
                                        <% } else {%>
                                        <option value="<%=key%>"><%=value%></option>
                                        <% }
                                            }%>
                                    </select>
                                </div>
                                <div class="col-md-3 add-recipe-info-type-content">
                                    <div>Cuisine:</div>
                                    <select name="cuisine">
                                        <%for (Map.Entry<Integer, String> entry : cuisineMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();
                                                if (recipe.getCuisine_id() == key) {
                                        %>

                                        <option value="<%=key%>" selected=""><%=value%></option>
                                        <% } else {%>
                                        <option value="<%=key%>"><%=value%></option>
                                        <% }
                                            }%>
                                    </select>
                                </div>

                                <div class="col-md-3 add-recipe-info-type-content">
                                    <div>Difficulties</div>
                                    <select name="level">
                                        <%for (Map.Entry<Integer, String> entry : levelMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();
                                                if (recipe.getLevel_id() == key) {
                                        %>

                                        <option value="<%=key%>" selected=""><%=value%></option>
                                        <% } else {%>
                                        <option value="<%=key%>"><%=value%></option>
                                        <% }
                                            }%>
                                    </select>
                                </div>

                                <div class="col-md-12 add-recipe-info-type-content">
                                    <div>Diet: <span>(If the diet you're looking for is not here, then no need to tick any of these boxes )</span></div>
                                    <%
                                        Set<Integer> dietSet = RecipeDietDAO.getDietSetByRecipeId(recipeId);
                                        if (dietSet.size() == 0) { %>
                                    <div class="">
                                        <% for (Map.Entry<Integer, String> entry : dietMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();
                                        %>
                                        <input type="checkbox" name="diet" value="<%= key%>" style="padding-left: 10px;">
                                        <label for="diet" style="padding-right: 10px;"><%= value%></label>
                                        <%}%>
                                    </div>
                                    <% } else {

                                    %>


                                    <div class="">
                                        <%  for (Map.Entry<Integer, String> entry : dietMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();
                                                if (dietSet.contains(key)) {
                                        %>
                                        <input type="checkbox" name="diet" value="<%= key%>" checked="" style="padding-left: 10px;">
                                        <label for="diet" style="padding-right: 10px;"><%= value%></label>
                                        <% } else {%>
                                        <input type="checkbox" name="diet" value="<%= key%>" style="padding-left: 10px;">
                                        <label for="diet" style="padding-right: 10px;"><%= value%></label>
                                        <% }
                                            }%>
                                    </div>

                                    <%
                                        } %>

                                </div>

                            </div>
                        </div>
                        <div class="row add-recipe-info-number">
                            <div class="add-recipe-info-header">Nutrition <span class="add-recipe-info-header-des">(Per serving)</span> <span>*</span></div>
                            <div>
                                For references:
                                <button>Nutrition Table</button>
                            </div>
                            <% NutritionDTO nutrition = NutritionDAO.getNutrition(recipeId);%>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Calories:</div>
                                <input type="text" id="" name="calories" required max="100" min="1"
                                       value="<%= nutrition.getCalories()%>"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="4">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Fat (grams):</div>
                                <input type="text" id="" name="fat" required max="100" min="1"
                                       value="<%= nutrition.getFat()%>"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="3">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Carbs (grams):</div>
                                <input type="text" id="" name="carbs" required max="100" min="1"
                                       value="<%= nutrition.getCarbs()%>"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="3">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Protein (grams):</div>
                                <input type="text" id="" name="protein" required max="100" min="1"
                                       value="<%= nutrition.getProtein()%>"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="3">
                            </div>
                        </div>

                        <div class="row add-recipe-info-ingredient">
                            <div class="draggable-container-ingredient col-md-8 add-recipe-info-ingredient-content">
                                <div class="add-recipe-info-header">Ingredient</div>
                                <%
                                    ArrayList<IngredientDetailDTO> ingredientList = IngredientDetailDAO.getIngredientDetailByRecipeId(recipe.getId());
                                    for (IngredientDetailDTO i : ingredientList) {
                                %>
                                <p class="draggable-ingredient draggable" draggable="false">
                                    <input type="text" class="input" name="ingredientDesc" required="" value="<%= i.getDesc()%>">
                                    <select class="ingredientList" name="ingredientId">
                                        <%
                                            for (Map.Entry<Integer, String> entry : ingredientMap.entrySet()) {
                                                Integer key = entry.getKey();
                                                String value = entry.getValue();

                                                if (i.getIngredient_id() == key) {
                                        %>
                                        <option value="<%=key%>" selected=""><%=value%></option>   
                                        <% } else {%>
                                        <option value="<%=key%>"><%=value%></option>   

                                        }
                                        <%
                                                }
                                            }%>
                                    </select>
                                    <button type="button" class="btnDeleteIngredient">
                                        <img src="assets/close.svg" alt="">
                                    </button>
                                </p>
                                <%}%>
                            </div>
                            <div class="col-md-4 add-recipe-info-ingredient-button">
                                <button type="button" id="btnToggleIngredient">
                                    <img src="assets/drag.svg" alt="">
                                </button>
                                <button type="button" id="btnAddIngredient">
                                    Add Paragraph
                                </button>
                            </div>
                        </div>



                        <div class="add-recipe-info-header">Direction:</div>
                        <p><textarea name="direction" rows="10" cols="10" id="editor" 
                                     value="<%=user.getId()%>"><%= DirectionDAO.getDirectionByRecipeId(recipe.getId()).getDesc()%></textarea></p>
                        <script>
                            CKEDITOR.replace('editor');
                        </script>

                        <div class=" add-recipe-info-status">
                            <div class="add-recipe-info-header">
                                Do you want to make this recipe public?
                            </div>
                            <div class="add-recipe-info-status-content">
                                <%
                                    if (recipe.getStatus() != 1) {
                                %>
                                <div>
                                    <input type="radio" name="status" value="2" checked>Yes, make it public
                                    <span>(Your recipe will be submitted and will be checked by our moderator. This may take
                                        some time)</span>

                                </div>
                                <div>
                                    <input type="radio" name="status" value="1">No, make it private
                                    <span>(Your recipe won't need to go through our moderator team, but the recipe can
                                        only be view by you)</span>

                                </div>
                                <% } else {%>
                                <div>
                                    <input type="radio" name="status" value="2" >Yes, make it public
                                    <span>(Your recipe will be submitted and will be checked by our moderator. This may take
                                        some time)</span>

                                </div>
                                <div>
                                    <input type="radio" name="status" value="1" checked>No, make it private
                                    <span>(Your recipe won't need to go through our moderator team, but the recipe can
                                        only be view by you)</span>

                                </div>
                                <% }%>
                            </div>
                        </div>
                        <input type="text" name="userId" value="<%=user.getId()%>" hidden/>
                        <div class=" add-recipe-info-submit">
                            <button type="submit" name="action" value="editRecipe">
                                EDIT
                            </button>
                            <span></span>
                            <!--Goi MainController?action=deleteRecipe  -->
                            <button type="button" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                DELETE
                            </button>
                        </div>

                        <!-- modal -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="popup-confirm">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">CONFIRMATION</h1>
                                        </div>
                                        <div class="modal-body">
                                            Pressing delete will remove your recipe from this site forever, are you sure you still want to delete it ?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I changed my mind</button>
                                            <button type="button" class="btn btn-danger" id="deleteButton">Yes, delete it</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>
                            var deleteButton = document.getElementById("deleteButton");
                            deleteButton.addEventListener("click", function () {
                                // Perform your deletion logic here
                                var recipeId = '<%= recipe.getId()%>'; // Replace with the actual recipe ID
                                var userId = '<%= user.getId()%>'; // Replace with the actual user ID

                                // Send an AJAX request to the servlet for handling the deletion
                                var xhr = new XMLHttpRequest();
                                xhr.open("POST", "MainController", true);
                                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                xhr.onreadystatechange = function () {
                                    if (xhr.readyState === 4 && xhr.status === 200) {
                                        // Handle the response from the server
                                        console.log(xhr.responseText);

                                        // Hide the modal
                                        var modal = document.getElementById("deleteModal");
                                        var modalInstance = bootstrap.Modal.getInstance(modal);
                                        modalInstance.hide();

                                        // Redirect to home.jsp
                                        window.location.href = "home.jsp";
                                    }
                                };
                                xhr.send("action=deleteRecipe&recipeId=" + recipeId + "&userId=" + userId);
                            });

                        </script>

                    </form>
                </div>
            </div>
        </div>

        <%}
            } catch (Exception e) {

            }
        %>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <script src="bootstrap/js/bootstrap.min.js" ></script>

    </body>

</html>
