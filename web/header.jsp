<%-- Document : header Created on : May 24, 2023, 7:23:26 PM Author : khang --%>
<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalTime"%>
<%@page import="DTO.PlanDateDTO"%>
<%@page import="DTO.DisplayNotificationDTO"%>
<%@page import="DTO.NotificationTypeDTO"%>
<%@page import="DTO.NotificationDTO"%>
<%@page import="DTO.UserDTO"%>
<%-- Document : header Created on : May 24, 2023, 7:23:26 PM Author : khang --%>

<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.util.Locale" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.time.Duration" %>
<%@page import="java.time.ZoneId" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.sql.Date" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page contentType="text/html"
        pageEncoding="UTF-8" %>
<html lang="en">

    <head>
        <title>Delideli</title>
        <meta charset="utf-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1">
        <!--      Bootstrap         -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
        <!--      CSS         -->
        <link rel="stylesheet"
              href="./styles/userStyle.css">
        <link rel="stylesheet"
              href="./styles/notificationStyle.css">
        <link rel="preconnect"
              href="https://fonts.googleapis.com">
        <link rel="preconnect"
              href="https://fonts.gstatic.com"
              crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Fira+Sans+Extra+Condensed:wght@300;400;500&display=swap"
            rel="stylesheet">

    </head>

    <body>
        <% HashMap<Integer, String> cateMap
                    = (HashMap<Integer, String>) session.getAttribute("cateMap");
            HashMap<Integer, String> cuisineMap
                    = (HashMap<Integer, String>) session.getAttribute("cuisineMap");
            HashMap<Integer, String> levelMap
                    = (HashMap<Integer, String>) session.getAttribute("levelMap");
            HashMap<Integer, String> ingredientMap
                    = (HashMap<Integer, String>) session.getAttribute("ingredientMap");
            HashMap<Integer, String> dietMap
                    = (HashMap<Integer, String>) session.getAttribute("dietMap");
            HashMap<Integer, String> newsMap
                    = (HashMap<Integer, String>) session.getAttribute("newsMap");

            UserDTO user
                    = (UserDTO) session.getAttribute("user");
        %>
        <div
            class="navigator-bar">
            <div
                class="container ">
                <div
                    class="row navigation-bar-first">
                    <a href="home.jsp"
                       class="logo col-md-3">
                        <img src="./assets/Logo2.png"
                             alt="">
                    </a>
                    <div
                        class="search-bar col-md-7">
                        <form
                            action="MainController"
                            method="post">
                            <button
                                type="submit"
                                name="action"
                                value="search"><img
                                    src="assets/search-icon.svg"
                                    alt=""></button>
                            <input
                                type="text"
                                name="txtsearch"
                                placeholder="What are you searching for ?">
                            <select
                                name="searchBy"
                                id=""
                                class="">
                                <option
                                    value="Title"
                                    selected="selected">
                                    TITLE
                                </option>
                                <option
                                    value="Category">
                                    CATEGORIES
                                </option>
                                <!--<option value="">INGREDIENTS</option>-->
                                <option
                                    value="Cuisine">
                                    CUISINES
                                </option>
                                <option
                                    value="Diet">
                                    DIETS
                                </option>
                            </select>
                        </form>
                    </div>
                    <%if (user != null) {%>
                    <% int[] count = (int[]) request.getAttribute("count");
                    %>

                    <!--    TICK TOCK PLAN NOTIFICATION   -->

                    <%
                        LocalTime currentTime = LocalTime.now();
                        PlanDateDTO currentPlanToday = (PlanDateDTO) session.getAttribute("currentPlanToday");
                        if (currentPlanToday.getStart_time() != null) {
                            Time startTimeFromDB = currentPlanToday.getStart_time();
                            LocalTime startTime = startTimeFromDB.toLocalTime();
                            System.out.println("[HEADER]: START TIME - " + startTime);
                            if (currentTime.isAfter(startTime) || currentTime.equals(startTime)) {
                                // Activate the servlet using AJAX
                    %>
                    <script>
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "UserController?action=planNotification", true);
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        // This means execute when request is successful (status === 200).
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === 4 && xhr.status === 200) {
                                console.log("Servlet activated!");
                            }
                        };
                        xhr.send();
                    </script>
                    <%
                            } else {
                                System.out.println("[HEADER]: It's not the correct time yet.");
                            }
                        } else {
                            System.out.println("[HEADER]: No plan yet.");
                        }
                    %>


                    <!--                                  -->

                    <div
                        class="notification col-md-1">
                        <div
                            class="dropdown-notification">
                            <button
                                class="dropbtn-notification"
                                onclick="toggleDropdown()">
                                <img src="assets/notification-icon.svg">
                            </button>
                            <div class="dropdown-content-notification"
                                 id="dropdownContent">
                                <div>
                                    <div
                                        class="status-bar-notification">
                                        <p
                                            id="totalCount">
                                            Total:
                                            <%=count[0]%>
                                        </p>
                                        <p
                                            id="unreadCount">
                                            Unread:
                                            <%=count[2]%>
                                        </p>
                                    </div>
                                </div>
                                <div
                                    class="notification-content">
                                    <%
                                        ArrayList<DisplayNotificationDTO> list
                                                = (ArrayList<DisplayNotificationDTO>) request.getAttribute("displayList");
                                        for (DisplayNotificationDTO n : list) {
                                            if (n.is_read()) {

                                    %>
                                    <button
                                        type="button"
                                        class="a-notification "
                                        data-bs-toggle="modal"
                                        data-bs-target="#<%= n.getId()%>">
                                        <% } else {%>
                                        <button
                                            type="button"
                                            class="a-notification notification-disable"
                                            data-bs-toggle="modal"
                                            data-bs-target="#<%= n.getId()%>">
                                            <%
                                                }%>
                                            <div
                                                class="notification-first-row">
                                                <img src="assets/delideli-website-favicon-color.png"
                                                     alt="img">
                                                <p>
                                                    <%=n.getType().getSender()%>
                                                </p>
                                            </div>
                                            <div
                                                class="text">
                                                <p>
                                                    <%=n.getTitle()%>
                                                </p>
                                            </div>
                                            <p
                                                class="date">
                                                <% Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                                                    Timestamp sendTimestamp = n.getSend_date();

                                                    LocalDateTime currentDateTime = currentTimestamp.toLocalDateTime();
                                                    LocalDateTime sendDateTime = sendTimestamp.toLocalDateTime();
                                                    Duration duration = Duration.between(sendDateTime,
                                                            currentDateTime); %>
                                                <%
                                                    if (duration.toMinutes() == 0) {
                                                %>
                                                now
                                                <%
                                                } else if (duration.toDays() > 0) {
                                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd yyyy", Locale.ENGLISH);
                                                    String formattedDateTime
                                                            = sendDateTime.format(formatter);
                                                %>
                                                <%=formattedDateTime%>
                                                <% } else {
                                                    long minutesDiff = Math.abs(duration.toMinutes());
                                                    if (minutesDiff < 60) {
                                                        String minuteString = (minutesDiff == 1)
                                                                ? "minute"
                                                                : "minutes";
                                                %>
                                                <%=minutesDiff%>
                                                <%=minuteString%>
                                                ago
                                                <% } else {
                                                    long hoursDiff = Math.abs(duration.toHours());
                                                    String hourString = (hoursDiff == 1)
                                                            ? "hour"
                                                            : "hours";
                                                %>
                                                <%=hoursDiff%>
                                                <%=hourString%>
                                                ago
                                                <%      }
                                                    }
                                                %>
                                            </p>


                                        </button>
                                        <!-- Add closing tag for <a> element -->
                                        <%
                                            }%>


                                </div>

                            </div>
                        </div>
                    </div>
                    <!--                    <div class="account col-md-1">
                                             <a href="UserController?action=userPublicDetail&userId=<%=user.getId()%>">
                                                <img src="ServletImageLoader?identifier=<%= user.getAvatar()%>" alt="">
                                            </a>
                                        </div>-->
                    <div
                        class="account col-md-1">
                        <span>
                            <div class="user-dropdown">
                                <button class="user-dropbtn">
                                    <img src="ServletImageLoader?identifier=<%= user.getAvatar()%>" alt="">
                                    <%=user.getUserName()%>
                                </button>
                                <div
                                    class="user-dropdown-content">
                                    <a
                                        href="MainController?action=loadPublicProfile&accountName=<%= user.getUserName()%>">Your
                                        Profile</a>
                                    <a
                                        href="UserController?action=userPublicDetail&userId=<%=user.getId()%>">Management</a>
                                    <a href="addRecipe.jsp">Add Recipe</a>
                                    <a href="UserController?action=planManagement&userId=<%=user.getId()%>">Plan Management</a>

                                    <a
                                        href="MainController?action=logout">Logout</a>
                                </div>
                            </div>
                        </span>
                    </div>

                    <script>
                        var dropdownContent = document.getElementById("dropdownContent");
                        var dropbtnNotification = document.querySelector(".dropbtn-notification");
                        var notificationButtons = document.querySelectorAll(".a-notification");
                        var unreadCountElement = document.getElementById("unreadCount");

                        // Toggle dropdown content
                        function toggleDropdown() {
                            dropdownContent.style.display = dropdownContent.style.display === "block" ? "none" : "block";
                        }

                        // Open modal and prevent closing the dropdown
                        notificationButtons.forEach(function (button) {
                            button.addEventListener("click", function (event) {
                                event.stopPropagation(); // Prevent the click event from bubbling up to the dropdown container

                                // Update the unread count based on the appearance of notification-disable class
                                if (this.classList.contains("notification-disable")) {
                                    // Update the unread count
                                    this.classList.remove("notification-disable");
                                    var unreadCount = parseInt(unreadCountElement.textContent.split(":")[1].trim());
                                    unreadCount--;
                                    unreadCountElement.textContent = "Unread: " + unreadCount;

                                    // Get the notification id from the data-bs-target attribute
                                    var notificationId = this.getAttribute("data-bs-target").substring(1);

                                    // Call the SetNotificationStatusServlet
                                    var xhr = new XMLHttpRequest();
                                    xhr.open("POST", "SetNotificationStatusServlet");
                                    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                    xhr.onreadystatechange = function () {
                                        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                                            console.log("Notification status updated successfully");
                                        }
                                    };
                                    xhr.send("notificationId=" + encodeURIComponent(notificationId));
                                } else {
                                    return; // Exit the event listener without further processing
                                }
                            });
                        });

                        // Close dropdown content when clicking outside, unless a modal is open
                        document.addEventListener("mousedown", function (event) {
                            var targetElement = event.target;
                            var modals = document.querySelectorAll(".modal");
                            var isModalOpen = false;
                            var isDropdownTarget = targetElement === dropbtnNotification || dropbtnNotification.contains(targetElement);
                            var isNotificationTarget = targetElement.classList.contains("a-notification") ||
                                    targetElement.closest(".a-notification") !== null;

                            if (!isDropdownTarget && !isNotificationTarget) {
                                modals.forEach(function (modal) {
                                    if (modal.classList.contains("show")) {
                                        isModalOpen = true;
                                    }
                                });
                                if (!isModalOpen) {
                                    dropdownContent.style.display = "none";
                                }
                            }
                        });

                    </script>

                    <% } else {
                    %>
                    <div
                        class="account col-md-2">
                        <span><a
                                href="login.jsp">Sign
                                in</a></span>
                        <span>|</span>
                        <span><a
                                href="registration.jsp">Register</a></span>
                    </div>
                    <%
                        }%>
                </div>
                <div
                    class="row navigation-bar-last">
                    <ul
                        class="navigation-bar-content">
                        <li>
                            <div
                                class="dropdown">
                                <button
                                    class="dropbtn">INGREDIENTS</button>
                                <div
                                    class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : ingredientMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a
                                        href="SearchByType?type=Ingredient&id=<%=key%>">
                                        <%=value%>
                                    </a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="dropdown">
                                <button class="dropbtn">CATEGORIES</button>
                                <div class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : cateMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a href="SearchByType?type=Category&id=<%=key%>">
                                        <%=value%>
                                    </a>

                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div
                                class="dropdown">
                                <button
                                    class="dropbtn">CUISINES</button>
                                <div
                                    class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : cuisineMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a
                                        href="SearchByType?type=Cuisine&id=<%=key%>">
                                        <%=value%>
                                    </a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div
                                class="dropdown">
                                <button
                                    class="dropbtn">DIFFICULTIES</button>
                                <div
                                    class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : levelMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a
                                        href="SearchByType?type=Level&id=<%=key%>">
                                        <%=value%>
                                    </a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div
                                class="dropdown">
                                <button
                                    class="dropbtn">DIETS</button>
                                <div
                                    class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : dietMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a
                                        href="SearchByType?type=Diet&id=<%=key%>">
                                        <%=value%>
                                    </a>
                                    <%}%>
                                </div>
                            </div>
                        </li>

                        <li>
                            <div
                                class="dropdown">
                                <button
                                    class="dropbtn">NEWS</button>
                                <div
                                    class="dropdown-content">
                                    <% for (Map.Entry<Integer, String> entry
                                                : newsMap.entrySet()) {
                                            Integer key
                                                    = entry.getKey();
                                            String value
                                                    = entry.getValue();
                                    %>
                                    <a
                                        href="LoadNewsList?id=<%=key%>">
                                        <%=value%>
                                    </a>
                                    <%}%>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>




        <% if (user != null) {
                ArrayList<DisplayNotificationDTO> list
                        = (ArrayList<DisplayNotificationDTO>) request.getAttribute("displayList");
                for (DisplayNotificationDTO n : list) {

        %>
        <!-- Modal -->
        <div class="modal fade"
             id="<%= n.getId()%>"
             data-bs-keyboard="false"
             tabindex="-1"
             aria-labelledby="deletePlanModalLabel"
             aria-hidden="true">
            <div
                class="modal-dialog modal-sm">
                <div
                    class="modal-content">
                    <div
                        class="modal-header">
                        <div class="modal-title fs-5 modal-title-self"
                             id="exampleModalLabel">
                            <p
                                class="modal-title-text">
                                <%=n.getTitle()%>
                            </p>
                            <p class="modal-title-date">
                                <% Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                                    Timestamp sendTimestamp = n.getSend_date();

                                    LocalDateTime currentDateTime = currentTimestamp.toLocalDateTime();
                                    LocalDateTime sendDateTime = sendTimestamp.toLocalDateTime();
                                    Duration duration = Duration.between(sendDateTime,
                                            currentDateTime); %>
                                <%
                                    if (duration.toMinutes() == 0) {
                                %>
                                now
                                <%
                                } else if (duration.toDays()
                                        > 0) {
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd yyyy", Locale.ENGLISH);
                                    String formattedDateTime
                                            = sendDateTime.format(formatter);
                                %>
                                <%=formattedDateTime%>
                                <% } else {
                                    long minutesDiff = Math.abs(duration.toMinutes());
                                    if (minutesDiff
                                            < 60) {
                                        String minuteString = (minutesDiff == 1)
                                                ? "minute"
                                                : "minutes";
                                %>
                                <%=minutesDiff%>
                                <%=minuteString%>
                                ago
                                <% } else {
                                    long hoursDiff = Math.abs(duration.toHours());
                                    String hourString = (hoursDiff == 1)
                                            ? "hour"
                                            : "hours";
                                %>
                                <%=hoursDiff%>
                                <%=hourString%>
                                ago
                                <% }
                                    }
                                %>
                            </p>

                        </div>
                    </div>
                    <div
                        class="modal-body">
                        <div
                            class="modal-body-content">
                            <%=n.getDescription()%>
                        </div>
                        <% switch (n.getType().getId()) {
                                case 1:%>
                        <a href="UserController?action=loadEditRecipe&recipeId=<%=n.getRecipe_id()%>"
                           class="modal-link">Edit recipe</a>

                        <% break;
                            case 2:%>
                        <a href="MainController?action=getRecipeDetailById&id=<%=n.getRecipe_id()%>"
                           class="modal-link">View recipe</a>

                        <% break;
                            case 3:%>
                        <a href="MainController?action=getRecipeDetailById&id=<%=n.getRecipe_id()%>"
                           class="modal-link">View recipe</a>

                        <% break;
                            case 4:
                        %>
                        <a href="#"
                           class="modal-link">View plan</a>
                        <% break;
                            case 5:
                                if (n.getLink() != "") {%>
                        <img src="ServletImageLoader?identifier=<%=n.getImgPath()%>" alt="" style="width:100%; border-radius: 5px">
                        <%}
                                    break;
                            }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-danger deleteBtn"
                            data-bs-dismiss="modal">Delete</button>
                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <% } %>
        <script>

            // Get all delete buttons on the page
            const deleteButtons = document.querySelectorAll('.deleteBtn');
            const totalCountElement = document.getElementById('totalCount');

            // Iterate over each delete button and add the event listener
            deleteButtons.forEach((button) => {
                button.addEventListener('click', () => {
                    // Get the id of the parent modal
                    const notificationId = button.closest('.modal').id;
                    // Find the corresponding delete notification button
                    let selector = 'button[data-bs-target="#' + notificationId + '"]';
                    console.log(selector);

                    let deleteNotificationButton = document.querySelector(selector);

                    if (deleteNotificationButton.classList.contains("notification-disable")) {
                        // Update the unread count

                        var unreadCount = parseInt(unreadCountElement.textContent.split(":")[1].trim());
                        unreadCount--;
                        unreadCountElement.textContent = "Unread: " + unreadCount;
                    }

                    var totalCount = parseInt(totalCountElement.textContent.split(":")[1].trim());
                    totalCount--;
                    totalCountElement.textContent = "Total: " + totalCount;

                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "DeleteNotificationServlet");
                    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                            console.log("Delete notification sucessfully");
                        }
                    };
                    xhr.send("notificationId=" + encodeURIComponent(notificationId));

                    deleteNotificationButton.remove();




                    // Find the modal element and close it
                    const modalElement = document.getElementById(notificationId);
                    const bootstrapModal = new bootstrap.Modal(modalElement);
                    bootstrapModal.hide();
                });
            });


        </script>

        <% }%>

        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>

</html>