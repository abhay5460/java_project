<%@page import="com.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if the user is logged in
    HttpSession session2 = request.getSession(false);
    if (session2 == null || session2.getAttribute("admin_id") == null) {
        response.sendRedirect("admin-index.jsp"); // Redirect to login page if not logged in
        return; // Stop further processing
    }

    // Pagination logic
    int pageSize = 5; // Number of records per page (changed from 10 to 5)
    int pageNumber = 1; // Default page number
    if (request.getParameter("page") != null) {
        pageNumber = Integer.parseInt(request.getParameter("page"));
    }

    // Search functionality
    String searchQuery = request.getParameter("search");
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();

    // Filter categories based on search query
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        categories = categories.stream()
            .filter(c -> c.getCategoryName().toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
    }

    int totalCategories = categories.size();
    int totalPages = (int) Math.ceil((double) totalCategories / pageSize);
    int startIndex = (pageNumber - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalCategories);
    List<Category> paginatedCategories = categories.subList(startIndex, endIndex);

%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Categories</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="./assets/css/tailwind.output.css" />
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
    <script src="./assets/js/init-alpine.js"></script>
    <style>
        /* Add your custom styles here */
        .table-container {
            width: 100%;
            overflow-x: auto; /* Enables horizontal scrolling on small screens */
        }
        .responsive-table {
            width: 100%; /* Full width */
            border-collapse: collapse; /* Collapses borders */
        }
        .responsive-table th, .responsive-table td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd; /* Border for table cells */
        }
        .responsive-table tr:hover {
            background-color: #f1f1f1; /* Highlight on hover */
        }
        .button {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            color: white;
            background-color: #4f46e5; /* Indigo */
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #4338ca; /* Darker Indigo */
        }
        .button.delete {
            background-color: #ef4444; /* Red */
        }
        .button.delete:hover {
            background-color: #dc2626; /* Darker Red */
        }
        .table-header {
            background-color: #f3f4f6; /* Light Gray */
        }
    </style>
</head>
<body>
    <div class="flex h-screen bg-gray-50 dark:bg-gray-900">
        <!-- Sidebar -->
        <%@ include file="aside.jsp" %>    
        <!-- Sidebar -->
        <div class="flex flex-col flex-1 w-full">
           <header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
                <div class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Manage Categories</h2>
                    <!-- Search input and button -->
                                        <div class="flex items-center">
                        <form action="manage_categories.jsp" method="get" class="flex items-center">
                            <input type="text" name="search" placeholder="Search for Category"
                                   value="<%=searchQuery != null ? searchQuery : ""%>"
                                   class="px-4 py-2 border rounded-md" />
                            <button type="submit" class="ml-2 px-4 py-2 text-white bg-blue-600 rounded">Search</button>
                        </form>
                        <a href="add_category.jsp" class="ml-4 px-4 py-2 text-white bg-blue-600 rounded">Add Category</a>
                    </div>
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
                            <button class="align-middle rounded-full focus:shadow-outline-purple focus:outline-none"
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
                                        href="">Profile</a></li>
                                    <li class="flex"><a
                                        class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200"
                                        href="../adminController?action=logout">Log out</a></li>
                                </ul>
                            </template>
                        </li>
                    </ul>
                </div>
            </header>
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">
                    <div class="w-full overflow-hidden rounded-lg shadow-xs">
                        <div class="table-container">
                            <table class="responsive-table">
                                <thead>
                                                                        <tr class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 table-header">
                                        <th class="px-4 py-3">Category ID</th>
                                        <th class="px-4 py-3">Category Name</th>
                                        <th class="px-4 py-3">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                    for (Category category : paginatedCategories) {
                                    %>
                                    <tr class="hover:bg-gray-100 dark:hover:bg-gray-700 transition duration-150">
                                        <td class="border px-4 py-2"><%= category.getCategoryId() %></td>
                                        <td class="border px-4 py-2"><%= category.getCategoryName() %></td>
                                        <td class="border px-4 py-2">
                                            <a href="edit_category.jsp?id=<%= category.getCategoryId() %>" class="button">Edit</a>
                                            <a href="delete_category.jsp?id=<%= category.getCategoryId() %>" class="button delete ml-4" 
                                               onclick="return confirm('Are you sure you want to delete this category?');">Delete</a>
                                        </td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800">
                            <span class="flex items-center col-span-3"> Showing <%= startIndex + 1 %> to <%= endIndex %> of <%= totalCategories %> entries </span>
                            <span class="col-span-2"></span>
                            <!-- Pagination -->
                            <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                                <nav aria-label="Table navigation">
                                    <ul class="inline-flex items-center">
                                        <li>
                                            <%
                                            if (pageNumber > 1) {
                                            %>
                                            <a href="manage_categories.jsp?page=<%= pageNumber - 1 %>&search=<%= searchQuery != null ? searchQuery : "" %>" 
                                               class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple" aria-label="Previous">
                                                <svg aria-hidden="true" class="w-4 h-4 fill-current" viewBox="0 0 20 20">
                                                    <path d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" 
                                                          clip-rule="evenodd" fill-rule="evenodd"></path>
                                                </svg>
                                            </a>
                                            <%
                                            }
                                            %>
                                        </li>
                                        <%
                                        for (int i = 1; i <= totalPages; i++) {
                                            if (i == pageNumber) {
                                        %>
                                        <li>
                                            <button class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple"><%= i %></button>
                                        </li>
                                        <%
                                            } else {
                                        %>
                                        <li>
                                            <a href="manage_categories.jsp?page=<%= i %>&search=<%= searchQuery != null ? searchQuery : "" %>" 
                                               class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"><%= i %></a>
                                        </li>
                                        <%
                                            }
                                        }
                                        %>
                                        <li>
                                            <%
                                            if (pageNumber < totalPages) {
                                            %>
                                            <a href="manage_categories.jsp?page=<%= pageNumber + 1 %>&search=<%= searchQuery != null ? searchQuery : "" %>" 
                                               class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple" aria-label="Next">
                                                <svg class="w-4 h-4 fill-current" aria-hidden="true" viewBox="0 0 20 20">
                                                    <path d="M7.293 14.707a                                                    1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" 
                                                          clip-rule="evenodd" fill-rule="evenodd"></path>
                                                </svg>
                                            </a>
                                            <%
                                            }
                                            %>
                                        </li>
                                    </ul>
                                </nav>
                            </span>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

  

</body>
</html>