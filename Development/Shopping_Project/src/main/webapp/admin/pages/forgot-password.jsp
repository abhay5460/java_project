<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
            position: relative;
        }
        .container img {
            width: 80px;
            margin-bottom: 20px;
        }
        .container h1 {
            margin-bottom: 20px;
            font-size: 26px;
        }
        .container .form-group {
            margin-bottom: 20px;
        }
        .container .btn {
            background-color: #6a11cb;
            background-image: linear-gradient(315deg, #6a11cb 0%, #2575fc 74%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .container .btn:hover {
            background-color: #5a0fb8;
        }
        .message {
            margin-top: 15px;
            color: red;
            font-size: 14px;
        }
        .btn-back {
            background-color: #aaaaaa;
            border: none;
            color:#FF4500;
            padding: 8px 15px;
            border-radius: 5px;
            font-weight: 600;
            position: absolute;
            top: 15px;
            right: 15px;
            transition: background-color 0.3s ease;
        }
        .btn-back:hover {
            background-color: #b0b0b0;
        }
    </style>
</head>
<body>
    <div class="container">
        <button class="btn-back" onclick="history.back()">Back</button>
        <img src="https://www.tutorix.com/images/login-punch.png" alt="Image">
        <h1>Forgot Password</h1>
        <form action="forgotPassword" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <button type="submit" class="btn">Recover Password</button>
        </form>
     <!--     <p class="message"><%= request.getAttribute("errorMessage") %></p>
        <p class="message"><%= request.getAttribute("message") %></p> -->
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
