<%-- 
    Document   : addDailyPlan
    Created on : Jul 15, 2023, 9:21:41 AM
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
                                <li class="breadcrumb-item current-link" aria-current="page">Daily Plan</li>
                            </ol>
                        </nav>
                        <form action="UserController" method="POST">
                            <div class="add-plan-header">
                                <p>Daily Plan</p>
                                <p>
                                    Create one plan for a day, use every other day
                                </p>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                Start Date: <span>*</span>
                                <div>
                                    <input type="date" id="startDateInput" name="start_date" onchange="calculateEndDate()" min="<%= LocalDate.now()%>" required>
                                </div>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                Plan's Length: <span>*</span>
                                <div>
                                    <input type="number" id="length" name="planLength" onchange="calculateEndDate()" min='1' max='365' required> 
                                </div>
                            </div>

                            <div class="col-md-6 add-plan-info-date">
                                End Date:
                                <div id="endDate"></div>
                            </div>

                            <script>
                                function calculateEndDate() {
                                    var startDate = new Date(document.getElementById("startDateInput").value);
                                    var planLength = parseInt(document.getElementById("length").value);

                                    if (!isNaN(startDate) && !isNaN(planLength)) {
                                        var endDate = new Date(startDate);
                                        endDate.setDate(endDate.getDate() + planLength);

                                        var endDateOptions = {year: 'numeric', month: 'numeric', day: 'numeric'};
                                        var endDateFormatted = endDate.toLocaleDateString(undefined, endDateOptions);

                                        document.getElementById("endDate").innerHTML = endDateFormatted;
                                    } else {
                                        document.getElementById("endDate").innerHTML = "";
                                    }
                                }

                                var startDateInput = document.getElementById("startDateInput");
                                var currentDate = new Date();
                                var maxDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 3, currentDate.getDate());
                                var maxDateString = maxDate.toISOString().split("T")[0];
                                startDateInput.max = maxDateString;
                            </script>




                            <div class=" add-recipe-info-submit">
                                <button type="submit" name="action" value="addDailyPlan">
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
