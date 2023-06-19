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
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
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
                <%
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    if (user == null || user.getRole() == 1) {
                        response.sendRedirect("error.jsp");
                    } else if (user.getRole() == 2) {
                %>

                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="admin.jsp">
                            <img src="./assets/public.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageAccount" class="active">
                            <img src="./assets/user-unchose.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageRecipe">
                            <img src="./assets/post-unchose.svg" alt="">
                            Posts
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageSuggestion">
                            <img src="./assets/content-unchose.svg" alt="">
                            Content
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=manageNews">
                            <img src="./assets/news-unchose.svg" alt="">
                            News
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/policies-unchose.svg" alt="">
                            Policies
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/broadcast-unchose.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <img src="./assets/bug-report-unchose.svg" alt="">
                            Report
                        </a>
                    </div>
                </nav>

                <div class="col-md-10 recipe">

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
                    } else if (user.getRole() == 3) {
                    %>
                    <nav class="nav-left-bar col-md-2">
                        <a class="logo" href="">
                            <img src="assets/Logo3.svg" alt="">
                        </a>
                        <!--                        <div>
                                                    <a href="admin.jsp">
                                                        <img src="./assets/public-unchose.svg" alt="">
                                                        Dashboard
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="MainController?action=manageAccount" class="active">
                                <img src="./assets/user-unchose.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=manageRecipe">
                                <img src="./assets/post-unchose.svg" alt="">
                                Posts
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=manageSuggestion">
                                <img src="./assets/content-unchose.svg" alt="">
                                Content
                            </a>
                        </div>
                        <div>
                            <a href="MainController?action=manageNews">
                                <img src="./assets/news.svg" alt="">
                                News
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/policies-unchose.svg" alt="">
                                                        Policies
                                                    </a>
                                                </div>-->
                        <div>
                            <a href="#">
                                <img src="./assets/broadcast-unchose.svg" alt="">
                                Broadcast
                            </a>
                        </div>
                        <!--                        <div>
                                                    <a href="#">
                                                        <img src="./assets/bug-report-unchose.svg" alt="">
                                                        Report
                                                    </a>
                                                </div>-->
                    </nav>

                    <div class="col-md-10 recipe">
                        <nav class="navbar">
                            <div class="nav-top-bar">
                                <div class="nav-top-bar-account dropdown">
                                    <img src="./assets/profile-pic.svg" alt="">
                                    <div>
                                        <p><%= user.getUserName()%></p>
                                        <p>Moderator</p>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <%
                            }
                        %>

                        <div class="container">
                            <div class="user-detail-admin">
                                <div class="user-detail-admin-heading">
                                    <h3 class="">Profile Detail</h3>
                                </div>

                                <%
                                    UserDTO account = (UserDTO) request.getAttribute("user");
                                    UserDetailDTO userDetail = (UserDetailDTO) request.getAttribute("userDetail");
                                    ArrayList<RecipeDTO> userRecipe = (ArrayList) request.getAttribute("userRecipe");
                                %>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">User Name: </p>
                                    <p class="col-lg-10"><%= account.getUserName()%></p>
                                </div>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">Email: </p>
                                    <p class="col-lg-10"><%= account.getEmail()%></p>
                                </div>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">First Name: </p>
                                    <p class="col-lg-10"><%= userDetail.getFirstName()%></p>
                                </div>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">Last Name: </p>
                                    <p class="col-lg-10"><%= userDetail.getLastName()%></p>
                                </div>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">Specialty: </p>
                                    <p class="col-lg-10"><%= userDetail.getSpecialty()%></p>
                                </div>

                                <div class="row">
                                    <p class="col-lg-2 user-detail-admin-title">Bio: </p>
                                    <p class="col-lg-10"><%= userDetail.getBio()%></p>
                                </div>

                                <%                if (userRecipe != null && userRecipe.size() > 0) {
                                %>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="user-detail-admin-heading">
                                            <h3 class="">User's Recipe(s)</h3>
                                        </div>
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Title</th>
                                                    <th>Create at</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody class="table-group-divider">
                                                <%
                                                    for (RecipeDTO r : userRecipe) {
                                                %>
                                                <tr>
                                                    <td><%= r.getId()%></td>
                                                    <td><%= r.getTitle()%></td>
                                                    <td><%= r.getCreate_at()%></td>
                                                    <td>
                                                        <form action="MainController" method="post" class="user-detail-admin-button">
                                                            <input type="hidden" value="<%= r.getId()%>" name="id">
                                                            <button type="submit" value="showRecipeDetail" name="action">Show</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <% }
                                                %>
                                            </tbody>
                                        </table>
                                        <%
                                        } else {
                                        %>
                                        <div class="user-detail-admin-heading">
                                            <h3>User does not have any recipe yet.</h3>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>

                                    <div class="col-md-6">
                                        <%
                                            TreeMap<Integer, Integer> mapRating = (TreeMap) AdminDAO.getRatingAllRecipesOfOwnerMap(account.getId());
                                            if (mapRating.size() != 0) {
                                        %>
                                        <div><canvas id="myChart"></canvas></div>
                                                <%
                                                    }
                                                %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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

    </body>
</html>
