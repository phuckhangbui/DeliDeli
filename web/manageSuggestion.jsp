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
                        <div class="nav-top-bar-search">
                            <div class="news-create-button">
                                <button><a href="AdminController?action=loadSuggestionForCreate">Create</a></button>
                            </div>
                        </div>

                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Title</th>
                                    <th>Amount</th>
                                    <th>Choose</th>
                                    <th>Action</th>
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
                                    <td>
                                        <form action="AdminController" method="post" class="recipe-table-button">
                                            <input type="hidden" name="suggestion" value="<%= key%>">
                                            <%
                                                if (chosenSuggestion != null && chosenSuggestion.equals(key)) {
                                            %>
                                            <button disabled="">Chosen</button> 
                                            <%
                                            } else {
                                            %>
                                            <button type="submit" name="action" value="suggestionRecipe">Choose</button>
                                            <%
                                                }
                                            %>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="AdminController" method="post" class="recipe-table-button">
                                            <input type="hidden" name="suggestion" value="<%= key%>">
                                            <input type="hidden" name="chosenSuggestion" value="<%= chosenSuggestion%>">
                                            <%
                                                if (map.size() > 1) {
                                            %>
                                            <button type="submit" name="action" value="loadSuggestionForUpdate">Edit</button>
                                            <button type="submit" name="action" value="deleteSuggestion">Delete</button>
                                            <%
                                            } else if (map.size() == 1) {
                                                session.removeAttribute("selectedSuggestion");
                                            %>
                                            <button disabled="">Unavailable</button>
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
                        </table>

                        <%
                            ArrayList<RecipeDTO> suggestionRecipeList = (ArrayList) request.getAttribute("suggestionRecipeList");
                            String selectedSuggestion = (String) request.getAttribute("selectedSuggestion");
                            if (suggestionRecipeList
                                    != null && suggestionRecipeList.size()
                                    > 0) {
                        %>
                        <h3><%= selectedSuggestion%></h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Title</th>
                                    <th>Owner</th>
                                    <th>Create at</th>
                                    <th>Update at</th>
                                    
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
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
