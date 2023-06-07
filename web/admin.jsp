<%-- 
    Document   : admin
    Created on : May 23, 2023, 4:09:46 PM
    Author     : Admin
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.sql.Date"%>
<%@page import="Recipe.RecipeDAO"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="Admin.AdminDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="User.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null || user.getRole() != 2) {
                response.sendRedirect("error.jsp");
            } else {
        %>
        <h1>Welcome ${user.getUserName()}</h1>
        <p>Today is: <%= LocalDate.now()%></p>
        <p>Total account: <%= AdminDAO.getTotalAccount()%></p>
        <p>Total recipe: <%= AdminDAO.getTotalRecipe()%></p>
        <a href="MainController?action=logout" >Logout</a>

        <h1>Latest Recipes</h1>
        <%
            ArrayList<RecipeDTO> listRecipe = AdminDAO.getTop5LatestRecipes();
            String[] tmp = {"Confirmed", "Unconfirmed"};
        %>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Create at</th>
                <th>Owner</th>
            </tr>
            <%                if (listRecipe != null && listRecipe.size() > 0) {
                    for (RecipeDTO r : listRecipe) {
            %>
            <tr>
                <td><%= r.getId()%></td>
                <td><%= r.getTitle()%></td>
                <td><%= r.getCreate_at()%></td>
                <td><a href="MainController?action=showUserDetail&username=<%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%>"><%= RecipeDAO.getRecipeOwnerByRecipeId(r.getId())%></a></td>
            </tr>
            <% }
                }
            %>
        </table>
        <p><a href="MainController?action=manageRecipe">View more</a></p>

        <div style="width: 500px;"><canvas id="recipeChart"></canvas></div>

        <hr>
        <h1>Latest Users</h1>
        <%
            ArrayList<UserDTO> listUser = AdminDAO.getTop5LatestUser();
        %>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>User name</th>
                <th>Email</th>
                <th>Create at</th>
            </tr>
            <%                if (listUser != null && listUser.size() > 0) {
                    for (UserDTO u : listUser) {
            %>
            <tr>
                <td><%= u.getId()%></td>
                <td><a href="MainController?action=showUserDetail&username=<%= u.getUserName()%>"><%= u.getUserName()%></a></td>
                <td><%= u.getEmail()%></td>
                <td><%= u.getCreateAt()%></td>
            </tr>
            <% }
                }
            %>
        </table>
        <p><a href="MainController?action=manageAccount">View more</a></p>

        <div style="width: 500px;"><canvas id="accountChart"></canvas></div>

        <%
            }
        %>


        <%
            TreeMap<Date, Integer> mapRecipe = (TreeMap) AdminDAO.getRecipeMap();
            TreeMap<Date, Integer> mapAccount = (TreeMap) AdminDAO.getAccountMap();
        %>

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

        <hr>
        <p><a href="MainController?action=manageAccount">Manage Account</a></p>
        <p><a href="MainController?action=manageRecipe">Manage Recipe</a></p>
        <p><a href="MainController?action=manageNews">Manage News</a></p>

    </body>
</html>
