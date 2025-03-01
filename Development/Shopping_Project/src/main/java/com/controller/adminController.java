package com.controller;

import java.io.IOException;
import java.util.Date;

import com.dao.AdminDAO;
import com.dao.CategoryDAO;
import com.dao.CustomerDAO;
import com.dao.ProductDAO;
import com.model.Admin;
import com.model.Category;
import com.model.Customer;
import com.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/adminController")
@MultipartConfig
public class adminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminDAO adminDAO;
	private CategoryDAO categoryDAO;
	private ProductDAO productDAO;
	private CustomerDAO customerDAO;

	public adminController() {
		this.adminDAO = new AdminDAO();
		this.categoryDAO = new CategoryDAO();
		this.productDAO = new ProductDAO();
		this.customerDAO = new CustomerDAO();

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action1 = req.getParameter("action");
		System.out.println("DoGet Action: " + action1);
		if ("logout".equalsIgnoreCase(action1)) {
			handleLogout(req, resp);
		} else {
			doPost(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		System.out.println("DoPostAction: " + action); // Debugging line
		if (action == null || action.trim().isEmpty()) {
			// Log the error
			System.err.println("Action parameter is missing or empty");

			// Set an error message to be displayed
			req.setAttribute("errorMessage", "The action parameter is missing. Please try again.");

			// Forward to the dashboard page to display the error message
			req.getRequestDispatcher("admin/dashboard.jsp").forward(req, resp);
			return; // Stop further processing
		}

		switch (action) {
		case "login":
			handleLogin(req, resp);
			break;
		case "addCustomer":
			handleAddCustomer(req, resp);
			break;
		case "editCustomer":
			handleEditCustomer(req, resp);
			break;
		case "deleteCustomer":
			handleDeleteCustomer(req, resp);
			break;
		case "addCategory":
			handleAddCategory(req, resp);
			break;
		case "editCategory":
			handleEditCategory(req, resp);
			break;
		case "deleteCategory":
			handleDeleteCategory(req, resp);
			break;
		case "addProduct":
			handleAddProduct(req, resp);
			break;
		case "editProduct":
			handleEditProduct(req, resp);
			break;
		case "deleteProduct":
			handleDeleteProduct(req, resp);
			break;
		case "logout":
			handleLogout(req, resp);
			break;
		default:
			System.out.println(action);
			resp.sendRedirect("admin/dashboard.jsp");
			break;
		}
	}

	private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		Admin admin = new Admin(email, password);
		boolean result = adminDAO.validateAdmin(admin);
		if (result) {
			HttpSession session = req.getSession();
			session.setAttribute("admin_id", admin.getEmail());
			resp.sendRedirect("admin/dashboard.jsp");
		} else {
			req.setAttribute("message2", "Invalid email or password. Please Try Again...");
			req.getRequestDispatcher("welcome.jsp").forward(req, resp);
		}
	}

	private void handleAddCustomer(HttpServletRequest req, HttpServletResponse resp)
	        throws IOException, ServletException {
	    try {
	        // Retrieve parameters from the request
	        String firstname = req.getParameter("firstname");
	        String lastname = req.getParameter("lastname");
	        String email = req.getParameter("email");
	        String password = req.getParameter("password");
	        String phoneno = req.getParameter("phoneno");
	        String address = req.getParameter("address");

	        
	     // Handle registration date
	        java.sql.Date registrationDate = null;
	        String registrationDateString = req.getParameter("registrationdate");
	        if (registrationDateString != null && !registrationDateString.isEmpty()) {
	            registrationDate = java.sql.Date.valueOf(registrationDateString);
	        }

	        // Create a new Customer object
	        Customer customer = new Customer(0, firstname, lastname, email, password, phoneno, address, registrationDate);

	        // Add the customer using the DAO
	        customerDAO.addCustomer(customer);
	        
	        // Redirect to the manage user page with a success message
	        resp.sendRedirect("admin/manage_user.jsp?message=Customer added successfully");
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception
	        req.setAttribute("errorMessage", "Failed to add customer: " + e.getMessage());
	        req.getRequestDispatcher("admin/add_user.jsp").forward(req, resp);
	    }
	}
	
	
	private void handleEditCustomer(HttpServletRequest req, HttpServletResponse resp)
	        throws IOException, ServletException {
	    try {
	        // Fetch the customer ID from the request
	        String userIdString = req.getParameter("user_id");
	        if (userIdString == null || userIdString.isEmpty()) {
	            throw new IllegalArgumentException("User  ID is missing.");
	        }

	        // Correctly parse the user ID from the userIdString variable
	        int userId = Integer.parseInt(userIdString); // Use userIdString instead of "user_id"
	        
	        String firstname = req.getParameter("firstname");
	        String lastname = req.getParameter("lastname");
	        String email = req.getParameter("email");
	        String password = req.getParameter("password");
	        String phoneno = req.getParameter("phoneno");
	        String address = req.getParameter("address");

	        // Use java.sql.Date for registration date
	        java.sql.Date registrationDate = null;
	        String registrationDateString = req.getParameter("registrationdate");
	        if (registrationDateString != null && !registrationDateString.isEmpty()) {
	            registrationDate = java.sql.Date.valueOf(registrationDateString);
	        }

	        Customer customer = new Customer(userId, firstname, lastname, email, password, phoneno, address, registrationDate);
	        customerDAO.updateCustomer(customer);
	        resp.sendRedirect("admin/manage_user.jsp");
	    } catch (NumberFormatException e) {
	        e.printStackTrace(); // Log the exception
	        req.setAttribute("errorMessage", "Invalid User ID format.");
	        req.getRequestDispatcher("admin/edit_user.jsp").forward(req, resp);
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception
	        req.setAttribute("errorMessage", "Failed to edit customer: " + e.getMessage());
	        req.getRequestDispatcher("admin/edit_user.jsp").forward(req, resp);
	    }
	}

	private void handleDeleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			int userId = Integer.parseInt(req.getParameter("customerId"));

			// Attempt to delete the customer
			boolean isDeleted = customerDAO.deleteCustomer(userId);

			if (isDeleted) {
				// Redirect with a success message
				resp.sendRedirect("admin/manage_user.jsp?message=Customer deleted successfully");
			} else {
				// Redirect with an error message if deletion failed
				resp.sendRedirect("admin/manage_user.jsp?error=Failed to delete customer");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace(); // Log the exception
			resp.sendRedirect("admin/manage_user.jsp?error=Invalid customer ID");
		} catch (Exception e) {
			e.printStackTrace(); // Log the exception
			resp.sendRedirect("admin/manage_user.jsp?error=An error occurred while deleting the customer");
		}
	}

	private void handleAddCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String categoryName = req.getParameter("categoryName");
		String description = req.getParameter("description");
		int discountId = Integer.parseInt(req.getParameter("discountId"));

		Category category = new Category(0, categoryName, description, discountId);
		categoryDAO.addCategory(category);
		resp.sendRedirect("admin/manage_categories.jsp");
	}

	private void handleEditCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int categoryId = Integer.parseInt(req.getParameter("categoryId"));
		String categoryName = req.getParameter("categoryName");
		String description = req.getParameter("description");
		int discountId = Integer.parseInt(req.getParameter("discountId"));

		Category category = new Category(categoryId, categoryName, description, discountId);
		categoryDAO.updateCategory(category);
		resp.sendRedirect("admin/manage_categories.jsp");
	}

	private void handleDeleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int categoryId = Integer.parseInt(req.getParameter("categoryId"));
		categoryDAO.deleteCategory(categoryId);
		resp.sendRedirect("admin/manage_categories.jsp");
	}

	private void handleAddProduct(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		try {
			String productName = req.getParameter("productName");
			int categoryId = Integer.parseInt(req.getParameter("categoryId"));
			String description = req.getParameter("description");
			double price = Double.parseDouble(req.getParameter("price"));
			int stockQuantity = Integer.parseInt(req.getParameter("stockQuantity"));

			// Retrieve the image part from the request
			Part imagePart = req.getPart("image");

			Product product = new Product();
			product.setProductName(productName);
			product.setCategoryId(categoryId);
			product.setDescription(description);
			product.setPrice(price);
			product.setStockQuantity(stockQuantity);

			// Pass the product and image part to the DAO
			productDAO.addProduct(product, imagePart);
			resp.sendRedirect("admin/manage_products.jsp");
		} catch (Exception e) {
			e.printStackTrace(); // Log the exception
			req.setAttribute("errorMessage", "Failed to add product: " + e.getMessage());
			req.getRequestDispatcher("/addProduct.jsp").forward(req, resp);
		}
	}

	private void handleEditProduct(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		try {
			int productId = Integer.parseInt(req.getParameter("productId"));
			String productName = req.getParameter("productName");
			int categoryId = Integer.parseInt(req.getParameter("categoryId"));
			String description = req.getParameter("description");
			double price = Double.parseDouble(req.getParameter("price"));
			int stockQuantity = Integer.parseInt(req.getParameter("stockQuantity"));

			// Retrieve the image part from the request
			Part imagePart = req.getPart("image");

			// Retrieve the existing image URL from the hidden input field
			String existingImageURL = req.getParameter("existingImageURL");

			Product product = new Product();
			product.setProductId(productId);
			product.setProductName(productName);
			product.setCategoryId(categoryId);
			product.setDescription(description);
			product.setPrice(price);
			product.setStockQuantity(stockQuantity);
			product.setImageURL(existingImageURL); // Set the existing image URL

			// Pass the product, image part, and existing image URL to the DAO
			productDAO.updateProduct(product, imagePart, existingImageURL);
			resp.sendRedirect("admin/manage_products.jsp");
		} catch (Exception e) {
			e.printStackTrace(); // Log the exception
			req.setAttribute("errorMessage", "Failed to edit product: " + e.getMessage());
			req.getRequestDispatcher("/editProduct.jsp").forward(req, resp);
		}
	}

	private void handleDeleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			int productId = Integer.parseInt(req.getParameter("productId"));

			// Attempt to delete the product
			boolean isDeleted = productDAO.deleteProduct(productId);

			if (isDeleted) {
				// Redirect with a success message
				resp.sendRedirect("admin/manage_products.jsp?message=Product deleted successfully");
			} else {
				// Redirect with an error message if deletion failed
				resp.sendRedirect("admin/manage_products.jsp?error=Failed to delete product");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace(); // Log the exception
			resp.sendRedirect("admin/manage_products.jsp?error=Invalid product ID");
		} catch (Exception e) {
			e.printStackTrace(); // Log the exception
			resp.sendRedirect("admin/manage_products.jsp?error=An error occurred while deleting the product");
		}
	}

	private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate(); // Invalidate the session

			resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
			resp.setDateHeader("Expires", 0); // Proxies

			System.out.println("Session invalidated successfully.");
		} else {
			System.out.println("No active session found.");
		}
		resp.sendRedirect("admin/admin-index.jsp"); // Redirect to the login page
	}
}