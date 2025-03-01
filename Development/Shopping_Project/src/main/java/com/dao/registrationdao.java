package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.model.Customer;
import java.sql.Timestamp;


public class registrationdao 
{	
	private Connection connection;
	

	 public registrationdao(Connection connection) 
	 {
	     this.connection = connection;
	 }

	 public boolean registerUser (Customer user) 
	 {
	     String sql = "INSERT INTO Customer (Firstname, Lastname, Email, Password, Phoneno, Address, Registrationdate) VALUES (?, ?, ?, ?, ?, ?, ?)";
	     try (PreparedStatement statement = connection.prepareStatement(sql)) {
	         statement.setString(1, user.getFirstname());
	         statement.setString(2, user.getLastname());
	         statement.setString(3, user.getEmail());
	         statement.setString(4, user.getPassword()); // Ensure this is hashed before storing
	         statement.setString(5, user.getPhoneno());
	         statement.setString(6, user.getAddress());
	         statement.setTimestamp(7, new Timestamp(user.getRegistrationdate().getTime()));
	         return statement.executeUpdate() > 0;
	     } 
	     catch (Exception e) 
	     {
	         e.printStackTrace();
	         return false;
	     }
	 }
}
