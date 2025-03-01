<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.model.Product"%>
<%@page import="com.model.Discount"%>
<%@page import="com.dao.DiscountDAO"%>
<%@page import="com.dao.ProductDAO"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

<!-- title -->
<title>Single Product</title>

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
						<p>See more Details</p>
						<h1>Single Product</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->

	<!-- single product -->
	<div class="single-product mt-150 mb-150">
		<div class="container">
			<div class="row">
				<div class="col-md-5">
					<div class="single-product-img">
						<%
						Product product = (Product) request.getAttribute("product");
						if (product != null) {
						%>
						<img src="<%=product.getImageURL()%>"
							alt="<%=product.getProductName()%>">
						<%
						} else {
						%>
						<img src="assets/img/products/default-product.jpg"
							alt="Default Product">
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-7">
					<div class="single-product-content">
						<h3><%=product != null ? product.getProductName() : "Product Not Found"%></h3>
						<%
						// Fetch discounts
						DiscountDAO discountDAO = new DiscountDAO();
						List<Discount> discounts = discountDAO.getAllDiscounts();
						double finalPrice = product != null ? product.getPrice() : 0.0;
						String discountInfo = "";

						// Check for applicable discounts
						for (Discount discount : discounts) {
							if (discount.getDiscount_id() == product.getCategoryId()) { // Adjust condition as needed
								finalPrice = product.getPrice() * (1 - discount.getPercentage() / 100);
								discountInfo = discount.getDiscount_name() + ": " + discount.getPercentage() + "% off";
								break;
							}
						}
						%>
						<p class="single-product-pricing">
							<span>Original Price: </span> ₹<%=product != null ? String.format("%.2f", product.getPrice()) : "0.00"%><br>
							<span>Discounted Price: </span> ₹<%=String.format("%.2f", finalPrice)%>
						</p>
						<p><%=product != null ? product.getDescription() : "No description available."%></p>
						<div class="single-product-form">
							<form
								action="CartServlet?action=add&productId=<%=product != null ? product.getProductId() : "0"%>&productName=<%=product != null ? product.getProductName() : "N/A"%>&productPrice=<%=finalPrice%>&productImage=<%=product != null ? product.getImageURL() : "N/A"%>&quantity=1"
								method="post">
								<input type="number" name="quantity" placeholder="0" min="1"
									value="1">
								<button type="submit" class="cart-btn">
									<i class="fas fa-shopping-cart"></i> Add to Cart
								</button>
							</form>
							<p>
								<strong>Categories: </strong>Fruits, Organic
							</p>
							<p>
								<strong>Discount Info: </strong><%=discountInfo.isEmpty() ? "No discounts available." : discountInfo%>
							</p>
						</div>
						<h4>Share:</h4>
						<ul class="product-share">
							<li><a href=""><i class="fab fa-facebook-f"></i></a></li>
							<li><a href=""><i class="fab fa-twitter"></i></a></li>
							<li><a href=""><i class="fab fa-google-plus-g"></i></a></li>
							<li><a href=""><i class="fab fa-linkedin"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end single product -->

	<!-- more products -->
	<div class="more-products mb-150">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="section-title">
						<h3>
							<span class="orange-text">Related</span> Products
						</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Aliquid, fuga quas itaque eveniet beatae optio.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-6 text-center">
					<div class="single-product-item">
						<div class="product-image">
							<a href="single-product.jsp"><img
								src="assets/img/products/product-img-1.jpg" alt=""></a>
						</div>
						<h3>Strawberry</h3>
						<p class="product-price">
							<span>Per Kg</span> ₹85
						</p>
						<a href="cart.jsp" class="cart-btn"><i
							class="fas fa-shopping-cart"></i> Add to Cart</a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center">
					<div class="single-product-item">
						<div class="product-image">
							<a href="single-product.jsp"><img
								src="assets/img/products/product-img-2.jpg" alt=""></a>
						</div>
						<h3>Berry</h3>
						<p class="product-price">
							<span>Per Kg</span> ₹70
						</p>
						<a href="cart.jsp" class="cart-btn"><i
							class="fas fa-shopping-cart"></i> Add to Cart</a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center">
					<div class="single-product-item">
						<div class="product-image">
							<a href="single-product.jsp"><img
								src="assets/img/products/product-img-3.jpg" alt=""></a>
						</div>
						<h3>Lemon</h3>
						<p class="product-price">
							<span>Per Kg</span> ₹35
						</p>
						<a href="cart.jsp" class="cart-btn"><i
							class="fas fa-shopping-cart"></i> Add to Cart</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end more products -->

	<!-- logo carousel -->
	<div class="logo-carousel-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="logo-carousel-inner">
						<div class="single-logo-item">
							<img src="assets/img/company-logos/1.png" alt="">
						</div>
						<div class="single-logo-item">
							<img src="assets/img/company-logos/2.png" alt="">
						</div>
						<div class="single-logo-item">
							<img src="assets/img/company-logos/3.png" alt="">
						</div>
						<div class="single-logo-item">
							<img src="assets/img/company-logos/4.png" alt="">
						</div>
						<div class="single-logo-item">
							<img src="assets/img/company-logos/5.png" alt="">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end logo carousel -->

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