package com.dao;

import com.model.Customer;
import com.util.DBconnection; // Ensure you have a DBconnection class for database connection

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProfileDAO {
    private Connection connection;

    public ProfileDAO() {
        DBconnection dbConnection = new DBconnection();
        connection = dbConnection.getConnectionData();
    }

    // Method to get a customer by ID
    public Customer getCustomerById(int userId)
    {
        Customer customer = null;
        String query = "SELECT * FROM customer WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new Customer(
                    rs.getInt("user_id"),
                    rs.getString("firstname"),
                    rs.getString("lastname"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("phoneno"),
                    rs.getString("address"),
                    rs.getDate("registrationdate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    // Method to update a customer
    public void updateCustomer(Customer customer) {
        String query = "UPDATE customer SET firstname = ?, lastname = ?, email = ?, phoneno = ?, address = ? WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getFirstname());
            stmt.setString(2, customer.getLastname());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getPhoneno());
            stmt.setString(5, customer.getAddress());
            stmt.setInt(6, customer.getUser_id());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a customer by ID
    public boolean deleteCustomer(int userId) {
        String sql = "DELETE FROM customer WHERE user_id = ?";
        boolean isDeleted = false;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            isDeleted = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }
}