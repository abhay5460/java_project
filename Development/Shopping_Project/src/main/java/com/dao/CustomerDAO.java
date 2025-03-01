package com.dao;

import com.model.Customer;
import com.util.DBconnection; // Ensure you have a DBconnection class for database connection

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerDAO {
	private Connection connection;

	public CustomerDAO() {
		DBconnection dbConnection = new DBconnection();
		connection = dbConnection.getConnectionData();
	}

	// Expose the method to check if the customer email or password already exists
	public boolean isCustomerExists(String email, String password) {
		String sql = "SELECT COUNT(*) FROM customer WHERE email = ? OR password = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0; // Returns true if a customer with the same email or password exists
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Method to register a new customer
	public boolean registerCustomer(Customer customer) {
		String sql = "INSERT INTO customer (firstname, lastname, email, password, phoneno, address, registrationdate) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, customer.getFirstname());
			stmt.setString(2, customer.getLastname());
			stmt.setString(3, customer.getEmail());
			stmt.setString(4, customer.getPassword()); // Make sure to hash the password before saving
			stmt.setString(5, customer.getPhoneno());
			stmt.setString(6, customer.getAddress());
			stmt.setDate(7, new java.sql.Date(customer.getRegistrationdate().getTime())); // Store registration date
			return stmt.executeUpdate() > 0; // Returns true if the customer was registered successfully
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Method to check if the customer exists for login
	public Customer loginCustomer(String email, String password) {
		String sql = "SELECT * FROM customer WHERE email = ? AND password = ?"; // Ensure password is hashed
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, email);
			stmt.setString(2, password); // Make sure to hash the password before checking
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				Customer customer = new Customer();
				customer.setUser_id(rs.getInt("user_id"));
				customer.setFirstname(rs.getString("firstname"));
				customer.setLastname(rs.getString("lastname"));
				customer.setEmail(rs.getString("email"));
				customer.setPhoneno(rs.getString("phoneno"));
				customer.setAddress(rs.getString("address"));
				customer.setRegistrationdate(rs.getDate("registrationdate")); // Fetch registration date
				return customer; // Return the customer object if login is successful
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; // Return null if login fails
	}

	public List<Customer> getAllCustomers() {
		List<Customer> customers = new ArrayList<>();
		String sql = "SELECT * FROM customer";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
			while (rs.next()) {
				Customer customer = new Customer(rs.getInt("user_id"), rs.getString("firstname"),
						rs.getString("lastname"), rs.getString("email"), rs.getString("password"),rs.getString("phoneno"),
						rs.getString("address"), rs.getDate("registrationdate"));
				customers.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return customers;
	}

	// Method to get a customer by ID
	public Customer getCustomerById(int userId) {
		if (userId <= 0) {
			throw new IllegalArgumentException("Invalid user ID");
		}

		Customer customer = null;
		String query = "SELECT * FROM customer WHERE user_id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				userId = rs.getInt("user_id");
				String firstname = rs.getString("firstname");
				String lastname = rs.getString("lastname");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String phoneno = rs.getString("phoneno");
				String address = rs.getString("address");
				Date registrationdate = rs.getDate("registrationdate");

				customer = new Customer(userId, firstname, lastname, email,password, phoneno, address, registrationdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return customer;
	}

	// Method to update a customer
	public void updateCustomer(Customer customer) {
		if (customer == null || customer.getUser_id() <= 0) {
			throw new IllegalArgumentException("Invalid customer");
		}

		String query = "UPDATE customer SET firstname = ?, lastname = ?, email = ?, password = ?,phoneno = ?, address = ? WHERE user_id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, customer.getFirstname());
			stmt.setString(2, customer.getLastname());
			stmt.setString(3, customer.getEmail());
			stmt.setString(4, customer.getPassword());
			stmt.setString(5, customer.getPhoneno());
			stmt.setString(6, customer.getAddress());
			stmt.setInt(7, customer.getUser_id());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void addCustomer(Customer customer) 
	{
	    if (customer == null ) {
	        throw new IllegalArgumentException("Invalid customer");
	    }

	    String query = "INSERT INTO customer (firstname, lastname, email, password, phoneno, address ) VALUES (?, ?, ?, ?, ?, ?)";

	    try (PreparedStatement stmt = connection.prepareStatement(query)) {
	        stmt.setString(1, customer.getFirstname());
	        stmt.setString(2, customer.getLastname());
	        stmt.setString(3, customer.getEmail());
	        stmt.setString(4, customer.getPassword());
	        stmt.setString(5, customer.getPhoneno());
	        stmt.setString(6, customer.getAddress());
	        stmt.executeUpdate();
	        
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}


	// Method to delete a customer by ID
	public boolean deleteCustomer(int customerId) {
		String sql = "DELETE FROM customer WHERE user_Id = ?";
		boolean isDeleted = false; // Variable to track deletion status

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, customerId);
			int rowsAffected = stmt.executeUpdate();
			isDeleted = (rowsAffected > 0); // If rowsAffected is greater than 0, deletion was successful
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isDeleted; // Return the status of the deletion
	}
}
