<%-- 
    Document   : showUserDetail
    Created on : Jun 5, 2023, 7:26:51 PM
    Author     : Admin
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="Admin.AdminDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="Recipe.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="User.UserDetailDTO"%>
<%@page import="User.UserDTO"%>
<%@page import="User.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            UserDTO user = (UserDTO) request.getAttribute("user");
            UserDetailDTO userDetail = (UserDetailDTO) request.getAttribute("userDetail");
            ArrayList<RecipeDTO> userRecipe = (ArrayList) request.getAttribute("userRecipe");
        %>

        <h3>User Name: <%= user.getUserName()%></h3>
        <p>Email: <%= user.getEmail()%></p>

        <p>First Name: <%= userDetail.getFirstName()%></p>
        <p>Last Name: <%= userDetail.getLastName()%></p>
        <p>Specialty: <%= userDetail.getSpecialty()%></p>
        <p>Bio: <%= userDetail.getBio()%></p>

        <%                if (userRecipe != null && userRecipe.size() > 0) {
        %>
        <h3>User's Recipe(s)</h3>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Create at</th>
                <th>Action</th>
            </tr>
            <%
                for (RecipeDTO r : userRecipe) {
            %>
            <tr>
                <td><%= r.getId()%></td>
                <td><%= r.getTitle()%></td>
                <td><%= r.getCreate_at()%></td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" value="<%= r.getId()%>" name="id">
                        <button type="submit" value="showRecipeDetail" name="action">Show</button>
                    </form>
                </td>
            </tr>
            <% }
            %>
        </table>
        <%
            }
        %>

        <%
            TreeMap<Integer, Integer> mapRating = (TreeMap) AdminDAO.getRatingAllRecipesOfOwnerMap(user.getId());
            if (mapRating.size() == 0) {
        %>
        <h3>User does not have any recipe yet.</h3>
        <%
        } else {
        %>
        <div style="width: 500px;"><canvas id="myChart"></canvas></div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const myChart = document.getElementById('myChart');

            (async function () {
                const data = [
            <% for (Map.Entry<Integer, Integer> entry : mapRating.entrySet()) {
                    Integer key = entry.getKey();
                    Integer value = entry.getValue();
            %>
                    {rating: '<%= key%>', count: <%= value%>},
            <% }%>
                ];

                const labels = data.map(row => row.rating);
                const counts = data.map(row => row.count);

                new Chart(
                        document.getElementById('myChart'),
                        {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [
                                    {
                                        label: 'All ratings of recipes',
                                        data: counts,
                                        backgroundColor: '#ec9131'
                                    }
                                ]
                            },
                        }
                );
            })();
        </script>
        <%
            }
        %>

    </body>
</html>
