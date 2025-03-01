package com.controller;

import com.dao.OrderDAO;
import com.model.Order;
import com.model.Order_Details;
import com.model.Payment;
import com.model.Shipping;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO(); // Initialize your DAO here
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("createOrder".equals(action)) {
            createOrder(request, response);
        } else if ("updateStatus".equals(action)) {
            updateOrderStatus(request, response);
        } else if ("refund".equals(action)) {
            processRefund(request, response);
        }
    }


 // Inside your createOrder method
 private void createOrder(HttpServletRequest request, HttpServletResponse response) 
         throws IOException {
     try {
         // Retrieve order details from the request
         int userId = Integer.parseInt(request.getParameter("userId"));
         String orderDate = request.getParameter("orderDate");
         double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
         String status = "Pending"; // Default status
         String customerName = request.getParameter("customerName");

         // Create Order object
         Order order = new Order();
         order.setUserId(userId);
         order.setOrderDate(orderDate);
         order.setTotalAmount(totalAmount);
         order.setStatus(status);
         order.setCustomerName(customerName);

         // Create the order and get the generated order ID
         int orderId = orderDAO.createOrder(order);

         // Create payment information
         Payment payment = new Payment();
         payment.setOrder_id(orderId);
         payment.setPayment_Method(request.getParameter("paymentMethod"));
         payment.setPayment_amount(Integer.parseInt(request.getParameter("paymentAmount")));

         // Convert String to LocalDate
         String paymentDateString = request.getParameter("paymentDate"); // Assuming you get this from the request
         try {
             LocalDate paymentDate = LocalDate.parse(paymentDateString, DateTimeFormatter.ISO_DATE); // Adjust format as necessary
             payment.setPayment_date(paymentDate);
         } catch (DateTimeParseException e) {
             response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payment date format");
             return;
         }

         payment.setPayment_status("Completed");
         payment.setTransaction_id(Integer.parseInt(request.getParameter("transactionId")));
         orderDAO.createPayment(payment); // Use the same DAO for payment

         // Create shipping information
         Shipping shipping = new Shipping();
         shipping.setOrder_id(orderId);
         shipping.setShipping_address(request.getParameter("shippingAddress"));
         shipping.setShipping_Status("Pending");
         shipping.setTracking_Number(request.getParameter("trackingNumber"));
         orderDAO.createShipping(shipping); // Use the same DAO for shipping

         response.getWriter().println("Order created successfully with ID: " + orderId);
     } catch (SQLException e) {
         e.printStackTrace();
         response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error creating order");
     } catch (NumberFormatException e) {
         response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input data");
     }
 }
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");

        boolean isUpdated = orderDAO.updateOrderStatus(orderId, newStatus);
        if (isUpdated) {
            response.getWriter().println("Order status updated to: " + newStatus);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update order status");
        }
    }

    private void processRefund(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        boolean isRefunded = orderDAO.processRefund(orderId);
        if (isRefunded) {
            response.getWriter().println("Refund processed successfully for order ID: " + orderId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to process refund");
        }
    }
}