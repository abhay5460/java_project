package com.controller;

import com.dao.CategoryDAO;
import com.dao.DiscountDAO;
import com.dao.ProductDAO;
import com.model.Category;
import com.model.Discount;
import com.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the action parameter
		String action = request.getParameter("action");

		if ("view".equals(action)) {
			// Get the product ID from the request parameter
			String productIdParam = request.getParameter("id");
			int productId = Integer.parseInt(productIdParam);

			// Create DAO instance
			ProductDAO productDAO = new ProductDAO();

			// Fetch product details by product ID
			Product product = productDAO.getProductById(productId);

			// Check if product exists
			if (product != null) {
				request.setAttribute("product", product);
				request.getRequestDispatcher("single-product.jsp").forward(request, response);
			} else {
				// Handle product not found scenario
				request.setAttribute("error", "Product not found");
				request.getRequestDispatcher("error.jsp").forward(request, response); // Redirect to an error page
			}
		} else {
			// Handle other actions (e.g., fetching products by category)
			String categoryIdParam = request.getParameter("categoryId");
			int categoryId = (categoryIdParam != null && !categoryIdParam.isEmpty()) ? Integer.parseInt(categoryIdParam)
					: 0;

			// Create DAO instances
			ProductDAO productDAO = new ProductDAO();
			CategoryDAO categoryDAO = new CategoryDAO();
			DiscountDAO discountDAO = new DiscountDAO();

			// Fetch all categories
			List<Category> categories = categoryDAO.getAllCategories();

			// Fetch products by category
			List<Product> products = productDAO.getProductsByCategory(categoryId); // Fetch products based on category
																					// ID

			// Fetch all discounts
			List<Discount> discounts = discountDAO.getAllDiscounts();

			// Set attributes for JSP
			request.setAttribute("products", products);
			request.setAttribute("categories", categories);
			request.setAttribute("discounts", discounts);

			// Forward to shop.jsp
			request.getRequestDispatcher("shop.jsp").forward(request, response);
		}
	}
}