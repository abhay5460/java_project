package com.controller;

import com.model.Customer;
import com.dao.AdminDAO;
import com.dao.CategoryDAO;
import com.dao.CustomerDAO;
import com.dao.ProductDAO;
import com.dao.ProfileDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileDAO ProfileDAO;

	public ProfileController() {
		this.ProfileDAO = new ProfileDAO();
	}

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProfileDAO customerDAO = new ProfileDAO();

        if ("viewProfile".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("customerId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (int) session.getAttribute("customerId");
            Customer user = customerDAO.getCustomerById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("view_profile.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "User  not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else if ("deleteCustomer".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("customerId"));
            customerDAO.deleteCustomer(userId);
            response.sendRedirect("login.jsp"); // Redirect to login or home page after deletion
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProfileDAO customerDAO = new ProfileDAO();

        if ("editUser ".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phoneno");
            String address = request.getParameter("address");

            Customer customer = new Customer(userId, firstName, lastName, email, null, phone, address, null);
            customerDAO.updateCustomer(customer);
            response.sendRedirect("../ProfileController?action=viewprofile");
        }
    }
}