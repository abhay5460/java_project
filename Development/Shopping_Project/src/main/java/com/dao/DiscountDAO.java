package com.dao;

import com.model.Discount;
import com.util.DBconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {
	private Connection connection;

	public DiscountDAO() {
		DBconnection dbConnection = new DBconnection();
		connection = dbConnection.getConnectionData();
	}

	// Method to fetch all discounts
	public List<Discount> getAllDiscounts() {
		List<Discount> discounts = new ArrayList<>();
		String sql = "SELECT * FROM discount"; // Adjust the SQL query as per your database schema

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
			while (rs.next()) {
				Discount discount = new Discount();
				discount.setDiscount_id(rs.getInt("discount_id"));
				discount.setDiscount_name(rs.getString("discount_name"));
				discount.setDiscount_type(rs.getString("discount_type"));
				discount.setPercentage(rs.getDouble("percentage"));
				discount.setStart_date(rs.getTimestamp("start_date"));
				discount.setEnd_date(rs.getTimestamp("end_date"));
				discount.setStatus(rs.getString("status"));
				discounts.add(discount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return discounts;
	}

	// Optional: Method to fetch a discount by ID
	public Discount getDiscountById(int discountId) {
		Discount discount = null;
		String sql = "SELECT * FROM discount WHERE discount_id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, discountId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				discount = new Discount();
				discount.setDiscount_id(rs.getInt("discount_id"));
				discount.setDiscount_name(rs.getString("discount_name"));
				discount.setDiscount_type(rs.getString("discount_type"));
				discount.setPercentage(rs.getDouble("percentage"));
				discount.setStart_date(rs.getTimestamp("start_date"));
				discount.setEnd_date(rs.getTimestamp("end_date"));
				discount.setStatus(rs.getString("status"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return discount;
	}
}