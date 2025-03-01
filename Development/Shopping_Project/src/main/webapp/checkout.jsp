<%@page import="com.model.Customer"%>
<%@page import="com.dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Cart_Items"%>
<%@ page import="com.model.Product"%>
<%@ page import="com.dao.ProductDAO"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

<!-- title -->
<title>Check Out</title>

<!-- favicon -->
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
	}
	%>

	<!--PreLoader-->
	<div class="loader">
		<div class="loader-inner">
			<div class="circle"></div>
		</div>
	</div>
	<!--PreLoader Ends-->

	<%@ include file="header.jsp"%>

	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>Fresh and Organic</p>
						<h1>Check Out Product</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	<!-- check out section -->
	<div class="checkout-section mt-150 mb-150">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<div class="checkout-accordion-wrap">
						<%
						int userId = (int)session.getAttribute("customerId");
						CustomerDAO customerDAO = new CustomerDAO();
						Customer customer = customerDAO.getCustomerById(userId); // Fetch  Details for the logged-in user
						session.setAttribute("customer", customer); // Store Customer Details in session
						%>
						<form action="payment.jsp" method="post">
							<!-- Combined form starts here -->
							<div class="accordion" id="accordionExample">
								<div class="card single-accordion">
									<div class="card-header" id="headingOne">
										<h5 class="mb-0">
											<button class="btn btn-link" type="button"
												data-toggle="collapse" data-target="#collapseOne"
												aria-expanded="true" aria-controls="collapseOne">
												Billing Address</button>
										</h5>
									</div>
									<div id="collapseOne" class="collapse show"
										aria-labelledby="headingOne" data-parent="#accordionExample">
										<div class="card-body">
											<div class="billing-address-form">
												<p>
													<input type="text" class="form-control" placeholder="Name"
														name="billingName" value="<%=customer.getFirstname()%>"
														required>
												</p>
												<p>
													<input type="email" class="form-control"
														placeholder="Email" name="billingEmail"
														value="<%=customer.getEmail()%>" required>
												</p>
												<p>
													<input type="text" class="form-control"
														placeholder="Address" name="billingAddress"
														value="<%=customer.getAddress()%>" required>
												</p>
												<p>
													<input type="tel" class="form-control" placeholder="Phone"
														name="billingPhone" value="<%=customer.getPhoneno()%>"
														required>
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="card single-accordion">
									<div class="card-header" id="headingTwo">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapseTwo"
												aria-expanded="false" aria-controls="collapseTwo">
												Shipping Address</button>
										</h5>
									</div>
									<div id="collapseTwo" class="collapse"
										aria-labelledby="headingTwo" data-parent="#accordionExample">
										<div class="card-body">
											<div class="billing-address-form">
												<p>
													<input type="text" class="form-control"
														name="shippingAddress" value="<%=customer.getAddress()%>"
														placeholder="Address" required>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<input type="submit" name="payment" value="Place Order"
								style="margin-top: 30px; color: #fff; font-family: 'Poppins', sans-serif; font-size: 16px;"
								class="boxed-btn">
						</form>
						<!-- Combined form ends here -->
					</div>
				</div>

				<div class="col-lg-4">
					<div class="order-details-wrap">
						<table class="order-details">
							<thead>
								<tr>
									<th>Your Order Details</th>
									<th>Price</th>
								</tr>
							</thead>
							<tbody class="order-details-body">
								<%
								List<Cart_Items> cart = (List<Cart_Items>) session.getAttribute("cart");
								double subtotal = 0.0;
								ProductDAO productDAO = new ProductDAO(); // Create an instance of ProductDAO

								if (cart != null && !cart.isEmpty()) {
									for (Cart_Items item : cart) {
										Product product = productDAO.getProductById(item.getProduct_id()); // Fetch product details
										if (product != null) {
									double price = product.getPrice();
									double total = price * item.getQuantity();
									subtotal += total;
								%>
								<tr>
									<td><%=product.getProductName()%></td>
									<td>₹<%=String.format("%.2f", total)%></td>
								</tr>
								<%
								}
								}
								} else {
								%>
								<tr>
									<td colspan="2" class="text-center">Your cart is empty.</td>
								</tr>
								<%
								}
								%>
							</tbody>
							<tbody class="checkout-details">
								<tr>
									<td>Subtotal</td>
									<td>₹<%=String.format("%.2f", subtotal)%></td>
								</tr>
								<tr>
									<td>Shipping</td>
									<td>₹45.00</td>
									<!-- You can calculate this dynamically -->
								</tr>
								<tr>
									<td>Total</td>
									<td>₹<%=String.format("%.2f", subtotal + 45.00)%></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end check out section -->

	<%@ include file="footer.jsp"%>

	<!-- jquery -->
	<script src="assets/js/jquery-1.11.3.min.js"></script>
	<!-- bootstrap -->
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<!-- count down -->
	<script src="assets/js/jquery.countdown.js"></script>
	<!-- isotope -->
	<script src="assets/js/jquery.isotope-3.0.6.min.js"></script>
	<!-- waypoints -->
	<script src="assets/js/waypoints.js"></script>
	<!-- owl carousel -->
	<script src="assets/js/owl.carousel.min.js"></script>
	<!-- magnific popup -->
	<script src="assets/js/jquery.magnific-popup.min.js"></script>
	<!-- mean menu -->
	<script src="assets/js/jquery.meanmenu.min.js"></script>
	<!-- sticker js -->
	<script src="assets/js/sticker.js"></script>
	<!-- main js -->
	<script src="assets/js/main.js"></script>

</body>
</html>
