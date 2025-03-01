<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Cart_Items"%>
<%@ page import="com.model.Product"%>
<%@ page import="com.dao.ProductDAO"%>
<%@ page import="com.dao.CartDAO"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Your Cart</title>
<link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/all.min.css">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/main.css">
</head>

<body>
    <% 
        if (session.getAttribute("customerId") == null && session.getAttribute("customerName") == null) {
            response.sendRedirect("index.jsp");
        } else {
            int userId = (Integer) session.getAttribute("customerId");
            CartDAO cartDAO = new CartDAO();
            List<Cart_Items> cart = cartDAO.getCartItemsByUserId(userId); // Fetch cart items for the logged-in user
            session.setAttribute("cart", cart); // Store cart items in session
        } 
    %>

    <%@ include file="header.jsp" %>

    <!-- breadcrumb-section -->
    <div class="breadcrumb-section breadcrumb-bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2 text-center">
                    <div class="breadcrumb-text">
                        <h1>Your Cart</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end breadcrumb section -->

    <!-- cart -->
    <div class="cart-section mt-150 mb-150">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-12">
                    <div class="cart-table-wrap">
                        <table class="cart-table">
                            <thead class="cart-table-head">
                                <tr class="table-head-row">
                                    <th class="product-remove"></th>
                                    <th class="product-image">Product Image</th>
                                    <th class="product-name">Name</th>
                                    <th class="product-price">Price (INR)</th>
                                    <th class="product-quantity">Quantity</th>
                                    <th class="product-total">Total (INR)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    double subtotal = 0.0;
                                    ProductDAO productDAO = new ProductDAO(); // Create an instance of ProductDAO
                                    List<Cart_Items> cart = (List<Cart_Items>) session.getAttribute("cart"); // Retrieve cart from session

                                    if (cart != null && !cart.isEmpty()) {
                                        for (Cart_Items item : cart) {
                                            Product product = productDAO.getProductById(item.getProduct_id()); // Fetch product details
                                            if (product != null) {
                                                double price = product.getPrice();
                                                double total = price * item.getQuantity();
                                                subtotal += total;
                                %>
                                <tr class="table-body-row">
                                    <td class="product-remove">
                                        <a href="CartServlet?action=remove&productId=<%= item.getProduct_id() %>">
                                            <i class="far fa-window-close"></i>
                                        </a>
                                    </td>
                                    <td class="product-image">
                                        <img src="<%= product.getImageURL() %>" alt="<%= product.getProductName() %>">
                                    </td>
                                    <td class="product-name"><%= product.getProductName() %></td>
                                    <td class="product-price">₹<%= String.format("%.2f", price) %></td>
                                    <td class="product-quantity">
                                        <input type="number" value="<%= item.getQuantity() %>" min="1" onchange="updateQuantity(<%= item.getProduct_id() %>, this.value)">
                                    </td>
                                    <td class="product-total">₹<%= String.format("%.2f", total) %></td>
                                </tr>
                                <%
                                                }
                                            }
                                        } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center">Your cart is empty.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="total-section">
                        <table class="total-table">
                            <thead class="total-table-head">
                                <tr class="table-total-row">
                                    <th>Total</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="total-data">
                                    <td><strong>Subtotal: </strong></td>
                                    <td>₹<%= String.format("%.2f", subtotal) %></td>
                                </tr>
                                <tr class="total-data">
                                    <td><strong>Shipping: </strong></td>
                                    <td>₹45.00</td> <!-- You can calculate this dynamically -->
                                </tr>
                                <tr class="total-data">
                                    <td><strong>Total: </strong></td>
                                    <td>₹<%= String.format("%.2f", subtotal + 45.00) %></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="cart-buttons">
                            <a href="cart.jsp" class="boxed-btn">Update Cart</a>
                            <a href="checkout.jsp" class="boxed-btn black">Check Out</a>
                        </div>
                    </div>

                   <!--  <div class="coupon-section">
                        <h3>Apply Coupon</h3>
                        <div class="coupon-form-wrap">
                            <form action="index.jsp">
                                <p><input type="text" placeholder="Coupon"></p>
                                <p><input type="submit" value="Apply"></p>
                            </form>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
    <!-- end cart -->

    <%@ include file="footer.jsp" %>

    <!-- jquery -->
    <script src="assets/js/jquery-1.11.3.min.js"></script>
    <!-- bootstrap -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <!-- main js -->
    <script src="assets/js/main.js"></script>

    <script>
        function updateQuantity(productId, quantity) {
            // Redirect to CartServlet to update quantity
            window.location.href = "CartServlet?action=update&productId=" + productId + "&quantity=" + quantity;
        }
    </script>

</body>
</html>