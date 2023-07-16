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
                                <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                                <li class="breadcrumb-item"><a href="UserController?action=planManagement"> Plan</a></li> 
                                <li class="breadcrumb-item current-link" aria-current="page">Add Plan</li>
                            </ol>
                        </nav>
                        <%
                            
                            String title = (String) session.getAttribute("createPlanTitle");
                            String des = (String) session.getAttribute("createPlanDescription");


                        %>
                        <form action="UserController" method="POST">
                            <div class="add-plan-header">
                                <p>Add a Plan</p>
                                <p>
                                    Create and customize your very own diet plan to keep track of your eating habits
                                </p>
                            </div>

                            <div class="add-plan-info-header add-plan-info">
                                Plan Title <span>*</span>
                                <div>
                                    <% if (title != null) {%>
                                    <input type="text" name="title" class="input-full" value="<%=title%>" maxlength="100" required>
                                    <% } else {%>

                                    <input type="text" name="title" class="input-full" placeholder="What's your plan called ?" maxlength="100" required>
                                    <%}%>
                                </div>
                            </div>


                            <div class="add-plan-info-header add-plan-info">
                                Description <span>*</span>
                                <% if (title != null) {%>
                                <textarea class="input-full" rows="2" name="description" required maxlength="200"><%= des%></textarea>
                                <% } else { %>
                                <textarea class="input-full" rows="2" name="description" required placeholder="Give a small description of your plan (Max: 200)" maxlength="200"></textarea>
                                <% } %>

                            </div>

                            <div class="add-plan-info-header add-plan-info">
                                Plan Diet <span>*</span>
                                <select name="recipeDietId" id="" class="add-plan-info-header-type" required>
                                    <%  for (Map.Entry<Integer, String> entry
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

                            <div class="add-plan-info-header add-plan-info"> <!-- change cai nay thanh select -->
                                <div class="add-plan-info-header">
                                    Plan Period <span>*</span> <span class="add-plan-info-header-des">(Weekly plan will only start at Monday)</span>
                                </div>
                                <select name="period" id="" class="add-plan-info-header-type" required>
                                    <option value="daily" selected="">Daily</option>
                                    <option value="weekly">Weekly</option>
                                </select>

                            </div>

                            <p class="error-popup">${requestScope.createPlanError}</p>

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
