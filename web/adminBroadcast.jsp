<%-- 
    Document   : adminBroadcast
    Created on : Jul 1, 2023, 7:24:52 PM
    Author     : khang
--%>


<%@page import="DTO.UserDTO"%>
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
        <script src="https://cdn.ckeditor.com/4.16.2/standard-all/ckeditor.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <%                     UserDTO user = (UserDTO) session.getAttribute("user");
                %>
                <nav class="nav-left-bar col-md-2">
                    <a class="logo" href="">
                        <img src="assets/Logo3.svg" alt="">
                    </a>
                    <div>
                        <a href="AdminController?action=adminDashboard">
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
                        <a href="adminBroadcast.jsp" class="active">
                            <img src="./assets/broadcast-unchosen-icon.svg" alt="">
                            Broadcast
                        </a>
                    </div>
                    <div>
                        <a href="MainController?action=logout">
                            <img src="./assets/bug-report-unchosen-icon.svg" alt="">
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


                    <div class="blank-background">
                        <div class="container ">
                            <div class="row news-content">
                                <%
                                    //UserDTO user = (UserDTO) session.getAttribute("user");
                                    //String id = request.getParameter("newsId");
%>
                                <form action="AdminController" method="post" class="news-create-button" enctype="multipart/form-data">
                                    <div class="add-news-header">
                                        <p>Make a Broadcast</p>
                                    </div>
                                    <div class="news-content-info-header">
                                        Title <span>*</span>
                                        <div>
                                            <input id="txtTitle" type="text" name="txtTitle" placeholder="What's the broadcast called?" required="">
                                        </div>
                                    </div>
                                    <div class="news-content-info-header news-content-info-white-background">
                                        <p>Image<span>(optional)</span> <input type="file" name="file"></p>
                                    </div>
                                    <div class="news-content-info">
                                        Broadcast body <span>*</span>
                                        <textarea rows="10" cols="10" id="editor"></textarea>
                                    </div>
                                    <input type="hidden" name="editorContent" id="editorContent" value="">

                                    <div class="add-news-create">
                                                <button disabled="" id="broadcastform" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal">Broadcast</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="popup-confirm">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">CONFIRMATION</h1>
                        </div>
                        <div class="modal-body">
                            Pressing confirm will publish this broadcast to all user on the system, make sure to check the content of the broadcast again!
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, I changed my mind</button>
                            <button type="button" class="btn btn-danger" id="broadcast">Yes, confirm</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            // Get all file input elements
            var fileInputs = document.querySelectorAll('input[type="file"]');

            // Add event listeners for the "change" event
            fileInputs.forEach(function (fileInput) {
                fileInput.addEventListener('change', validateFile);
            });

            // File validation function
            function validateFile(event) {
                var file = event.target.files[0];
                if (file) {
                    if (file.type.startsWith('image/')) {
                    } else {
                        alert('Please select an image file.');
                        event.target.value = ''; // Reset the file input value
                    }
                } else {
                    alert('Please select a file.');
                }
            }
        </script>

        <script>
            CKEDITOR.replace('editor', {
                language: 'vi',
                entities_latin: false,
                entities_greek: false
            });
        </script>

        <script>
            // Get the input elements and the "Broadcast" button
            var txtTitle = document.getElementById('txtTitle');
            var editor = CKEDITOR.instances.editor;
            var broadcastformBtn = document.getElementById('broadcastform');

            // Add event listeners to the input elements and CKEditor instance
            txtTitle.addEventListener('input', checkValidity);
            editor.on('change', checkValidity);

            // Function to check the validity of the input elements and enable/disable the "Broadcast" button
            function checkValidity() {
                var isTitleEmpty = txtTitle.value.trim() === '';
                var isEditorEmpty = editor.getData().trim() === '';

                // Enable/disable the "Broadcast" button based on the validity of the input elements
                broadcastformBtn.disabled = isTitleEmpty || isEditorEmpty;
            }
        </script>



        <script>
            var broadcastBtn = document.getElementById('broadcast');

            broadcastBtn.addEventListener("click", function () {
                if (broadcastBtn.disabled) {
                    event.preventDefault();
                } else {
                    var editorContent = CKEDITOR.instances.editor.getData();

                    // Create a new FormData object
                    var formData = new FormData();

                    // Append form data
                    formData.append('txtTitle', document.querySelector('input[name="txtTitle"]').value);
                    formData.append('file', document.querySelector('input[name="file"]').files[0]);
                    formData.append('editorContent', editorContent);
                    formData.append('action', 'createBroadcast');

                    // Create a new XHR object
                    var xhr = new XMLHttpRequest();

                    // Set up the XHR request
                    xhr.open('POST', 'AdminController');

                    // Set the enctype header to ensure it is sent as multipart/form-data
                    xhr.setRequestHeader('enctype', 'multipart/form-data');

                    // Define the function to handle the XHR response
                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // Request was successful, handle the response here
                            var response = xhr.responseText;
                            // ...
                            // Hide the modal
                            var modal = document.getElementById("confirmModal");
                            var modalInstance = bootstrap.Modal.getInstance(modal);
                            modalInstance.hide();

                            window.location.href = "AdminController?action=adminDashboard";
                        } else {
                            // Request failed, handle the error here
                            console.error('XHR request failed. Status: ' + xhr.status);
                        }
                    };

                    // Send the XHR request with the form data
                    xhr.send(formData);
                }
            });



        </script>



        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </body>
</html>
