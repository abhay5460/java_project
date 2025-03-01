<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.model.Product"%>
<%@ page import="com.dao.ProductDAO"%>
<%
// Check if the user is logged in
HttpSession session2 = request.getSession(false);
if (session2 == null || session2.getAttribute("admin_id") == null) {
	response.sendRedirect("admin-index.jsp");
	return;
}

// Fetch the product ID from the request
int productId = Integer.parseInt(request.getParameter("id"));

// Use the DAO to get the product object
ProductDAO dao = new ProductDAO();
Product product = dao.getProductById(productId); // Fetch the product object
%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Edit Product</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/tailwind.output.css" />
<script
	src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
	defer></script>
<script src="./assets/js/init-alpine.js"></script>
</head>
<body>
	<div class="flex h-screen bg-gray-50 dark:bg-gray-900">
		<!-- Sidebar -->
		<%@ include file="aside.jsp"%>
		<!-- Sidebar -->
		<div class="flex flex-col flex-1 w-full">
			<header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
				<div
					class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
					<h2
						class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Edit
						Product</h2>
					<ul class="flex items-center flex-shrink-0 space-x-6">
						<!-- Theme toggler -->
						<li class="flex">
							<button
								class="rounded-md focus:outline-none focus:shadow-outline-purple"
								@click="toggleTheme" aria-label="Toggle color mode">
								<template x-if="!dark">
									<svg class="w-5 h-5" aria-hidden="true" fill="currentColor"
										viewBox="0 0 20 20">
                                    <path
											d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
                                </svg>
								</template>
								<template x-if="dark">
									<svg class="w-5 h-5" aria-hidden="true" fill="currentColor"
										viewBox="0 0 20 20">
                                    <path fill-rule="evenodd"
											d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
											clip-rule="evenodd"></path>
                                </svg>
								</template>
							</button>
						</li>
						<!-- Profile menu -->
						<li class="relative">
							<button
								class="align-middle rounded-full focus:shadow-outline-purple focus:outline-none"
								@click="toggleProfileMenu" @keydown.escape="closeProfileMenu"
								aria-label="Account" aria-haspopup="true">
								<img class="object-cover w-8 h-8 rounded-full"
									src="https://i0.wp.com/picjumbo.com/wp-content/uploads/calm-lake-surface-in-fall-free-image.jpeg?w=600&quality=80"
									alt="" aria-hidden="true" />
							</button>
							<template x-if="isProfileMenuOpen">
								<ul x-transition:leave="transition ease-in duration-150"
									x-transition:leave-start="opacity-100"
									x-transition:leave-end="opacity-0"
									@click.away="closeProfileMenu"
									@keydown.escape="closeProfileMenu"
									class="absolute right-0 w-56 p-2 mt-2 space-y-2 text-gray-600 bg-white border border-gray-100 rounded-md shadow-md dark:border-gray-700 dark:text-gray-300 dark:bg-gray-700"
									aria-label="submenu">
									<li class="flex"><a
										class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
										href=""> <svg class="w-4 h-4 mr-3" aria-hidden="true"
												fill="none" stroke-linecap="round" stroke-linejoin="round"
												stroke-width="2"
												viewBox="                                        0 0 24 24"
												stroke="currentColor">
                                            <path
													d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                        </svg> <span>Profile</span>
									</a></li>
									<li class="flex"><a
										class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
										href="../adminController?action=logout"> <svg
												class="w-4 h-4 mr-3" aria-hidden="true" fill="none"
												stroke-linecap="round" stroke-linejoin="round"
												stroke-width="2" viewBox="0 0 24 24" stroke="currentColor">
                                            <path
													d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path>
                                        </svg> <span>Log out</span>
									</a></li>
								</ul>
							</template>
						</li>
					</ul>
				</div>
			</header>
			<main class="h-full overflow-y-auto">
				<div class="container px-6 mx-auto grid my-6">
					<form action="../adminController" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="action" value="editProduct" /> <input
							type="hidden" name="productId"
							value="<%=product.getProductId()%>" /> 
							<input type="hidden"
							name="existingImageURL" value="<%=product.getImageURL()%>" />

						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400"
								for="productName">Product Name</label> <input type="text"
								name="productName" id="productName"
								value="<%=product.getProductName()%>" required
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400"
								for="categoryId">Category ID</label> <input type="number"
								name="categoryId" id="categoryId"
								value="<%=product.getCategoryId()%>" required
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400"
								for="description">Description</label>
							<textarea name="description" id="description" required
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200"><%=product.getDescription()%></textarea>
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400" for="price">Price
								(INR)</label> <input type="number" step="0.01" name="price" id="price"
								value="<%=product.getPrice()%>" required
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400"
								for="stockQuantity">Stock Quantity</label> <input type="number"
								name="stockQuantity" id="stockQuantity"
								value="<%=product.getStockQuantity()%>" required
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 dark:text-gray-400" for="image">Current
								Image</label>
							<div class="mt-1 mb-2">
								<img src="../<%=product.getImageURL()%>"
									alt="Current Product Image"
									class="w-32 h-32 object-cover rounded-md" />
							</div>
							<label class="block text-gray-700 dark:text-gray-400" for="image">Upload
								New Image (optional)</label> <input type="file" name="image" id="image"
								accept="image/*"
								class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200">
						</div>
						<div class="flex justify-end">
							<button type="submit"
								class="px-4 py-2 text-white bg-blue-600 rounded hover:bg-blue-700">Update
								Product</button>
						</div>
					</form>

				</div>
			</main>
		</div>
	</div>
</body>
</html>