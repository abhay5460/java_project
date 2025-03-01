package com.dao;

import com.model.Category;
import com.util.DBconnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	private Connection connection;

	public CategoryDAO() {
		DBconnection dbConnection = new DBconnection();
		connection = dbConnection.getConnectionData();
	}

	public List<Category> getAllCategories() {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT * FROM category";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
			while (rs.next()) {
				Category category = new Category(rs.getInt("category_Id"), rs.getString("category_Name"),
						rs.getString("description"), rs.getInt("discount_Id"));
				categories.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return categories;
	}

	public void addCategory(Category category) {
		if (category == null || category.getCategoryName() == null || category.getDescription() == null) {
			throw new IllegalArgumentException("Category name and description cannot be null");
		}

		String query = "INSERT INTO category (category_Name, description, discount_Id) VALUES (?, ?, ?)";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setString(1, category.getCategoryName());
			stmt.setString(2, category.getDescription());
			stmt.setInt(3, category.getDiscountId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Category getCategoryById(int categoryId) {
		if (categoryId <= 0) {
			throw new IllegalArgumentException("Invalid category ID");
		}

		Category category = null;
		String query = "SELECT * FROM category WHERE category_Id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setInt(1, categoryId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				String categoryName = rs.getString("category_Name");
				String description = rs.getString("description");
				int discountId = rs.getInt("discount_Id");

				category = new Category(categoryId, categoryName, description, discountId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return category;
	}

	public void updateCategory(Category category) {
		if (category == null || category.getCategoryId() <= 0) {
			throw new IllegalArgumentException("Invalid category");
		}

		String query = "UPDATE category SET category_Name = ?, description = ?, discount_Id = ? WHERE category_Id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setString(1, category.getCategoryName());
			stmt.setString(2, category.getDescription());
			stmt.setInt(3, category.getDiscountId());
			stmt.setInt(4, category.getCategoryId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void deleteCategory(int categoryId) {
		if (categoryId <= 0) {
			throw new IllegalArgumentException("Invalid category ID");
		}
		String query = "DELETE FROM category WHERE category_Id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setInt(1, categoryId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}


