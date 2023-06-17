<%-- 
    Document   : addRecipe
    Created on : Jun 7, 2023, 7:45:19 AM
    Author     : khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html lang="en">

    <head>
        <title>Add Recipe</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--      Bootstrap         -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link rel="stylesheet" href="./styles/recipeStyle.css">
        <link rel="stylesheet" href="./styles/userStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <script src="https://cdn.ckeditor.com/4.16.2/basic/ckeditor.js"></script>
        <script src="./script/ingredientScript.js" defer></script>

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

        <div class="blank-background">
            <div class="container">
                <div class="row add-recipe-info">
                    <form id="addRecipe" action="MainController" enctype="multipart/form-data" method="post">
                        <div class="add-recipe-header">
                            <p>Add a New Recipe</p>
                            <p>
                                Create and customize your very own recipe to share with the world your own unique flavor
                            </p>
                        </div>
                        <div class="add-recipe-info-overview">
                            <div class="add-recipe-info-header">
                                Recipe Title <span>*</span>
                                <div>
                                    <input class="input-full" type="text" name="title" required
                                           placeholder="What's your recipe called ?" maxlength="100">
                                </div>
                            </div>
                            <div class="add-recipe-info-header">
                                Description <span>*</span>
                                <textarea class="input-full" rows="5" name="description" required
                                          placeholder="Give us a summary of your recipe" maxlength="500"></textarea>
                            </div>


                            <div class="row add-recipe-info-overview-picture">
                                <div class="col-md-6 add-recipe-info-overview-picture-main">
                                    <div class="add-recipe-info-header-secondary">
                                        Thumbnail Picture
                                        <p>*</p>
                                    </div> <!-- ti chinh lại thành required-->
                                    <input type="file" id="image" name="thumbnail" required>
                                </div>
                                <div class="col-md-6 add-recipe-info-overview-picture-optional">
                                    <div class="add-recipe-info-header-secondary">
                                        Additional Picture <p>(optional)</p>
                                    </div>
                                    <input type="file" id="image" name="pictures">
                                </div>

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


                        </div>
                        <div class="row add-recipe-info-number">
                            <div class="add-recipe-info-header">Overview <span>*</span></div>
                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Serving:</div>
                                <input type="text" name="servings" required
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="3">
                            </div>
                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Prep Time:</div>
                                <input type="text" id="prepTime" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                                <select id="prepTimeUnit">
                                    <option value="minutes">minutes</option>
                                    <option value="hours">hours</option>
                                    <option value="days">days</option>
                                </select>
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Cook Time:</div>
                                <input type="text" id="cookTime" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                                <select id="cookTimeUnit">
                                    <option value="minutes">minutes</option>
                                    <option value="hours">hours</option>
                                    <option value="days">days</option>
                                </select>
                            </div>
                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Total Time:
                                    <p id="totalTime"></p>
                                    <script>
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
                            
                        </div>
                        <div class="row add-recipe-info-type">

                            <div class="col-md-3 add-recipe-info-type-content">
                                <div>Category:</div>
                                <select name="category">
                                    <%for (Map.Entry<Integer, String> entry : cateMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();

                                    %>
                                    <option value="<%=key%>"><%=value%></option>
                                    <% }%>
                                </select>
                            </div>
                            <div class="col-md-3 add-recipe-info-type-content">
                                <div>Cuisine:</div>
                                <select name="cuisine">
                                    <%for (Map.Entry<Integer, String> entry : cuisineMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();

                                    %>
                                    <option value="<%=key%>"><%=value%></option>
                                    <% }%>
                                </select>
                            </div>

                            <div class="col-md-3 add-recipe-info-type-content">
                                <div>Difficulties:</div>
                                <select name="level">
                                    <%for (Map.Entry<Integer, String> entry : levelMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();

                                    %>
                                    <option value="<%=key%>"><%=value%></option>
                                    <% }%>
                                </select>
                            </div>
                                


                            <div class="col-md-12 add-recipe-info-type-content">
                                <div>Diet: <span>(If the diet you're looking for is not here, then no need to tick any of these boxes )</span></div>
                                
                                <div class="">
                                    <% for (Map.Entry<Integer, String> entry : dietMap.entrySet()) {
                                            Integer key = entry.getKey();
                                            String value = entry.getValue();
                                    %>
                                    <input type="checkbox" name="diet" value="<%= key%>" style="padding-left: 10px;">
                                    <label for="diet" style="padding-right: 10px;"><%= value%></label>
                                    <% }%>
                                </div>
                            </div>
                        </div>
                                
                                
                        <div class="row add-recipe-info-number">
                            <div class="add-recipe-info-header">Nutrition <span class="add-recipe-info-header-des">(Per serving)</span> <span>*</span></div>
                            <div>
                                For references:
                                <button>Nutrition Table</button>
                            </div>
                            

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Calories:</div>
                                <input type="text" id="" name="calories" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Fat (grams):</div>
                                <input type="text" id="" name="fat" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Carbs (grams):</div>
                                <input type="text" id="" name="carbs" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                            </div>

                            <div class="col-md-3 add-recipe-info-number-content">
                                <div>Protein (grams):</div>
                                <input type="text" id="" name="protein" required max="100" min="1"
                                       oninput="this.value=this.value.slice(0,this.maxLength),this.value = this.value.replace(/[^0-9]/g, '')"
                                       maxlength="5">
                            </div>
                        </div>






                        <div class="row add-recipe-info-ingredient">
                            <div class="draggable-container-ingredient col-md-8 add-recipe-info-ingredient-content">
                                <div class="add-recipe-info-header">Ingredient <span>*</span></div>
                                <p class="draggable-ingredient draggable" draggable="false">
                                    <input type="text" class="input" name="ingredientDesc" required="">
                                    <select class="ingredientList" name="ingredientId"></select>
                                    <button type="button" class="btnDeleteIngredient">
                                        <img src="assets/close.svg" alt="">
                                    </button>
                                </p>
                                <p class="draggable-ingredient draggable" draggable="false">
                                    <input type="text" class="input" name="ingredientDesc" required="">
                                    <select class="ingredientList" name="ingredientId"></select>
                                    <button type="button" class="btnDeleteIngredient">
                                        <img src="assets/close.svg" alt="">
                                    </button>
                                </p>
                            </div>
                            <div class="col-md-4 add-recipe-info-ingredient-button">
                                <button type="button" id="btnToggleIngredient">
                                    <img src="assets/drag.svg" alt="">
                                </button>
                                <button type="button" id="btnAddIngredient">
                                    Add Ingredient
                                </button>
                            </div>
                        </div>






                        <div class="add-recipe-info-header">Direction <span>*</span></div>
                        <p><textarea name="direction" rows="10" cols="10" id="editor" value="<%=user.getId()%>"></textarea></p>
                        <script>
                            CKEDITOR.replace('editor');
                        </script>





                        <div class=" add-recipe-info-status">
                            <div class="add-recipe-info-header">
                                Do you want to make this recipe public?
                            </div>
                            <div class="add-recipe-info-status-content">
                                <label>
                                    <input type="radio" name="status" value="2" checked>Yes, make it public
                                    <span>(Your recipe will be submitted and will be checked by our moderator. This may take
                                        some time)</span>

                                </label>
                                <label>
                                    <input type="radio" name="status" value="1">No, make it private
                                    <span>(Your recipe won't need to go through our moderator team, but the recipe can
                                        only be view by you)</span>

                                </label>
                            </div>
                        </div>
                        <input type="text" name="userId" value="<%=user.getId()%>" hidden/>
                        <div class=" add-recipe-info-submit">
                            <button type="submit" name="action" value="addRecipe">
                                SUBMIT
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!--         Footer       -->
        <%@include file="footer.jsp" %>
    </body>

</html>
