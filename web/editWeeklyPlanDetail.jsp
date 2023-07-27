<%-- 
    Document   : editWeeklyPlanDetail
    Created on : Jul 27, 2023, 11:30:41 AM
    Author     : khang
--%>

<%@page import="DTO.DateDTO"%>
<%@page import="DTO.PlanDTO"%>
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
        <%
            PlanDTO plan = (PlanDTO) request.getAttribute("plan");
            int planLength = (int) request.getAttribute("planLength");
        %>

        <div class="a1">
            <!--         The navigation bar       -->
            <%@include file="header.jsp" %>

            <!--         Recipe Plan       -->
            <div class="blank-background">
                <div class="container">
                    <div class="row add-plan">
                        <!--                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                                    <ol class="breadcrumb">
                                                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                                                        <li class="breadcrumb-item"><a href="UserController?action=planManagement"> Plan</a></li> 
                                                        <li class="breadcrumb-item"><a href="UserController?action=categoryLoadToPlan"> Add Plan</a></li> 
                                                        <li class="breadcrumb-item current-link" aria-current="page">Daily Plan</li>
                                                    </ol>
                                                </nav>-->




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
                                        <input type="date" id="startingDate" name="start_date" value="<%= plan.getStart_at()%>" onchange="calculateNewDate()" min="<%= LocalDate.now()%>" disabled="">
                                    </div>
                                </div>

                                <div class="col-md-6 add-plan-info-date">
                                    Plan's Length: <span>*</span>
                                    <div>
                                        <input type="number" id="length" name="planLength" onchange="calculateEndDate()" min='1' max='12' value="<%= planLength%>" required> 
                                    </div>
                                </div>
                                <div class="col-md-6 add-plan-info-date">
                                    End Date:
                                    <div id="endDate"><%= plan.getEnd_at()%></div>
                                </div>

                                <script>
                                    function calculateEndDate() {
                                        var startDate = new Date(document.getElementById("startingDate").value);
                                        var planLength = parseInt(document.getElementById("length").value);

                                        if (!isNaN(startDate) && !isNaN(planLength)) {
                                            // Increment end date by the length in weeks
                                            var endDate = new Date(startDate);
                                            endDate.setDate(endDate.getDate() + (planLength * 7) - 1);

                                            var endDateOptions = {year: 'numeric', month: 'numeric', day: 'numeric'};
                                            var endDateFormatted = endDate.toLocaleDateString(undefined, endDateOptions);

                                            document.getElementById("endDate").innerHTML = endDateFormatted;
                                        } else {
                                            document.getElementById("endDate").innerHTML = "";
                                        }
                                    }

                                    // Set the maximum date to 3 months from the current date
                                    var startDateInput = document.getElementById("startingDate");
                                    var currentDate = new Date();
                                    var maxDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 3, currentDate.getDate());
                                    var maxDateString = maxDate.toISOString().split("T")[0];
                                    startDateInput.max = maxDateString;
                                </script>

                            </div>
                            <div class="add-plan-info-header add-plan-info">
                                Plan Title <span>*</span>
                                <div>
                                    <input type="text" class="input-full" name="plan_title" value="<%= plan.getName()%>" disabled="">
                                </div>

                            </div>


                            <div class="add-plan-info-header add-plan-info">
                                Description <span>*</span>
                                <textarea class="input-full" rows="2" name="des" required
                                          placeholder="Give a small description of your plan" maxlength="200"><%= (plan.getDescription() != null) ? plan.getDescription() : ""%></textarea>
                            </div>
                            <div class="add-plan-info-header add-plan-info">
                                Note
                                <% if (plan.getNote() == null || plan.getNote().equals("")) { %>
                                <textarea class="input-full" rows="2" name="note" maxlength="200"
                                          placeholder="Anything that needs to note ?"
                                          ></textarea>
                                <% }else{
                                %>
                                <textarea class="input-full" rows="2" name="note" maxlength="200"
                                          placeholder="Anything that needs to note ?"
                                          ><%= plan.getNote() %></textarea>
                                <% }%>

                            </div>


                            <input type="hidden" name="id" value="<%= plan.getId()%>" />

                            <div class="plan-edit-button" >
                                <button type="submit" name="action" value="editPlanSave">SAVE</button>
                            </div>
                        </form> 

                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>

            <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>