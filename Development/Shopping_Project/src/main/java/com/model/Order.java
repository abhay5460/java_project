package com.model;

public class Order {
    private int orderId;
    private int userId; // Foreign key to the customer table
    private String orderDate;
    private double totalAmount;
    private String status;
    private String customerName; // New field for customer name

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }
    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getCustomerName() { // Getter for customer name
        return customerName;
    }
    public void setCustomerName(String customerName) { // Setter for customer name
        this.customerName = customerName;
    }
}