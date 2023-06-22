<%-- 
    Document   : planManagement
    Created on : Jun 22, 2023, 8:35:12 AM
    Author     : Walking Bag
--%>

<%@page import="DateFormat.DateNameChanger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Plan.PlanDAO"%>
<%@page import="Plan.PlanDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <div class="a1">
            <!--         The navigation bar       -->
            <%@include file="header.jsp" %>


            <!--         Recipe Plan       -->
            <div class="blank-background">
                <div class="container">
                    <div class="row weekly-plans ">
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
                            <a class="weekly-plans-add-content" href="addPlan.jsp">
                                <div>
                                    <img src="assets/add-black.svg" alt="">
                                </div>
                            </a>
                        </div>
                        <div class="col-md-6 ">
                            <div class="weekly-plans-plan active-plan">
                                <%
                                    ArrayList<PlanDTO> planList = PlanDAO.getAllUserPlanByUserID(user.getId());
                                    if (planList != null && planList.size() != 0) {
                                        for (PlanDTO list : planList) {
                                %>
                                <a href="MainController?action=getPlanDetailById&id=<%= list.getId() %>" class="weekly-plans-plan-content ">
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
                                            <%= formattedStartDate %> - <%= formattedEndDate %>
                                        </p>
                                    </div>
                                </a>
                                <form class="weekly-plans-plan-content-delete">
                                    <button type="button" data-bs-toggle="modal" data-bs-target="#deletePlanModal">
                                        <img src="assets/close.svg" alt="">
                                    </button>
                                </form>
                                <!-- Modal -->
                                <div class="modal fade" id="deletePlanModal" tabindex="-1"
                                     aria-labelledby="deletePlanModalLabel" aria-hidden="true">
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
                            </div>
                            <%
                                    }
                                }
                            %>
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
        </div>

        <!--      Bootstrap for JS         -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
