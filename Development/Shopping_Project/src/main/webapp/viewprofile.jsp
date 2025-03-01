<%@page import="com.model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Customer user = (Customer) request.getAttribute("user_id");
    if (user == null) {
%>
    <div class="alert alert-danger" role="alert">
        User profile not found. Please try again later.
    </div>
<%
    return; // Stop further processing if user is null
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }
        .profile-container {
            margin-top: 50px;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
            color: white;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
	
    <div class="container profile-container">
        <h1 class="text-center text-2xl font-bold mb-4">User  Profile</h1>
        <div class="bg-white shadow-md rounded-lg p-6">
            <h2 class="text-xl font-semibold">Personal Information</h2>
            <form action="../ProfileController" method="post">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">First Name</th>
                        <td><%= user.getFirstname() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Last Name</th>
                        <td><%= user.getLastname() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td><%= user.getEmail() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Phone No</th>
                        <td><%= user.getPhoneno() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Address</th>
                        <td><%= user.getAddress() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Registration Date</th>
                        <td><%= user.getRegistrationdate() != null ? user.getRegistrationdate().toString() : "N/A" %></td>
                    </tr>
                </tbody>
            </table>
            </form>
        </div>

        <div class="mt-4 text-center">
            <a href="pages/edit_user.jsp?id=<%= user.getUser_id() %>" class="btn btn-custom">Edit Profile</a>
            <a href="../ProfileController?action=deleteCustomer&customerId=<%= user.getUser_id() %>" class="btn btn-danger ml-4" onclick="return confirm('Are you sure you want to delete your account?');">Delete Account</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>