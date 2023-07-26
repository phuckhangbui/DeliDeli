<%-- 
    Document   : addWeeklyPlan
    Created on : Jul 15, 2023, 6:47:11 PM
    Author     : khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                                <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                                <li class="breadcrumb-item"><a href="UserController?action=planManagement"> Plan</a></li> 
                                <li class="breadcrumb-item"><a href="UserController?action=categoryLoadToPlan"> Add Plan</a></li> 
                                <li class="breadcrumb-item current-link" aria-current="page">Weekly Plan</li>
                            </ol>
                        </nav>
                        <form action="UserController" method="POST">
                            <div class="add-plan-header">
                                <p>Weekly Plan</p>
                                <p>
                                    Create one plan for a week, use every other week
                                </p>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                Start Date: <span>*</span>
                                <div>
                                    <input type="date" id="startDateInput" name="start_date" onchange="calculateEndDate()" required min="<%= LocalDate.now()%>">
                                </div>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                Plan's Length: <span>*</span>
                                <div>
                                    <input type="number" id="length" name="planLength" onchange="calculateEndDate()" min="1" max="52" required> week(s)
                                </div>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                End Date:
                                <div id="endDate"></div>
                            </div>

                            <script>
                                function isMonday(date) {
                                    if (date.getDay() === 1) {
                                        return true; // Monday
                                    } else {
                                        alert("Please select a Monday as the start date.");
                                        return false;
                                    }
                                }
                                function calculateEndDate() {
                                    var startDate = new Date(document.getElementById("startDateInput").value);
                                    var planLength = parseInt(document.getElementById("length").value);

                                    if (!isNaN(startDate) && !isNaN(planLength) && isMonday(startDate)) {
                                        // Increment end date by the length in weeks
                                        var endDate = new Date(startDate);
                                        endDate.setDate(endDate.getDate() + (planLength * 7));

                                        var endDateOptions = {year: 'numeric', month: 'numeric', day: 'numeric'};
                                        var endDateFormatted = endDate.toLocaleDateString(undefined, endDateOptions);

                                        document.getElementById("endDate").innerHTML = endDateFormatted;
                                    } else {
                                        document.getElementById("endDate").innerHTML = "";
                                    }
                                }

                                // Set the maximum date to 3 months from the current date
                                var startDateInput = document.getElementById("startDateInput");
                                var currentDate = new Date();
                                var maxDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 3, currentDate.getDate());
                                var maxDateString = maxDate.toISOString().split("T")[0];
                                startDateInput.max = maxDateString;
                            </script>







                            <div class=" add-recipe-info-submit">
                                <button type="submit" name="action" value="addWeeklyPlan">
                                    Next
                                </button>
                            </div>
                        </form>    

                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>

            <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
