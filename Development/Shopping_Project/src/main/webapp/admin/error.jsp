<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            text-align: center;
            padding: 50px;
        }
        .error-container {
            border: 1px solid #f5c6cb;
            background-color: #f8d7da;
            padding: 20px;
            border-radius: 5px;
            display: inline-block;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
        }
        a {
            color: #721c24;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Something went wrong</h1>
        <p>An unexpected error occurred. Please try again later.</p>
        <p><a href="dashboard.jsp">Go back to the dashboard</a></p>
    </div>
</body>
</html>
