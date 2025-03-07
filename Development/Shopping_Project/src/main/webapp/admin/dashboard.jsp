<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// Check if the user is logged in
HttpSession session3 = request.getSession(false);
if (session3 == null || session3.getAttribute("admin_id") == null) {
	response.sendRedirect("admin-index.jsp"); // Redirect to login page if not logged in
	return; // Stop further processing
}
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Admin Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/tailwind.output.css" />
<script
	src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
	defer></script>
<script src="./assets/js/init-alpine.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
	defer></script>
<script src="./assets/js/charts-lines.js" defer></script>
<script src="./assets/js/charts-pie.js" defer></script>
</head>
<body>

	<div class="flex h-screen bg-gray-50 dark:bg-gray-900"
		:class="{ 'overflow-hidden': isSideMenuOpen }">
		<!-- Desktop sidebar -->
		<aside
			class="z-20 hidden w-64 overflow-y-auto bg-white dark:bg-gray-800 md:block flex-shrink-0">
			<div class="py-4 text-gray-500 dark:text-gray-400">
				<a class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200">
					Admin Role </a>
				<ul class="mt-6">
					<li class="relative px-6 py-3"><span
						class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
						aria-hidden="true"></span> <a
						class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100"
						href="dashboard.jsp"> <svg class="w-5 h-5" aria-hidden="true"
								fill="none" stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" viewBox="0 0 24 24" stroke="currentColor">
                  <path
									d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                </svg> <span class="ml-4">Dashboard</span>
					</a></li>
				</ul>
				<ul>
					<li class="relative px-6 py-3"><a
						class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
						href="manage_user.jsp"> <svg class="w-5 h-5"
								aria-hidden="true" fill="none" stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24"
								stroke="currentColor">
                  <path
									d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
                </svg> <span class="ml-4">Manage Users</span>
					</a></li>
					<li class="relative px-6 py-3"><a
						class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
						href="manage_products.jsp"> <svg class="w-5 h-5"
								aria-hidden="true" fill="none" stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24"
								stroke="currentColor">
                  <path
									d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                </svg> <span class="ml-4">Manage Products</span>
					</a></li>
					<li class="relative px-6 py-3"><a
						class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
						href="manage_categories.jsp"> <svg class="w-5 h-5"
								aria-hidden="true" fill="none" stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24"
								stroke="currentColor">
                  <path
									d="M11 3.055A9.001 9.001 0 1020.945 13H11V3.055z"></path>
                  <path d="M20.488 9H15V3.512A9.025 9.025 0 0120.488 9z"></path>
                </svg> <span class="ml-4">Manage Categories</span>
					</a></li>
					<li class="relative px-6 py-3"><a
						class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
						href="manage_order.jsp"> <svg class="w-5 h-5"
								aria-hidden="true" fill="none" stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24"
								stroke="currentColor">
			            <path d="M5 11h14l-1.68 7H6.68L5 11zm0 0l-.72-2H4"></path>
			            <circle cx="6.5" cy="18.5" r="1.5"></circle>
			            <circle cx="17.5" cy="18.5" r="1.5"></circle>
			        </svg> <span class="ml-4">Manage Orders</span>
					</a></li>

					<!--   <li class="relative px-6 py-3">
              <a
                class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                href="manage_reviews.jsp"
              >
                <svg
                  class="w-5 h-5"
                  aria-hidden="true"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"
                  ></path>
                </svg>
                <span class="ml-4">Manage Reviews</span>
              </a>
            </li>  -->
			</div>
		</aside>

		<div class="flex flex-col flex-1 w-full">
			<!-- Header Start -->
				<%@ include file="header.jsp" %>
			<!-- Header End -->
			<main class="h-full overflow-y-auto">
				<div class="container px-6 mx-auto grid">
					<h2
						class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">
						Dashboard</h2>

					<!-- Cards -->
					<div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-4">
						<!-- Card -->
						<div
							class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<div
								class="p-3 mr-4 text-orange-500 bg-orange-100 rounded-full dark:text-orange-100 dark:bg-orange-500">
								<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path
										d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z"></path>
                  </svg>
							</div>
							<div>
								<p
									class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
									Total clients</p>
								<p
									class="text-lg font-semibold text-gray-700 dark:text-gray-200">
									5000</p>
							</div>
						</div>
						<!-- Card -->
						<div
							class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<div
								class="p-3 mr-4 text-green-500 bg-green-100 rounded-full dark:text-green-100 dark:bg-green-500">
								<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
										d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z"
										clip-rule="evenodd"></path>
                  </svg>
							</div>
							<div>
								<p
									class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
									Account balance</p>
								<p
									class="text-lg font-semibold text-gray-700 dark:text-gray-200">
									$ 5,00,000.00</p>
							</div>
						</div>
						<!-- Card -->
						<div
							class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<div
								class="p-3 mr-4 text-blue-500 bg-blue-100 rounded-full dark:text-blue-100 dark:bg-blue-500">
								<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path
										d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                  </svg>
							</div>
							<div>
								<p
									class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
									Total sales</p>
								<p
									class="text-lg font-semibold text-gray-700 dark:text-gray-200">
									376</p>
							</div>
						</div>
						<!-- Card -->
						<div
							class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<div
								class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
								<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
										d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z"
										clip-rule="evenodd"></path>
                  </svg>
							</div>
							<div>
								<p
									class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
									Manage Reviews</p>
								<p
									class="text-lg font-semibold text-gray-700 dark:text-gray-200">
									2000</p>
							</div>
						</div>
					</div>

					<!-- New Table -->
					<div class="w-full overflow-hidden rounded-lg shadow-xs">
						<div class="w-full overflow-x-auto">
							<table class="w-full whitespace-no-wrap">
								<thead>
									<tr
										class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
										<th class="px-4 py-3">Client</th>
										<th class="px-4 py-3">Amount</th>
										<th class="px-4 py-3">Status</th>
										<th class="px-4 py-3">Date</th>
									</tr>
								</thead>
								<tbody
									class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
									<tr class="text-gray-700 dark:text-gray-400">
										<td class="px-4 py-3">
											<div class="flex items-center text-sm">
												<!-- Avatar with inset shadow -->
												<div
													class="relative hidden w-8 h-8 mr-3 rounded-full md:block">
													<img class="object-cover w-full h-full rounded-full"
														src="https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"
														alt="" loading="lazy" />
													<div class="absolute inset-0 rounded-full shadow-inner"
														aria-hidden="true"></div>
												</div>
												<div>
													<p class="font-semibold">Sandeep Maheshwari</p>
													<p class="text-xs text-gray-600 dark:text-gray-400">
														Software Developer</p>
												</div>
											</div>
										</td>
										<td class="px-4 py-3 text-sm">$ 863.45</td>
										<td class="px-4 py-3 text-xs"><span
											class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">
												Approved </span></td>
										<td class="px-4 py-3 text-sm">2/10/2025</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div
							class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800">
							<span class="flex items-center col-span-3"> Show 1 page </span> <span
								class="col-span-2"></span>
							<!-- Pagination -->
							<span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
								<nav aria-label="Table navigation">
									<ul class="inline-flex items-center">
										<li>
											<button
												class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
												aria-label="Previous">
												<svg aria-hidden="true" class="w-4 h-4 fill-current"
													viewBox="0 0 20 20">
                            <path
														d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
														clip-rule="evenodd" fill-rule="evenodd"></path>
                          </svg>
											</button>
										</li>
										<li>
											<button
												class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
												1</button>
										</li>
										<li>
											<button
												class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
												aria-label="Next">
												<svg class="w-4 h-4 fill-current" aria-hidden="true"
													viewBox="0 0 20 20">
                            <path
														d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
														clip-rule="evenodd" fill-rule="evenodd"></path>
                          </svg>
											</button>
										</li>
									</ul>
								</nav>
							</span>
						</div>
					</div>

					<!-- Charts -->
					<h2
						class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">
						Charts</h2>
					<div class="grid gap-6 mb-8 md:grid-cols-2">
						<div
							class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<h4 class="mb-4 font-semibold text-gray-800 dark:text-gray-300">
								Product-Performance</h4>
							<canvas id="pie"></canvas>
							<div
								class="flex justify-center mt-4 space-x-3 text-sm text-gray-600 dark:text-gray-400">
								<!-- Chart legend -->
								<div class="flex items-center">
									<span
										class="inline-block w-3 h-3 mr-1 bg-black-800 rounded-full"></span>
									<span>Fruits</span>
								</div>
								<div class="flex items-center">
									<span
										class="inline-block w-3 h-3 mr-1 bg-teal-600 rounded-full"></span>
									<span>Dry-Fruits</span>
								</div>
								<div class="flex items-center">
									<span
										class="inline-block w-1 h-1 mr-1 bg-purple-700 rounded-full"></span>
									<span>Vegetables</span>
								</div>
							</div>
						</div>
						<div
							class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
							<h4 class="mb-4 font-semibold text-gray-800 dark:text-gray-300">
								Growth</h4>
							<canvas id="line"></canvas>
							<div
								class="flex justify-center mt-4 space-x-3 text-sm text-gray-600 dark:text-gray-400">
								<!-- Chart legend -->
								<div class="flex items-center">
									<span
										class="inline-block w-3 h-3 mr-1 bg-teal-600 rounded-full"></span>
									<span>Fruits</span>
								</div>
								<div class="flex items-center">
									<span
										class="inline-block w-3 h-3 mr-1 bg-purple-600 rounded-full"></span>
									<span>Vegetables</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>
