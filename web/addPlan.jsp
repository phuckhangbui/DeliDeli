<%-- 
    Document   : addPlan
    Created on : Jun 22, 2023, 8:50:12 AM
    Author     : Walking Bag
--%>

<%@page import="DAO.DietDAO"%>
<%@page import="DTO.DietDTO"%>
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
        <div class="a1">
            <!--         The navigation bar       -->
            <%@include file="header.jsp" %>

            <!--         Recipe Plan       -->
            <div class="blank-background">
                <div class="container">
                    <div class="row add-plan">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item"><a href="#"> Plan</a></li> 
                                <li class="breadcrumb-item current-link" aria-current="page">Add Plan</li>
                            </ol>
                        </nav>
                        <form action="UserController" method="POST">
                            <div class="add-plan-header">
                                <p>Add a Plan</p>
                                <p>
                                    Create and customize your very own diet plan to keep track of your eating habits
                                </p>
                            </div>

                            <!--                            <div class="row add-plan-date">
                                                            <div class="add-plan-info-header">
                                                                Plan Period <span class="add-plan-info-header-des">(Weekly plan will have a fixed period of 1 week)</span>
                                                            </div>
                                                            <div class="col-md-6 add-plan-info-date">
                                                                Period:
                                                                <div>
                                                                    <input type="radio" id="dailyOption" name="period" value="daily" onchange="toggleEndDateField()"> Daily
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 add-plan-info-date">
                                                                <input type="radio" id="weeklyOption" name="period" value="weekly" onchange="toggleEndDateField()"> Weekly
                                                            </div>
                                                            <div class="col-md-6 add-plan-info-date">
                                                                Starting Date: <span>*</span>
                                                                <div>
                                                                    <input type="date" id="startingDate" name="start_date" onchange="" min="<%= LocalDate.now()%>" required>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 add-plan-info-date" id="endDateField" style="display: none;">
                                                                Ending Date: <span>*</span>
                                                                <div>
                                                                    <input type="date" id="endingDateWeekly" name="end_date" onchange="" min="<%= LocalDate.now()%>" required>
                                                                </div>
                                                            </div>
                                                        </div>-->

                            <script>
//                                function toggleEndDateField() {
//                                    const dailyOption = document.getElementById("dailyOption");
//                                    const endDateField = document.getElementById("endDateField");
//                                    endDateField.style.display = dailyOption.checked ? "block" : "none";
//                                }
//
//                                function calculateEndDate() {
//                                    const startingDate = document.getElementById("startingDate").value;
//                                    const periodOption = document.querySelector('input[name="period"]:checked').value;
//
//                                    if (periodOption === "daily") {
//                                        const endDateDaily = startingDate;
//                                        document.getElementById("endingDateWeekly").value = "";  // Clear the weekly end date
//                                        document.getElementById("endingDateDaily").value = endDateDaily;
//                                    } else if (periodOption === "weekly") {
//                                        const dateObj = new Date(startingDate);
//                                        dateObj.setDate(dateObj.getDate() + 6);
//                                        const endDateWeekly = dateObj.toISOString().split('T')[0];
//                                        document.getElementById("endingDateDaily").value = "";  // Clear the daily end date
//                                        document.getElementById("endingDateWeekly").value = endDateWeekly;
//                                    }
//                                }
                            </script>


                            <script>
//                                function toggleEndDateField() {
//                                    const dailyOption = document.getElementById("dailyOption");
//                                    const endDateField = document.getElementById("endDateField");
//                                    endDateField.style.display = dailyOption.checked ? "block" : "none";
//                                }
//
//                                function calculateEndDate() {
//                                    const startingDate = document.getElementById("startingDate").value;
//                                    const periodOption = document.querySelector('input[name="period"]:checked').value;
//
//                                    if (periodOption === "daily") {
//                                        const endDateDaily = startingDate;
//                                        document.getElementById("endingDateWeekly").value = "";  // Clear the weekly end date
//                                        document.getElementById("endingDateDaily").value = endDateDaily;
//                                    } else if (periodOption === "weekly") {
//                                        const dateObj = new Date(startingDate);
//                                        dateObj.setDate(dateObj.getDate() + 6);
//                                        const endDateWeekly = dateObj.toISOString().split('T')[0];
//                                        document.getElementById("endingDateDaily").value = "";  // Clear the daily end date
//                                        document.getElementById("endingDateWeekly").value = endDateWeekly;
//                                    }
//                                }
                            </script>


                            <div class="add-plan-info-header add-plan-info">
                                Plan Title <span>*</span>
                                <div>
                                    <input type="text" name="name" class="input-full" placeholder="What's your plan called ?" required>
                                </div>
                            </div>

                            <!--                            <div class="add-plan-info-header-picture add-plan-info">
                                                            Thumbnail Picture <span>*</span>
                                                            <div>
                                                                <input type="file" id="image" name="thumbnail" required>
                                                            </div>    
                                                        </div>-->
                            <div class="add-plan-info-header add-plan-info">
                                Description <span>*</span>
                                <textarea class="input-full" rows="2" name="description" required
                                          placeholder="Give a small description of your plan (Max: 200)" maxlength="200"></textarea>
                            </div>

                            <div class="add-plan-info-header add-plan-info">
                                Plan Diet <span>*</span>
                                <select name="recipeDietId" id="" class="add-plan-info-header-type" required>
                                    <%
                                        for (Map.Entry<Integer, String> entry
                                                : dietMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <option value="<%= key%>"> <%= value%> </option>
                                    <%
                                        }

                                    %>
                                </select>
                            </div>

                            <div class="row add-plan-date"> <!-- change cai nay thanh select -->
                                <div class="add-plan-info-header">
                                    Plan Period <span class="add-plan-info-header-des">(Weekly plan will have a fixed period of 1 week)</span>
                                </div>
                                <div class="col-md-6 add-plan-info-date">
                                    Period:
                                    <div>
                                        <input type="radio" id="dailyOption" name="period" value="daily" onchange="toggleEndDateField()"> Daily
                                    </div>

                                    <div class="col-md-6 add-plan-info-date">
                                        <input type="radio" id="weeklyOption" name="period" value="weekly" onchange="toggleEndDateField()"> Weekly
                                    </div>
                                </div>
                            </div>


                            <!-- Hidden Attributes -->
                            <input type="hidden" name="userId" value="<%= user.getId()%>" />

                            <p class="error-popup">${requestScope.errorList[0]}</p>

                            <div class=" add-recipe-info-submit">
                                <button type="submit" name="action" value="addPlan">
                                    Next
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>




        <!--         Footer       -->
        <%@include file="footer.jsp" %>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
