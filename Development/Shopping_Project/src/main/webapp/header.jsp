<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Website Title</title>
<link rel="stylesheet" href="assets/css/style.css">
<!-- Add your CSS file -->
</head>
<body>
	 <%     response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		    response.setDateHeader("Expires", 0); // Proxies
	  %>
	<!-- header -->
	<div class="top-header-area" id="sticker">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-sm-12 text-center">
					<div class="main-menu-wrap">
						<!-- logo -->
						<div class="site-logo">
							<a href="index.jsp"> <img src="assets/img/logo.png" alt="">
							</a>
						</div>
						<!-- logo -->

						<!-- menu start -->
						<nav class="main-menu">
							<ul>
								<li class="current-list-item"><a href="index.jsp">Home</a></li>
								<li><a href="about.jsp">About</a></li>
								<li><a href="news.jsp">News</a>
									<ul class="sub-menu">
										<li><a href="single-news.jsp">Single News</a></li>
									</ul></li>
								<%
								if (session.getAttribute("customerId") != null && session.getAttribute("customerName") != null) {
								%>
								<li><a href="contact.jsp">Contact</a></li>
								<li><a><b>Welcome, <%=session.getAttribute("customerName")%></b></a>
									<ul class="sub-menu">
										<li><a href="viewprofile.jsp">View Profile</a></li>
										<li><a href="CustomerController?action=logout">Log
												out</a></li>
										<!-- Updated logout link -->
									</ul>
								</li>
								<li><a href="ProductController">Shop</a> <!-- Updated link to ProductController -->
									<ul class="sub-menu">
										<li><a href="checkout.jsp">Check Out</a></li>
										<li><a href="cart.jsp">Cart</a></li> 
									</ul></li>
								<%
								} else {
								%>
								<li><a href="contact.jsp">Contact</a>
									<ul class="sub-menu">
										<li><a href="registration.jsp">Register Here</a></li>
										<li><a href="login.jsp">Login Here</a></li>
									</ul></li>
								<li><a href="ProductController">Shop</a></li>
								<%
								}
								%>
								<li>
									<div class="header-icons">
										<a class="shopping-cart" href="cart.jsp"><i
											class="fas fa-shopping-cart"></i></a> <a
											class="mobile-hide search-bar-icon" href="#"><i
											class="fas fa-search"></i></a>
									</div>
								</li>
							</ul>
						</nav>
						<a class="mobile-show search-bar-icon" href="#"><i
							class="fas fa-search"></i></a>
						<div class="mobile-menu"></div>
						<!-- menu end -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end header -->
</body>
</html>