<%@page import="com.dao.CustomerDAO"%>
<%@page import="com.model.Customer"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Check if the user is logged in
HttpSession session2 = request.getSession(false);
if (session2 == null || session2.getAttribute("admin_id") == null) {
    response.sendRedirect("admin/admin-index.jsp");
    return;
} 

// Fetch the customer ID from the request
int customerId = Integer.parseInt(request.getParameter("id"));

// Use the DAO to get the customer object
CustomerDAO dao = new CustomerDAO();
Customer customer = dao.getCustomerById(customerId); // Fetch the customer object
%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Customer</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="./assets/css/tailwind.output.css" />
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
    <script src="./assets/js/init-alpine.js"></script>
</head>
<body>
    <div class="flex h-screen bg-gray-50 dark:bg-gray-900">
        <!-- Sidebar -->
        <%@ include file="aside.jsp" %>
        <!-- Sidebar -->
        <div class="flex flex-col flex-1 w-full">
            <header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
                <div class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Edit Customer</h2>
                    <ul class="flex items-center flex-shrink-0 space-x-6">
                        <!-- Theme toggler -->
                        <li class="flex">
                            <button class="rounded-md focus:outline-none focus:shadow-outline-purple" @click="toggleTheme" aria-label="Toggle color mode">
                                <template x-if="!dark">
                                    <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
                                    </svg>
                                </template>
                                <template x-if="dark">
                                    <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"></path>
                                    </svg>
                                </template>
                            </button>
                        </li>
                        <!-- Profile menu -->
                        <li class="relative">
                            <button class="align-middle rounded-full focus:shadow-outline-purple focus:outline-none" @click="toggleProfileMenu" @keydown.escape="closeProfileMenu" aria-label="Account" aria-haspopup="true">
                                <img class="object-cover w-8 h-8 rounded-full" src="https://i0.wp.com/picjumbo.com/wp-content/uploads/calm-lake-surface-in-fall-free-image.jpeg?w=600&quality=80" alt="" aria-hidden="true" />
                            </button>
                            <template x-if="isProfileMenuOpen">
                                <ul x-transition:leave="transition ease-in duration-150" x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0" @click.away="closeProfileMenu" @keydown.escape="closeProfileMenu" class="absolute right-0 w-56 p-2 mt-2 space-y-2 text-gray-600 bg-white border border-gray-100 rounded-md shadow-md dark:border-gray-700 dark:text-gray-300 dark:bg-gray-700" aria-label="submenu">
                                    <li class="flex"><a class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200" href="">Profile</a></li>
                                    <li class="flex"><a class="inline-flex items-center w-full px-2 py-1 text-sm font-semibold transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200" href="../adminController?action=logout">Log out</a></li>
                                </ul>
                            </template>
                        </li>
                    </ul>
                </div>
            </header>
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid my-6">
                    <form action="../adminController" method="post">
                        <input type="hidden" name="action" value="editCustomer" />
                        <input type="hidden" name="user_id" value="<%= customer.getUser_id() %>" />

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="firstname">First Name</label>
                            <input type="text" name="firstname" id="firstname"
                                value="<%= customer.getFirstname() %>" required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="lastname">Last Name</label>
                            <input type="text" name="lastname" id="lastname"
                                value="<%=                                customer.getLastname() %>" required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="email">Email</label>
                            <input type="email" name="email" id="email"
                                value="<%= customer.getEmail() %>" required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="password">New Password (Leave blank to keep current)</label>
                            <input type="password" name="password" id="password" 
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="phoneno">Phone No</label>
                            <input type="text" name="phoneno" id="phoneno"
                                value="<%= customer.getPhoneno() %>" required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="address">Address</label>
                            <textarea name="address" id="address" required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200"><%= customer.getAddress() %></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="block text-gray-700 dark:text-gray-400" for="registrationdate">Registration Date</label>
                            <input type="date" name="registrationdate" id="registrationdate"
                                value="<%= customer.getRegistrationdate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(customer.getRegistrationdate()) : "" %>"
                                required
                                class="mt-1 block w-full p-2 border border-gray-300 rounded-md dark:bg-gray-700 dark:text-gray-200" />
                        </div>

                        <div class="flex justify-end">
                            <button type="submit"
                                class="px-4 py-2 text-white bg-blue-600 rounded hover:bg-blue-700">Update
                                Customer</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
</body>
</html>