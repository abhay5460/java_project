package com.controller;

import com.model.Cart_Items;
import com.dao.CartDAO; // Import your CartDAO class
import com.dao.ProductDAO; // Import your ProductDAO class
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Check if the user is logged in
        if (session.getAttribute("customerId") == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        CartDAO cartDAO = new CartDAO();
        int userId = (Integer) session.getAttribute("customerId"); // Assuming customerId is stored in session
        int cartId = cartDAO.getCartIdByUserId(userId); // Get the cart_id for the user

        // If no cart exists, create a new one
        if (cartId == -1) {
            cartId = cartDAO.createCart(userId);
        }

        if ("add".equals(action)) {
            // Add item to cart
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Check if the product exists in the database
            ProductDAO obj = new ProductDAO();
            if (obj.getProductById(productId) == null) {
                response.sendRedirect("error.jsp?message=Product not found");
                return;
            }

            // Check if the item already exists in the database cart_details
            Cart_Items existingItem = cartDAO.getCartItem(cartId, productId);

            if (existingItem != null) {
                // Update quantity if item exists
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                cartDAO.updateItemQuantity(cartId, productId, existingItem.getQuantity()); // Update in database
            } else {
                // If the item does not exist, create a new Cart_Items object
                Cart_Items newItem = new Cart_Items();
                newItem.setCart_id(cartId); // Set the cart_id
                newItem.setProduct_id(productId);
                newItem.setQuantity(quantity);
                cartDAO.addItemToCart(cartId, productId, quantity); // Add to database
            }

            response.sendRedirect("cart.jsp");

        } else if ("remove".equals(action)) {
            // Remove item from cart
            int productId = Integer.parseInt(request.getParameter("productId"));
            cartDAO.removeItemFromCart(cartId, productId); // Remove from database
            response.sendRedirect("cart.jsp");

        } else if ("update".equals(action)) {
            // Update item quantity in cart
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            cartDAO.updateItemQuantity(cartId, productId, quantity); // Update in database
            response.sendRedirect("cart.jsp");

        } else {
            // If action is not recognized, redirect to cart.jsp
            response.sendRedirect("cart.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Call doGet to handle the POST request
        doGet(request, response);
    }
}