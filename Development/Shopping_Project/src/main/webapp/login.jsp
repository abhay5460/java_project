<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
<title>Login</title>
<link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/all.min.css">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/owl.carousel.css">
<link rel="stylesheet" href="assets/css/magnific-popup.css">
<link rel="stylesheet" href="assets/css/animate.css">
<link rel="stylesheet" href="assets/css/meanmenu.min.css">
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/responsive.css">

<!-- custom styles -->
<style>
    .registration-form {
        background: #f4f4f4;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    .registration-form h2 {
        margin-bottom: 20px;
        font-family: 'Poppins', sans-serif;
        font-weight: 700;
    }
    .registration-form p {
        font-family: 'Open Sans', sans-serif;
        margin-bottom: 15px;
    }
    .registration-form input, .registration-form button {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .registration-form button {
        background: #5cb85c;
        color: #fff;
        border: none;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
    }
    .registration-form button:hover {
        background: #4cae4c;
    }
    .registration-form .toggle-password {
        background: #5cb85c;
        color: #fff;
        border: none;
        cursor: pointer;
        width: auto;
        padding: 10px;
    }
    .toggle-password {
            position: absolute;
            right: 52px; /* Adjusted value to align the icon properly */
            top: 49%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
        }
        .toggle-password:hover {
            color: #333;
        }
</style>

<!-- custom validation and interactivity script -->
<script>
    function validateForm() {
        var firstName = document.forms["fruitkha-register"]["firstName"].value;
        var lastName = document.forms["fruitkha-register"]["lastName"].value;
        var email = document.forms["fruitkha-register"]["email"].value;
        var password = document.forms["fruitkha-register"]["password"].value;
        var phone = document.forms["fruitkha-register"]["phone"].value;
        var address = document.forms["fruitkha-register"]["address"].value;
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        var phonePattern = /^[0-9]{10}$/;
        if (firstName === "" || lastName === "" || email === "" || password === "") {
            alert("All fields marked with * are required.");
            return false;
        }
        if (!emailPattern.test(email)) {
            alert("Invalid email format.");
            return false;
        }
        if (!phonePattern.test(phone) && phone !== "") {
            alert("Invalid phone number. It should be 10 digits.");
            return false;
        }
        return true;
    }
    function togglePasswordVisibility() {
        var passwordField = document.getElementById("password");
        if (passwordField.type === "password") {
            passwordField.type = "text";
        } else {
            passwordField.type = "password";
        }
    }
</script>
</head>
<body>
	 <%     response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		    response.setDateHeader("Expires", 0); // Proxies
	  %>
    <!-- PreLoader -->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!-- PreLoader Ends -->

    <%@ include file="header.jsp" %>
	
    <!-- breadcrumb-section -->
    <div class="breadcrumb-section breadcrumb-bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2 text-center">
                    <div class="breadcrumb-text">
                        <p>Join the Fruitkha Family</p>
                        <h1>Login Form</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end breadcrumb section -->

    <!-- login form -->
    <div class="contact-from-section mt-150 mb-150">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mb-5 mb-lg-0">
                    <div class="form-title">
                        <h1 align="center">Login Your Account</h1>
                    </div>
                    <div id="form_status"></div>
                    <div class="registration-form">

                        <h4 style="color:red">
                           ${errorMessage}
                        </h4>
                        <form name="fruitkha-register" method="post" action="CustomerController" onsubmit="return validateForm();">
                            <p>
                                <input type="email" placeholder="Email *" name="email" id="email" required>
                                <input type="password" placeholder="Password *" name="password" id="password" required>
                                <i type="button" class="fas fa-eye toggle-password" onclick="togglePasswordVisibility()"></i>
                            </p>
                            <input type="hidden" name="action" value="login" />
                            <p><input type="submit" value="Login"></p>
                        </form>
                        <hr class="my-8">
                        <h4 class="mt-4">
    <a href="forgotpassword.jsp" class="text-sm font-medium text-blue-600 hover:underline"><u>Forgot your password?</u></a>
</h4>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="contact-form-wrap">
                        <div class="contact-form-box">
                            <h4><i class="fas fa-map"></i> Shop Address</h4>
                            <p>34/8, East Gandhinagar <br> Gujarat <br> India.</p>
                        </div>
                        <div class="contact-form-box">
                            <h4><i class="far fa-clock"></i> Shop Hours</h4>
                            <p>MON - FRIDAY: 8 to 9 PM <br> SAT - SUN: 10 to 8 PM </p>
                        </div>
                        <div class="contact-form-box">
                            <h4><i class="fas fa-address-book"></i> Contact</h4>
                            <p>Phone: +00 111 222 3333 <br> Email: support@fruitkha.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end login form -->

    <jsp:include page="footer.jsp" />

    <!-- jquery -->
    <script src="assets/js/jquery-1.11.3.min.js"></script>
    <!-- bootstrap -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <!-- main js -->
    <script src="assets/js/main.js"></script>

    <script>
        // Check for registration success message
        <% 
            String registrationSuccess = (String) session.getAttribute("registrationSuccess");
            if (registrationSuccess != null) {
        %>
            alert("<%= registrationSuccess %>");
        <% 
            session.removeAttribute("registrationSuccess"); // Remove the message after displaying it
            } 
        %>
        
        <% 
        	String loginFailed = (String) request.getAttribute("errorMessage");
        	if (loginFailed != null) {
   		 %>
        	alert("<%= loginFailed  %>");
    	<% 
    		request.removeAttribute("errorMessage"); // Remove the message after displaying it
        } 
   		 %>
    </script>
</body>
</html>