package com.dao;

import com.model.Order;
import com.model.Order_Details;
import com.model.Payment;
import com.model.Shipping;
import com.util.DBconnection; // Assuming you have a utility class for DB connection

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;

    // Constructor to get the existing database connection
    public OrderDAO() {
        this.connection = new DBconnection().getConnectionData(); // Use your existing connection utility
    }

    // Method to get all orders with customer details
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_id, o.order_date, o.total_amount, o.status, c.firstname " +
                       "FROM orders o " +
                       "INNER JOIN customer c ON o.user_id = c.user_id"; // Adjust the table names as necessary

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getString("order_date")); // Assuming order_date is stored as a String
                order.setTotalAmount(rs.getDouble("total_amount")); // Assuming total_amount is a double
                order.setStatus(rs.getString("status")); // Assuming status is a String
                order.setCustomerName(rs.getString("firstname")); // Set customer name
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Method to create a new order
    public int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, order_date, total_amount, status, customerName) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, order.getUserId());
            pstmt.setString(2, order.getOrderDate());
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getCustomerName());
            pstmt.executeUpdate();

            // Get the generated order ID
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Return the generated order ID
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
    }

    // Method to create order details
    public void createOrderDetails(Order_Details orderDetails) throws SQLException {
        String sql = "INSERT INTO order_details (OrderId, ProductId, Quantity, Price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, orderDetails.getOrderId());
            pstmt.setInt(2, orderDetails.getProductId());
            pstmt.setInt(3, orderDetails.getQuantity());
            pstmt.setBigDecimal(4, orderDetails.getPrice());
            pstmt.executeUpdate();
        }
    }

    // Method to create payment
    public void createPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO payments (Order_id, Payment_Method, Payment_amount, Payment_date, Payment_status, Transaction_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, payment.getOrder_id());
            pstmt.setString(2, payment.getPayment_Method());
            pstmt.setInt(3, payment.getPayment_amount());
            pstmt.setString(4, payment.getPayment_date().toString()); // Adjust as necessary
            pstmt.setString(5, payment.getPayment_status());
            pstmt.setInt(6, payment.getTransaction_id());
            pstmt.executeUpdate();
        }
    }

    // Method to create shipping
    public void createShipping(Shipping shipping) throws SQLException {
        String sql = "INSERT INTO shipping (Order_id, Shipping_address, Shipping_Status, Tracking_Number) VALUES (?, ?, ?, ?)";
        try (PreparedStatement            pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, shipping.getOrder_id());
            pstmt.setString(2, shipping.getShipping_address());
            pstmt.setString(3, shipping.getShipping_Status());
            pstmt.setString(4, shipping.getTracking_Number());
            pstmt.executeUpdate();
        }
    }

    // Method to get order details by order ID
    public Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT o.order_id, o.user_id, o.order_date, o.total_amount, o.status, c.firstname " +
                       "FROM orders o " +
                       "INNER JOIN customer c ON o.user_id = c.user_id " +
                       "WHERE o.order_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, orderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getString("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    // You can also set customer name if you want to include it in the Order model
                    // order.setCustomerName(rs.getString("customer_name")); // Uncomment if you add customerName to Order model
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    // Method to update order status
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0; // Returns true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to process a refund (this is just an example, adjust as necessary)
    public boolean processRefund(int orderId) {
        // Implement refund logic here (e.g., update order status, adjust inventory, etc.)
        // For demonstration, we'll just update the order status to "Refunded"
        return updateOrderStatus(orderId, "Refunded");
    }
}