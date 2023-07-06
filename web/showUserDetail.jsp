<%-- 
    Document   : showUserDetail
    Created on : Jun 5, 2023, 7:26:51 PM
    Author     : Admin
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="DTO.UserDetailDTO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.sql.Date"%>
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
                        <a href="AdminController?action=adminDashboard" >
                            <img src="./assets/public-unchosen-icon.svg" alt="">
                            Dashboard
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageAccount" class="active">
                            <img src="./assets/user-icon.svg" alt="">
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
                        <div>
                            <a href="AdminController?action=manageAccount" class="active">
                                <img src="./assets/user-icon.svg" alt="">
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
                            <a href="MainController?action=logout">
                                <img src="./assets/leave-icon.svg" alt="">
                                Logout
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
                                        <p>Moderator</p>
                                    </div>
                                </div>
                            </div>
                        </nav>
                        <%
                            }
                        %>

                        <%
                            UserDTO account = (UserDTO) request.getAttribute("user");
                            UserDetailDTO userDetail = (UserDetailDTO) request.getAttribute("userDetail");
                            ArrayList<RecipeDTO> userRecipe = (ArrayList) request.getAttribute("userRecipe");
                            TreeMap<Integer, Integer> mapRating = (TreeMap) request.getAttribute("mapRating");
                            String fullname = userDetail.getFirstName() + " " + userDetail.getLastName();
                        %>
                        <div class="blank-background">
                            <div class="container">
                                <div class="user-detail-admin new-result">
                                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="AdminController?action=manageAccount">User List</a></li>
                                            <li class="breadcrumb-item current-link" aria-current="page"><%= account.getUserName()%></li>
                                        </ol>
                                    </nav>
                                    <div class="user-detail-admin-heading">
                                        <h3 class="">Profile Detail</h3>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 user-detail-admin-image">
                                            <!--                                            <img src="pictures/egg1.jpeg" alt="alt"/>-->
                                            <img src="ServletImageLoader?identifier=<%= account.getAvatar()%>" alt="alt"/>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="row">
                                                <div class="col-md-4 user-detail-admin-title">
                                                    <p>User Name</p>
                                                    <p><%= account.getUserName()%></p>
                                                </div>
                                                <div class="col-md-4 user-detail-admin-title">
                                                    <p>Full Name</p>
                                                    <p id="userFullName"><%=fullname%></p>
                                                </div>
                                                <div class="col-md-4 user-detail-admin-title">
                                                    <p>Email</p>
                                                    <p><%= account.getEmail()%></p>
                                                </div>
                                                <div class="col-md-12 user-detail-admin-title">
                                                    <p>Specialties</p>
                                                    <%
                                                        if (userDetail.getSpecialty().equals("")) { %>
                                                    <p class="unspecified">Unspecified</p>
                                                    <%
                                                    } else {
                                                    %>
                                                    <p><%= userDetail.getSpecialty()%></p>
                                                    <%}%>




                                                </div>
                                                <div class="col-md-12 user-detail-admin-title">
                                                    <p>Bio</p>
                                                    <%
                                                        if (userDetail.getBio().equals("")) { %>
                                                    <p class="unspecified">Unspecified</p>
                                                    <%
                                                    } else {
                                                    %>
                                                    <p><%= userDetail.getBio()%></p>
                                                    <%}%>

                                                </div>
                                            </div>
                                        </div>
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
                                                        <th>No.</th>
                                                        <th>Title</th>
                                                        <th>Create at</th>
                                                        <th>Update at</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="table-group-divider">
                                                    <%
                                                        for (RecipeDTO r : userRecipe) {
                                                    %>
                                                    <tr>
                                                        <td><%= r.getId()%></td>
                                                        <td class="recipe-and-user-link">
                                                            <a href="AdminController?action=showRecipeDetail&id=<%= r.getId()%>"><%= r.getTitle()%></a>
                                                        </td>
                                                        <% Timestamp timestamp = r.getCreate_at();
                                                            SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                            String createDate = dateFormat.format(timestamp);
                                                        %>
                                                        <td><%= createDate%></td>
                                                        <%
                                                            if (r.getUpdate_at() == null) {
                                                        %>
                                                        <td><%= createDate%></td>
                                                        <%
                                                        } else {
                                                            timestamp = r.getUpdate_at();
                                                            dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                            String updateDate = dateFormat.format(timestamp);
                                                        %>
                                                        <td><%= updateDate%>
                                                            <%
                                                                }
                                                            %>
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
        </div>
        <script src="./script/userCommunityProfileScript.js" defer></script>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
