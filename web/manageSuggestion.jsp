<%-- 
    Document   : manageRecipe
    Created on : Jun 5, 2023, 4:14:27 PM
    Author     : Admin
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="DAO.RecipeDAO"%>
<%@page import="DTO.RecipeDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
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
        <link rel="stylesheet" href="./styles/notificationStyle.css">
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
                        <a href="AdminController?action=manageAccount" >
                            <img src="./assets/user-unchosen-icon.svg" alt="">
                            User
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageRecipe" >
                            <img src="./assets/post-unchosen-icon.svg" alt="">
                            Recipe
                        </a>
                    </div>
                    <div>
                        <a href="AdminController?action=manageSuggestion" class="active">
                            <img src="./assets/content-icon.svg" alt="">
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
                            <a href="AdminController?action=manageAccount" >
                                <img src="./assets/user-unchosen-icon.svg" alt="">
                                User
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageRecipe" >
                                <img src="./assets/post-unchosen-icon.svg" alt="">
                                Recipe
                            </a>
                        </div>
                        <div>
                            <a href="AdminController?action=manageSuggestion" class="active">
                                <img src="./assets/content-icon.svg" alt="">
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
                            ArrayList<String> suggestionList = (ArrayList) request.getAttribute("suggestionList");
                        %>



                        <div class="row">
                            <div class="col-md-12">
                                <div class="user-header">
                                    Suggestion List
                                </div>
                                <div class="nav-top-bar-search">
                                    <div class="content-create-button">
                                        <button>
                                            <a href="AdminController?action=loadSuggestionForCreate">
                                                <img src="assets/add-icon-white.svg" alt="alt" />
                                            </a>
                                        </button>
                                        <!--                                <a href="AdminController?action=loadSuggestionForCreate">
                                                                            <img src="assets/add-icon-white.svg" alt="alt" />
                                                                        </a>-->
                                    </div>
                                </div>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Title</th>
                                            <th>Amount</th>
                                            <th class="text-center">Status</th>
                                            <th class="text-center">View Recipe(s)</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <%
                                            String chosenSuggestion = (String) request.getAttribute("chosenSuggestion");
                                            TreeMap<String, Integer> map = (TreeMap<String, Integer>) request.getAttribute("suggestionMap");
                                            if (map != null) {
                                                int count = 1;
                                                for (Map.Entry<String, Integer> entry : map.entrySet()) {
                                                    String key = entry.getKey();
                                                    Integer value = entry.getValue();
                                        %>
                                        <tr>
                                            <td><%= count%></td>
                                            <td class="recipe-and-user-link"><a href="AdminController?action=filterSuggestion&suggestion=<%= key%>"><%= key%></a></td>

                                            <td><%= value%> Recipe(s)</td>
                                            <td class="text-center">
                                                <form action="AdminController" method="post" class="choose-button">
                                                    <input type="hidden" name="suggestion" value="<%= key%>">
                                                    <%
                                                        if (chosenSuggestion != null && chosenSuggestion.equals(key)) {
                                                    %>
                                                    <div class="in-use">Currently in use</div>
                                                    <%
                                                    } else {
                                                    %>
                                                    <button type="submit" name="action" value="suggestionRecipe">Choose</button>
                                                    <%
                                                        }
                                                    %>
                                                </form>
                                            </td>
                                            <td class="text-center">
                                                <a href="AdminController?action=filterSuggestion&suggestion=<%= key%>" class="add-to-suggestion">
                                                    <img src="assets/viewed-icon.svg" alt="alt" />
                                                </a>
                                            </td>
                                            <td >
                                                <form action="AdminController" method="post" >
                                                    <input type="hidden" name="suggestion" value="<%= key%>">
                                                    <input type="hidden" name="chosenSuggestion" value="<%= chosenSuggestion%>">
                                                    <%
                                                        if (map.size() > 1) {
                                                            if (chosenSuggestion.equals(key)) {
                                                    %>
                                                    <!--                                            <button type="submit" name="action" value="loadSuggestionForUpdate">Edit</button>-->
                                                   
                                                    <a href="AdminController?action=loadSuggestionForUpdate&chosenSuggestion=<%= chosenSuggestion%>&suggestion=<%= key%>" class="add-to-suggestion">
                                                        <img src="assets/edit-icon.svg" alt="alt" />
                                                    </a>
                                                    <%
                                                    } else {
                                                    %>

                                                    <!--                                            <button type="submit" name="action" value="loadSuggestionForUpdate">Edit</button>-->
                                                    <a href="AdminController?action=loadSuggestionForUpdate&chosenSuggestion=<%= chosenSuggestion%>&suggestion=<%= key%>" class="add-to-suggestion">
                                                        <img src="assets/edit-icon.svg" alt="alt" />
                                                    </a>
                                                    <!--                                            <button type="submit" name="action" value="deleteSuggestion">Delete</button>-->
<!--                                                    <a href="AdminController?action=deleteSuggestion&suggestion=<%= key%>" class="add-to-suggestion">
                                                        <img src="assets/delete-icon.svg" alt="alt" />
                                                    </a>-->
<!--                                                    <span class="add-to-suggestion">
                                                        <button type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal">
                                                            <img src="assets/delete-icon.svg" alt="alt" />
                                                        </button>
                                                    </span>-->


                                                    <!-- Modal -->
                                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog ">
                                                            <div class="modal-content">
                                                                <div class="modal-header form-header">
                                                                    <div class="form-title disapprove-style" id="exampleModalLabel">
                                                                        Delete Confirmation
                                                                    </div>
                                                                </div>
                                                                <div class="modal-body">
                                                                    Are you sure you want to delete this suggestion ?
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I've changed my mind</button>
                                                                    <button type="button" class="btn btn-danger">
                                                                        <a href="AdminController?action=deleteSuggestion&suggestion=<%= key%>">
                                                                            Yes, delete it
                                                                        </a>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%
                                                        }
                                                    } else {
                                                    %>

                                                    <%
                                                        }
                                                    %>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                                count++;
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="2">No data available</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                    <!--                                    <caption>- Press the name to view it in detail</caption>-->
                                </table>
                            </div>
                            <div class="col-md-12">
                                <%
                                    ArrayList<RecipeDTO> suggestionRecipeList = (ArrayList) request.getAttribute("suggestionRecipeList");
                                    String selectedSuggestion = (String) request.getAttribute("selectedSuggestion");
                                    if (suggestionRecipeList
                                            != null && suggestionRecipeList.size()
                                            > 0) {
                                %>
                                <div class="user-header">
                                    <%= selectedSuggestion%>
                                </div>
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Recipe's Name</th>
                                            <th>Owner</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <%
                                            int count = 1;
                                            for (RecipeDTO r : suggestionRecipeList) {
                                        %>
                                        <tr>
                                            <td><%= count%></td>
                                            <td class="recipe-and-user-link"><a href="AdminController?action=showRecipeDetail&id=<%= r.getId()%>"><%= r.getTitle()%></a></td>
                                                <% Timestamp timestamp = r.getCreate_at();
                                                    SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                    String createDate = dateFormat.format(timestamp);
                                                %>
                                                <% UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());%>
                                            <td class="recipe-and-user-link"><a href="AdminController?action=showUserDetail&username=<%= owner.getUserName()%>"><%= owner.getUserName()%></a></td>
                                        </tr>
                                        <%
                                                    count++;
                                                }
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
