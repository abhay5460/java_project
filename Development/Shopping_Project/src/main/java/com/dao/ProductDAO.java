package com.dao;

import com.model.Product;
import com.util.DBconnection;

import jakarta.servlet.http.Part;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.io.IOException;

public class ProductDAO {
	private Connection connection;

	public ProductDAO() {
		DBconnection dbConnection = new DBconnection();
		connection = dbConnection.getConnectionData();
	}

	public List<Product> getProductsByCategory(int categoryId) {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM product WHERE category_Id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, categoryId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("product_Id"));
				product.setProductName(rs.getString("product_Name"));
				product.setCategoryId(rs.getInt("category_Id"));
				product.setDescription(rs.getString("description"));
				product.setPrice(rs.getDouble("price")); // Ensure this is in INR
				product.setStockQuantity(rs.getInt("stockQuantity"));
				product.setImageURL(rs.getString("imageURL"));
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}

	public Product getProductById(int productId) {
		Product product = null;
		String sql = "SELECT * FROM product WHERE product_Id = ?"; // Adjust the table name and column names as needed

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, productId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				product = new Product();
				product.setProductId(rs.getInt("product_Id"));
				product.setProductName(rs.getString("product_Name"));
				product.setCategoryId(rs.getInt("category_Id"));
				product.setDescription(rs.getString("description"));
				product.setPrice(rs.getDouble("price")); // Ensure this is in INR
				product.setStockQuantity(rs.getInt("stockQuantity"));
				product.setImageURL(rs.getString("imageURL"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return product;
	}

	public void addProduct(Product product, Part imagePart) {
		String sql = "INSERT INTO product (product_Name, category_Id, description, price, stockQuantity, imageURL) VALUES (?, ?, ?, ?, ?, ?)";

		try {
			// Check if the imagePart is not null and has a size greater than 0
			if (imagePart != null && imagePart.getSize() > 0) {
				// Save the image to a specific directory
				String relativeImagePath = "assets/images/" + imagePart.getSubmittedFileName();
				String absoluteImagePath = "C:\\Users\\gajja\\eclipse-workspace\\Shopping_Project\\src\\main\\webapp\\"
						+ relativeImagePath;
				File file = new File(absoluteImagePath);
				imagePart.write(file.getAbsolutePath()); // Save the file

				try (PreparedStatement stmt = connection.prepareStatement(sql)) {
					stmt.setString(1, product.getProductName());
					stmt.setInt(2, product.getCategoryId());
					stmt.setString(3, product.getDescription());
					stmt.setDouble(4, product.getPrice());
					stmt.setInt(5, product.getStockQuantity());
					stmt.setString(6, relativeImagePath); // Store the relative image path in the database
					stmt.executeUpdate();
				}
			} else {
				// Handle the case where no image is uploaded
				throw new IllegalArgumentException("Image part cannot be null or empty.");
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	public void updateProduct(Product product, Part imagePart, String existingImageURL) {
		String sql = "UPDATE product SET product_Name = ?, category_Id = ?, description = ?, price = ?, stockQuantity = ?, imageURL = ? WHERE product_Id = ?";

		try {
			String relativeImagePath = existingImageURL; // Use the existing image URL by default
			if (imagePart != null && imagePart.getSize() > 0) {
				// Save the new image to a specific directory
				relativeImagePath = "assets/images/" + imagePart.getSubmittedFileName();
				String absoluteImagePath = "C:\\Users\\gajja\\eclipse-workspace\\Shopping_Project\\src\\main\\webapp\\"
						+ relativeImagePath;
				File file = new File(absoluteImagePath);
				imagePart.write(file.getAbsolutePath()); // Save the file
			}

			try (PreparedStatement stmt = connection.prepareStatement(sql)) {
				stmt.setString(1, product.getProductName());
				stmt.setInt(2, product.getCategoryId());
				stmt.setString(3, product.getDescription());
				stmt.setDouble(4, product.getPrice());
				stmt.setInt(5, product.getStockQuantity());
				stmt.setString(6, relativeImagePath); // Store the relative image path in the database
				stmt.setInt(7, product.getProductId());
				stmt.executeUpdate();
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	public boolean deleteProduct(int productId) {
		String sql = "DELETE FROM product WHERE product_Id = ?";
		boolean isDeleted = false; // Variable to track deletion status

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, productId);
			int rowsAffected = stmt.executeUpdate();
			isDeleted = (rowsAffected > 0); // If rowsAffected is greater than 0, deletion was successful
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isDeleted; // Return the status of the deletion
	}

	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM product"; // Adjust the table name as necessary

		try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("product_Id"));
				product.setProductName(rs.getString("product_Name"));
				product.setCategoryId(rs.getInt("category_Id"));
				product.setDescription(rs.getString("description"));
				product.setPrice(rs.getDouble("price")); // Ensure this is in INR
				product.setStockQuantity(rs.getInt("stockQuantity"));
				product.setImageURL(rs.getString("imageURL"));
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}
}