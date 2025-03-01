package com.controller;

import com.model.Customer;
import com.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("logout".equalsIgnoreCase(action)) {
		    // Handle customer logout
		    HttpSession session = request.getSession(false); // Get the current session
		    if (session != null) {
		        session.removeAttribute("customerId");
		        session.removeAttribute("customerName");
		        session.invalidate(); // Invalidate the session
		    }

		    
		    response.sendRedirect("index.jsp"); // Redirect to home page after logout
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		CustomerDAO customerDAO = new CustomerDAO();
		System.out.println("Request Received");

		if ("register".equalsIgnoreCase(action)) {
			// Handle customer registration
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String email = request.getParameter("email");
			String password = request.getParameter("password"); // Hash this password before saving
			String phone = request.getParameter("phoneno");
			String address = request.getParameter("address");

			if (customerDAO.isCustomerExists(email, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("errorMessage", "Registration failed, Email is Already Registered.");
				response.sendRedirect("registration.jsp");
			} else {
				Customer newCustomer = new Customer();
				newCustomer.setFirstname(firstName);
				newCustomer.setLastname(lastName);
				newCustomer.setEmail(email);
				newCustomer.setPassword(password); // Hash the password here
				newCustomer.setPhoneno(phone);
				newCustomer.setAddress(address);
				newCustomer.setRegistrationdate(new Date()); // Set the registration date to now
				boolean isRegistered = customerDAO.registerCustomer(newCustomer);

				if (isRegistered) {
					// Set a success message in the session
					HttpSession session = request.getSession();
					session.setAttribute("registrationSuccess", "Registration successful! Please log in.");
					response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
				} else {
					request.setAttribute("errorMessage", "Registration failed. Please try again.");
					request.getRequestDispatcher("registration.jsp").forward(request, response);
				}
			}

		} else if ("login".equalsIgnoreCase(action)) {
			// Handle customer login
			String email = request.getParameter("email");
			String password = request.getParameter("password"); // Hash this password before checking

			Customer customer = customerDAO.loginCustomer(email, password);
			if (customer != null) {
				HttpSession session = request.getSession();
				session.setAttribute("customerId", customer.getUser_id());
				session.setAttribute("customerName", customer.getFirstname());
				response.sendRedirect("index.jsp"); // Redirect to shop page after successful login
			} else {
				request.setAttribute("errorMessage", "Invalid email or password.");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else {
			response.getWriter().println("Something Weird Happened, " + action);
		}
	}
}