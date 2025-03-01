<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Payment Page</title>
    <style type="text/css">
        .bttnStyle {
            background-color: lightblue;
            border-radius: 0.50rem;
            border: 1px solid transparent;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var xhttp = new XMLHttpRequest();
        var RazorpayOrderId;

        function CreateOrderID() {
            var amount = document.getElementById("amount").value;
            xhttp.open("GET", "http://localhost:8080/Shopping_project/OrderServlet?amount=" + amount, false);
            xhttp.send();
            RazorpayOrderId = xhttp.responseText;

            // Proceed to open the Razorpay checkout
            OpenCheckOut();
        }

        function OpenCheckOut() {
            var amount = document.getElementById("amount").value * 100; // Convert to paise
            var options = {
                "key": "rzp_test_KGwT3XcJybhKgu", // Replace with your Razorpay key
                "amount": amount, // Amount in paise
                "currency": "INR",
                "name": "Your Company Name",
                "description": "Order Payment",
                "order_id": RazorpayOrderId,
                "callback_url": "http://localhost:8080/Shopping_project/OrderServlet", // URL to handle payment response
                "prefill": {
                    "name": document.getElementById("customerName").value,
                    "email": document.getElementById("customerEmail").value,
                    "contact": document.getElementById("customerContact").value
                },
                "notes": {
                    "address": "s.nagar"
                },
                "theme": {
                    "color": "#3399cc"
                }
            };

            var rzp1 = new Razorpay(options);
            rzp1.on('payment.failed', function (response) {
                alert("Payment failed: " + response.error.description);
            });
            rzp1.open();
        }
    </script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
    <div id="order_id"></div>
    <center>
        <%
            // Retrieve parameters sent from checkout.jsp
            String price = request.getParameter("price");
            String customerName = request.getParameter("firstname");
            String customerEmail = request.getParameter("email");
            String customerContact = request.getParameter("phoneno");
        %>
        <input type="hidden" id="amount" value="<%= price %>">
        <input type="text" id="customerName" placeholder="Your Name" value="<%= customerName %>" required>
        <input type="email" id="customerEmail" placeholder="Your Email" value="<%= customerEmail %>" required>
        <input type="text" id="customerContact" placeholder="Your Contact Number" value="<%= customerContact %>" required>
        <button id="payButton" onclick="CreateOrderID()" class="bttnStyle">Pay Now</button>
    </center>
</body>
</html>