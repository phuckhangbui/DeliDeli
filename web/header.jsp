<%-- Document : header Created on : May 24, 2023, 7:23:26 PM Author : khang --%>
<%-- Document : header Created on : May 24, 2023, 7:23:26 PM Author : khang --%>

<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.util.Locale" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.time.Duration" %>
<%@page import="java.time.ZoneId" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.sql.Date" %>
<%@page import="NotificationType.NotificationTypeDAO" %>
<%@page import="NotificationType.NotificationTypeDTO" %>
<%@page import="Notification.NotificationDTO" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Notification.NotificationDAO" %>
<%@page import="User.UserDTO" %>
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
                    = Utils.NavigationBarUtils.getMap("Category");
            HashMap<Integer, String> cuisineMap
                    = Utils.NavigationBarUtils.getMap("Cuisine");
            HashMap<Integer, String> levelMap
                    = Utils.NavigationBarUtils.getMap("Level");
            HashMap<Integer, String> ingredientMap
                    = Utils.NavigationBarUtils.getMap("Ingredient");
            HashMap<Integer, String> dietMap
                    = Utils.NavigationBarUtils.getMap("Diet");

            HashMap<Integer, String> newsMap
                    = Utils.NavigationBarUtils.getMap("NewsCategory");

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
                                    src="assets/search2.svg"
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
                    <% int[] count = NotificationDAO.getNotificationCount(user.getId());
                    %>
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
                                        ArrayList<NotificationDTO> list
                                                = NotificationDAO.getNotificationList(user.getId());
                                        for (NotificationDTO notification : list) {
                                            NotificationTypeDTO type
                                                    = NotificationTypeDAO.getNotificationType(notification.getNotification_type());
                                            if (notification.is_read()) {

                                    %>
                                    <button
                                        type="button"
                                        class="a-notification "
                                        data-bs-toggle="modal"
                                        data-bs-target="#<%= notification.getId()%>">
                                        <% } else {%>
                                        <button
                                            type="button"
                                            class="a-notification notification-disable"
                                            data-bs-toggle="modal"
                                            data-bs-target="#<%= notification.getId()%>">
                                            <%
                                                }%>
                                            <div
                                                class="notification-first-row">
                                                <img src="assets/delideli-website-favicon-color.png"
                                                     alt="img">
                                                <p>
                                                    <%=type.getSender()%>
                                                </p>
                                            </div>
                                            <div
                                                class="text">
                                                <p>
                                                    <%=notification.getTitle()%>
                                                </p>
                                            </div>
                                            <p
                                                class="date">
                                                <% Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                                                    Timestamp sendTimestamp = notification.getSend_date();

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

                    <div
                        class="account col-md-1">
                        <span>
                            <div
                                class="user-dropdown">
                                <button
                                    class="user-dropbtn">
                                    <%=user.getUserName()%>
                                </button>
                                <div
                                    class="user-dropdown-content">
                                    <a
                                        href="userCommunityProfile.jsp?accountName=<%= user.getUserName()%>">Your
                                        Profile</a>
                                    <a
                                        href="userPublicDetail.jsp?userId=<%=user.getId()%>">Management</a>
                                    <a href="addRecipe.jsp">Add Recipe</a>
                                    <a href="planManagement.jsp">Plan Management</a>

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
                                        href="searchResultPage.jsp?type=Ingredient&id=<%=key%>">
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
                                    <a href="searchResultPage.jsp?type=Category&id=<%=key%>">
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
                                        href="searchResultPage.jsp?type=Cuisine&id=<%=key%>">
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
                                        href="searchResultPage.jsp?type=Level&id=<%=key%>">
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
                                        href="searchResultPage.jsp?type=Diet&id=<%=key%>">
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
                                        href="searchResultPage.jsp?type=NewsCategory&id=<%=key%>">
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




        <% if (user
                    != null) {
                ArrayList<NotificationDTO> list = NotificationDAO.getNotificationList(user.getId());
                for (NotificationDTO notification
                        : list) {
                    NotificationTypeDTO type
                            = NotificationTypeDAO.getNotificationType(notification.getNotification_type());
        %>
        <!-- Modal -->
        <div class="modal fade"
             id="<%= notification.getId()%>"
             data-bs-backdrop="static"
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
                                <%=notification.getTitle()%>
                            </p>
                            <p
                                class="modal-title-date">
                                <% Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                                    Timestamp sendTimestamp = notification.getSend_date();

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
                            <%=notification.getDescription()%>
                        </div>
                        <% switch (type.getId()) {
                                case 1:%>
                        <a href="editRecipe.jsp?recipeId=<%=notification.getRecipe_id()%>"
                           class="modal-link">Edit
                            recipe</a>

                        <% break;
                            case 2:%>
                        <a href="MainController?action=getRecipeDetailById&id=<%=notification.getRecipe_id()%>"
                           class="modal-link">View
                            recipe</a>

                        <% break;
                            case 3:%>
                        <a href="MainController?action=getRecipeDetailById&id=<%=notification.getRecipe_id()%>"
                           class="modal-link">View
                            recipe</a>

                        <% break;
                            case 4:
                        %>
                        <a href="#"
                           class="modal-link">View
                            plan</a>
                            <% break;
                                    case 5:
                                        break;
                                }
                            %>
                    </div>
                    <div
                        class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-danger deleteBtn"
                            data-bs-dismiss="modal">Delete</button>
                        <button
                            type="button"
                            class="btn btn-success closeBtn"
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