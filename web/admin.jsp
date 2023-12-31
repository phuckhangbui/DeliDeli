<%-- 
    Document   : admin
    Created on : May 23, 2023, 4:09:46 PM
    Author     : Admin
--%>

<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DAO.AdminDAO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
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
        <link rel="stylesheet" href="./styles/adminStyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="AdminController?action=adminDashboard" class="active">
                            <img src="./assets/public-icon.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageAccount">
                            <img src="./assets/user-unchosen-icon.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageRecipe">
                            <img src="./assets/post-unchosen-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion">
                            <img src="./assets/content-unchosen-icon.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageNews">
                            <img src="./assets/news-unchosen-icon.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="adminBroadcast.jsp">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=logout">
                            <img src="./assets/leave-icon.svg" alt="">
                            Logout
                        </a>
                    </div>


                </nav>


                <div class="col-md-10 dashboard">
                    <%
                        UserDTO user = (UserDTO) session.getAttribute("user");
                        if (user == null || user.getRole() != 2) {
                            response.sendRedirect("error.jsp");
                        } else {
                    %>
                    <nav class="navbar">
                        <div class="nav-top-bar">
                            <div class="nav-top-bar-account dropdown">
                                <img src="./assets/profile-pic.svg" alt="">
                                <div>
                                    <p><%= user.getUserName()%></p>
                                    <p>Admin</p>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <%
                        }
                    %>


                    <%
                        ArrayList<RecipeDTO> listRecipe = (ArrayList) request.getAttribute("listRecipe");
                        ArrayList<UserDTO> listUser = (ArrayList) request.getAttribute("listUser");
                        int totalRecipe = (Integer) request.getAttribute("totalRecipe");
                        int totalAccount = (Integer) request.getAttribute("totalAccount");
                        TreeMap<Date, Integer> mapRecipe = (TreeMap) request.getAttribute("mapRecipe");
                        TreeMap<Date, Integer> mapAccount = (TreeMap) request.getAttribute("mapAccount");
                    %>
                    <!--      Dashboard         -->
                    <div class="main-panel">
                        <div class="content-wrapper">
                            <div class="page-header">
                                <div class="dashboard-header">
                                    <p>Dashboard</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 stretch-card grid-margin ">
                                    <div class="card bg-gradient-danger">
                                        <div >
                                            <div class="card-total-content">
                                                <div>
                                                    <h4 class="">
                                                        Total Recipes
                                                    </h4>
                                                    <h2 class=""><%= totalRecipe%></h2>
                                                </div>
                                                <div>
                                                    <img src="assets/total-post-icon.svg" alt="">
                                                </div>
                                            </div>
                                            <a class="card-total-see-more" href="AdminController?action=manageRecipe">
                                                <p>View More</p>
                                                <p>></p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 stretch-card grid-margin">
                                    <div class="card bg-gradient-info">
                                        <div >
                                            <div class="card-total-content">
                                                <div>
                                                    <h4 class="">Total Users
                                                    </h4>
                                                    <h2 class=""><%= totalAccount%></h2>
                                                </div>
                                                <div>
                                                    <img src="assets/total-user-icon.svg" alt="">
                                                </div>
                                            </div>
                                            <a class="card-total-see-more" href="AdminController?action=manageAccount">
                                                <p>View More</p>
                                                <p>></p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 stretch-card grid-margin">
                                    <div class="card bg-gradient-success">
                                        <div class="">
                                            <div class="card-total-content">
                                                <div >
                                                    <h4 class="">Today is
                                                    </h4>
                                                    <h2 class=""><%= LocalDate.now()%></h2>
                                                </div>
                                                <div>
                                                    <img src="assets/calendar-date-icon.svg" alt="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Number of recipes by date</h4>
                                            <!--<canvas id="lineChart" style="height:250px"></canvas>-->
                                            <canvas id="recipeChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Latest Recipes</h4>
                                            </p>

                                            <%
                                                String[] tmp = {"Confirmed", "Unconfirmed"};
                                            %>
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>No.</th>
                                                        <th>Title</th>
                                                        <th>Create at</th>
                                                        <th>Owner</th>
                                                    </tr>
                                                </thead>
                                                <%                if (listRecipe != null && listRecipe.size() > 0) {
                                                        int i = 0;
                                                        for (RecipeDTO r : listRecipe) {
                                                %>
                                                <tr>
                                                    <td><%= ++i%></td>
                                                    <td><%= r.getTitle()%></td>
                                                    <% Timestamp timestamp = r.getCreate_at();
                                                        SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                        String date = dateFormat.format(timestamp);%>
                                                    <td><%= date%></td>
                                                    <% UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());%>
                                                    <td><a href="AdminController?action=showUserDetail&username=<%= owner.getUserName()%>"><%= owner.getUserName()%></a></td>
                                                </tr>
                                                <% }
                                                    }
                                                %>
                                            </table>
                                            <div class="latest-table-button">
                                                <button class="btn-table">
                                                    <a href="AdminController?action=manageRecipe">VIEW MORE</a>
                                                </button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Number of users by date</h4>
                                            <canvas id="accountChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Latest Users</h4>
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>No.</th>
                                                        <th>User Name</th>
                                                        <th>Email</th>
                                                        <th>Create at</th>
                                                    </tr>
                                                </thead>

                                                <tbody>
                                                    <%                if (listUser != null && listUser.size() > 0) {
                                                            int i = 0;
                                                            for (UserDTO u : listUser) {
                                                    %>
                                                    <tr>
                                                        <td><%= ++i%></td>
                                                        <td><a href="AdminController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                                                        <td><%= u.getEmail()%></td>
                                                        <td><%= u.getCreateAt()%></td>
                                                    </tr>
                                                    <% }
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                            <div class="latest-table-button">
                                                <button class="btn-table">
                                                    <a href="AdminController?action=manageAccount">VIEW MORE</a>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const recipeChart = document.getElementById('recipeChart');

            (async function () {
                const data = [
            <% for (Map.Entry<Date, Integer> entry : mapRecipe.entrySet()) {
                    Date key = entry.getKey();
                    Integer value = entry.getValue();
            %>
                    {date: '<%= key%>', count: <%= value%>},
            <% }%>
                ];
                new Chart(
                        document.getElementById('recipeChart'),
                        {
                            type: 'line',
                            data: {
                                labels: data.map(row => row.date),
                                datasets: [
                                    {
                                        label: 'Number of new recipe by date',
                                        data: data.map(row => row.count),
                                        borderColor: '#ec9131'
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    y: {
                                        ticks: {
                                            stepSize: 1, // Set the interval between ticks to 1
                                            beginAtZero: true, // Start the axis from zero
                                        },
                                    },
                                },
                            },
                        }
                );
            })();
        </script>

        <script>
            const accountChart = document.getElementById('accountChart');

            (async function () {
                const data = [
            <% for (Map.Entry<Date, Integer> entry : mapAccount.entrySet()) {
                    Date key = entry.getKey();
                    Integer value = entry.getValue();
            %>
                    {date: '<%= key%>', count: <%= value%>},
            <% }%>
                ];
                new Chart(
                        document.getElementById('accountChart'),
                        {
                            type: 'line',
                            data: {
                                labels: data.map(row => row.date),
                                datasets: [
                                    {
                                        label: 'Number of new user by date',
                                        data: data.map(row => row.count),
                                        borderColor: '#ec9131'
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    y: {
                                        ticks: {
                                            stepSize: 1, // Set the interval between ticks to 1
                                            beginAtZero: true, // Start the axis from zero
                                        },
                                    },
                                },
                            },
                        }
                );
            })();
        </script>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
