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
                                <li class="breadcrumb-item"><a href="UserController?action=planManagement"> Plans List</a></li>                                 
                                <li class="breadcrumb-item"><a href="UserController?action=categoryLoadToPlan"> Add Plan</a></li> 
                                <li class="breadcrumb-item current-link" aria-current="page">Plan's Length</li>
                            </ol>
                        </nav>
                        <form action="UserController" method="POST">
                            <div class="add-plan-header">
                                <p>Daily Plan</p>
                                <p>
                                    Create a plan for one day, use it every other day
                                </p>
                            </div>

                            <div class="row">
                                <div class="col-md-4 add-plan-info-header add-plan-info">
                                    Start Date <span>*</span>
                                    <div>
                                        <input type="date" id="startDateInput" name="start_date" onchange="calculateEndDate()" min="<%= LocalDate.now()%>" required>
                                    </div>
                                </div>


                                <div class="col-md-4 add-plan-info-date ">
                                    Plan's Length <span>*</span>
                                    <div>
                                        <input type="text" id="length" name="planLength" onchange="calculateEndDate()" min="1" max="30"
                                               oninput="this.value=this.value.slice(0,this.maxLength),this.value=this.value.replace(/[^0-9]/g,''), checkDayRange(this)"
                                               maxlength="2" required>
                                        <span class="add-plan-info-date-days">day(s)</span>
                                    </div>
                                </div>


                                <div class="col-md-4 add-plan-info-header add-plan-info">
                                    End Date
                                    <div id="endDate">
                                    </div>
                                </div>

                                <script>
                                    function checkDayRange(input) {
                                        input.setCustomValidity("");
                                        const value = parseInt(input.value);
                                        if (isNaN(value) || value < 1 || value > 30) {
                                            input.setCustomValidity("Please enter a number between 1 and 30 days.");
                                        }
                                    }

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
