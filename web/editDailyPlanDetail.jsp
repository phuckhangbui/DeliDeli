<%-- 
    Document   : editDailyPlanDetail
    Created on : Jul 26, 2023, 9:36:22 AM
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
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
    <!--                            <li class="breadcrumb-item"><a href="UserController?action=editPlan&id=<%= plan.getId()%>&isSearch=false"> Plan - <%= plan.getName()%> </a></li>-->
                                <li class="breadcrumb-item"><a href="UserController?action=planManagement&userId=<%=user.getId()%>"> Plans List </a></li> 
                                <li class="breadcrumb-item" aria-current="page"><a href="UserController?action=getPlanDetailById&id=<%= plan.getId()%>"> <%= plan.getName()%> </a></li>
                                <li class="breadcrumb-item current-link" aria-current="page">Edit Info</li>
                            </ol>
                        </nav>
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
                            <div class="add-plan-header">

                                <p>Info Section</p>
                                <p>
                                    Add, edit or remove information about your plan
                                </p>
                            </div>
                            <br>
                            <div class="row add-plan-date ">
                                <div class="col-md-4 add-plan-info-date">
                                    Starting Date <span>*</span>
                                    <div>
                                        <input type="date" id="startingDate" name="start_date" value="<%= plan.getStart_at()%>" onchange="calculateNewDate()" min="<%= LocalDate.now()%>" disabled="">
                                    </div>
                                </div>

                                <div class="col-md-4 add-plan-info-date">
                                    Plan's Length <span>*</span>
                                    <div> 
                                        <input type="text" id="length" name="planLength" onchange="calculateEndDate()" min="1" max="30"
                                               oninput="this.value=this.value.slice(0,this.maxLength),this.value=this.value.replace(/[^0-9]/g,''), checkDayRange(this)"
                                               value="<%= planLength%>" maxlength="2" required>
                                        <span class="add-plan-info-date-days">day(s)</span>
                                    </div>
                                </div>
                                <div class="col-md-4 add-plan-info-date">
                                    End Date
                                    <div id="endDate"><%= plan.getEnd_at()%></div>
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
                                        var startDate = new Date(document.getElementById("startingDate").value);
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
                                <% } else {
                                %>
                                <textarea class="input-full" rows="2" name="note" maxlength="200"
                                          placeholder="Anything that needs to note ?"
                                          ><%= plan.getNote()%></textarea>
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
