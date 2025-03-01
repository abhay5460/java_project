package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.model.Admin;
import com.util.DBconnection; // Ensure this is the correct import for your DBConnection class

public class AdminDAO
{
    private DBconnection dbConnection = new DBconnection();

    /**
     * Validates the admin's email and password against the database.
     * 
     * @param admin The Admin object containing email and password.
     * @return true if the email and password match a record in the database, false
     *         otherwise.
     */
    public boolean validateAdmin(Admin admin) {
        boolean isValid = false;
        String query = "SELECT * FROM admin WHERE admin_email = ? AND admin_password = ?"; // Adjust table name and column names as necessary

        try (Connection connection = dbConnection.getConnectionData(); // Get a connection from your DBConnection class
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            preparedStatement.setString(1, admin.getEmail());
            preparedStatement.setString(2, admin.getPassword());

            // Execute the query
            ResultSet resultSet = preparedStatement.executeQuery();
            isValid = resultSet.next(); // If a record is found, isValid will be true

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }

        return isValid; // Return the result of the validation
    }
}