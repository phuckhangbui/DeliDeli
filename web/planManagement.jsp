<%-- 
    Document   : planManagement
    Created on : Jun 22, 2023, 8:35:12 AM
    Author     : Walking Bag
--%>

<%@page import="Utils.DateNameChanger"%>
<%@page import="DAO.PlanDAO"%>
<%@page import="DTO.PlanDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <div class="a1">
            <!--         Recipe Plan       -->
            <div class="blank-background">
                <div class="container">
                    <div class="row weekly-plans ">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                                <li class="breadcrumb-item current-link" aria-current="page">Plans List</li>
                            </ol>
                        </nav>
                        <div class="weekly-plans-header">
                            Plans Management
                        </div>
                        <div class="weekly-plans-navbar">
                            <div class="weekly-plans-navbar-status-active">
                                <span>a</span>
                                <span>Active</span>
                            </div>
                            <div class="weekly-plans-navbar-status-inactive">
                                <span>a</span>
                                <span>Inactive</span>
                            </div>
                        </div>
                        <div class="col-md-6 weekly-plans-add">
                            <a class="weekly-plans-add-content" href="UserController?action=categoryLoadToPlan">
                                <div>
                                    <img src="assets/add-icon-black.svg" alt="">
                                </div>
                            </a>
                        </div>
                        <%  ArrayList<PlanDTO> planList = (ArrayList<PlanDTO>) request.getAttribute("planList");
                            if (planList != null && planList.size() != 0) {
                                for (PlanDTO list : planList) {
                        %>
                        <div class="col-md-6 ">
                            <div class="weekly-plans-plan
                                 <%
                                     if (list.isStatus()) {
                                 %>
                                 active-plan
                                 <%
                                     }
                                 %>
                                 ">
                                <a href="UserController?action=getPlanDetailById&id=<%= list.getId()%>" class="weekly-plans-plan-content ">
                                    <div class="weekly-plans-plan-content-thumbnail">
                                        <img src="./pictures/plan1.jpg" alt="">
                                    </div>
                                    <div class="weekly-plans-plan-content-des">
                                        <p class="active-plan-content"><%= list.getName()%></p>
                                        <p><span>Description:</span> <%= list.getDescription()%></p>
                                        <%
                                            // Simple date format converter -> 06-23 => June 23rd
                                            Date start_date = list.getStart_at();
                                            Date end_date = list.getEnd_at();
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d", Locale.ENGLISH);
                                            String formattedStartDate = DateNameChanger.formatDateWithOrdinalIndicator(start_date, dateFormat);
                                            String formattedEndDate = DateNameChanger.formatDateWithOrdinalIndicator(end_date, dateFormat);
                                        %>
                                        <p><span>Period Date:</span>
                                            <%= formattedStartDate%> - <%= formattedEndDate%>
                                        </p>
                                    </div>
                                </a>
                                <div class="weekly-plans-plan-content-delete">
                                    <button type="button" data-bs-toggle="modal" data-bs-target="#deletePlanModal<%= list.getId()%>">
                                        <img src="assets/close-icon.svg" alt="">
                                    </button>
                                </div>
                                <!-- Modal -->
                                <div class="modal fade" id="deletePlanModal<%= list.getId()%>" tabindex="-1"
                                     aria-labelledby="deletePlanModalLabel" aria-hidden="true">
                                    <form action="UserController" method="POST" class="modal-dialog">
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

                                                <input type="hidden" name="plan_id" value="<%= list.getId()%>" />
                                                <input type="hidden" name="user_id" value="<%= user.getId()%>" />

                                                <button type="submit" name="action" value="deletePlanConfirmed" class="remove-recipe-from-plan-button">Yes, delete it</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    <%
                            }
                        }
                    %>   

                </div>
            </div>
        </div>
    </div>


    <!--         Footer       -->
    <%@include file="footer.jsp" %>


    <!--      Bootstrap for JS         -->
    <script src="bootstrap/js/bootstrap.min.js" ></script>
</body>
</html>
