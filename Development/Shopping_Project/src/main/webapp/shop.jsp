<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Product"%>
<%@ page import="com.model.Category"%>
<%@ page import="com.model.Discount"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

<!-- title -->
<title>Shop</title>

<!-- favicon -->
<link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
<!-- google font -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap"
	rel="stylesheet">
<!-- fontawesome -->
<link rel="stylesheet" href="assets/css/all.min.css">
<!-- bootstrap -->
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<!-- owl carousel -->
<link rel="stylesheet" href="assets/css/owl.carousel.css">
<!-- magnific popup -->
<link rel="stylesheet" href="assets/css/magnific-popup.css">
<!-- animate css -->
<link rel="stylesheet" href="assets/css/animate.css">
<!-- mean menu css -->
<link rel="stylesheet" href="assets/css/meanmenu.min.css">
<!-- main style -->
<link rel="stylesheet" href="assets/css/main.css">
<!-- responsive -->
<link rel="stylesheet" href="assets/css/responsive.css">
<style>
.product-image img {
	width: 300px; /* Set your desired width */
	height: 300px; /* Set your desired height */
	object-fit: cover;
	/* Ensures the image covers the specified dimensions */
}
</style>
</head>
<body>

	<!--PreLoader-->
	<div class="loader">
		<div class="loader-inner">
			<div class="circle"></div>
		</div>
	</div>
	<!--PreLoader Ends-->

	<jsp:include page="header.jsp" />

	<!-- search area -->
	<div class="search-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<span class="close-btn"><i class="fas fa-window-close"></i></span>
					<div class="search-bar">
						<div class="search-bar-tablecell">
							<h3>Search For:</h3>
							<input type="text" placeholder="Keywords">
							<button type="submit">
								Search <i class="fas fa-search"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end search area -->

	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>Fresh and Organic</p>
						<h1>Shop</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->

	<!-- products -->
	<div class="product-section mt-150 mb-150">
		<div class="container">

			<div class="row">
				<div class="col-md-12">
					<div class="product-filters">
						<ul>
							<li class="active" data-filter="*"><a
								href="ProductController?categoryId=0">All</a></li>
							<%
							List<Category> categories = (List<Category>) request.getAttribute("categories");
							for (Category category : categories) {
							%>
							<li data-filter=".category-<%=category.getCategoryId()%>"><a
								href="ProductController?categoryId=<%=category.getCategoryId()%>"><%=category.getCategoryName()%></a></li>
							<%
							}
							%>
						</ul>
					</div>
				</div>
			</div>

			<div class="row product-lists">
				<%
				List<Product> products = (List<Product>)request.getAttribute("products");
				List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
				for (Product product : products) {
					double finalPrice = product.getPrice();
					for (Discount discount : discounts) {
						// Assuming discount is linked to product category or some other logic
						if (discount.getDiscount_id() == product.getCategoryId()) { // Adjust this condition as needed
					finalPrice = product.getPrice() * (1 - discount.getPercentage() / 100);
					break;
						}
					}
				%>
				<div
					class="col-lg-4 col-md-6 text-center category-<%=product.getCategoryId()%>">
					<div class="single-product-item">
						<div class="product-image">
							<img src="<%=product.getImageURL()%>"
								alt="<%=product.getProductName()%>">
						</div>
						<h3><%=product.getProductName()%></h3>
						<p class="product-price">
							<span>Per Kg</span> ₹<%=String.format("%.2f", finalPrice)%>
						</p>

						<input type="hidden" id="isLoggedIn"
							value="<%=session.getAttribute("customerId") != null ? "true" : "false"%>">

						<a
							href="ProductController?action=view&id=<%=product.getProductId()%>"
							class="cart-btn"> <i class="fas fa-info-circle"></i> View
							Details
						</a> <a
							href="CartServlet?action=add&productId=<%=product.getProductId()%>&productName=<%=product.getProductName()%>&productPrice=<%=finalPrice%>&productImage=<%=product.getImageURL()%>&quantity=1"
							class="cart-btn"> <i class="fas fa-shopping-cart"></i> Add to
							Cart
						</a>
					</div>
				</div>
				<%
				}
				%>
			</div>

			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="pagination-wrap">
						<ul>
							<li><a href="#">Prev</a></li>
							<li><a href="#">1</a></li>
							<li><a class="active" href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">Next</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end products -->

	<jsp:include page="footer.jsp" />

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