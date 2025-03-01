package com.dao;

import com.model.Cart_Items;
import com.util.DBconnection; // Import your DBconnection class
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
	private DBconnection dbConnection = new DBconnection(); // Create an instance of DBconnection

	// Method to create a new cart for a user
	public int createCart(int userId) {
		int cartId = -1; // Default value if cart creation fails
		String query = "INSERT INTO cart (user_id) VALUES (?)";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
			stmt.setInt(1, userId);
			stmt.executeUpdate();

			// Retrieve the generated cart_id
			ResultSet generatedKeys = stmt.getGeneratedKeys();
			if (generatedKeys.next()) {
				cartId = generatedKeys.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
		return cartId;
	}

	// Method to get cart_id by user_id
	public int getCartIdByUserId(int userId) {
		int cartId = -1; // Default value if no cart is found
		String query = "SELECT cart_id FROM cart WHERE user_id = ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				cartId = rs.getInt("cart_id");
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
		return cartId;
	}

	// Method to add an item to the cart
	public void addItemToCart(int cartId, int productId, int quantity) {
		String query = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?) "
				+ "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, cartId);
			stmt.setInt(2, productId);
			stmt.setInt(3, quantity);
			stmt.setInt(4, quantity); // Update quantity if the item already exists
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
	}

	// Method to remove an item from the cart
	public void removeItemFromCart(int cartId, int productId) {
		String query = "DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, cartId);
			stmt.setInt(2, productId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
	}

	// Method to update the quantity of an item in the cart
	public void updateItemQuantity(int cartId, int productId, int quantity) {
		String query = "UPDATE cart_items SET quantity = ? WHERE cart_id = ? AND product_id = ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, quantity);
			stmt.setInt(2, cartId);
			stmt.setInt(3, productId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
	}

	// Method to get all items in the cart
	public List<Cart_Items> getCartItems(int cartId) {
		List<Cart_Items> cartItems = new ArrayList<>();
		String query = "SELECT * FROM cart_items WHERE cart_id = ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, cartId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Cart_Items item = new Cart_Items();
				item.setCart_item_id(rs.getInt("cart_item_id"));
				item.setCart_id(rs.getInt("cart_id"));
				item.setProduct_id(rs.getInt("product_id"));
				item.setQuantity(rs.getInt("quantity"));
				cartItems.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
		return cartItems;
	}

	// New method to get cart items by user ID
	public List<Cart_Items> getCartItemsByUserId(int userId) {
		List<Cart_Items> cartItems = new ArrayList<>();
		int cartId = getCartIdByUserId(userId); // Get the cart ID for the user

		if (cartId != -1) { // If a cart exists for the user
			cartItems = getCartItems(cartId); // Fetch items in the cart
		}
		return cartItems;
	}

	// New method to check if an item exists in the cart
	public Cart_Items getCartItem(int cartId, int productId) {
		Cart_Items item = null;
		String query = "SELECT * FROM cart_items WHERE cart_id = ? AND product_id = ?";

		try (Connection conn = dbConnection.getConnectionData();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, cartId);
			stmt.setInt(2, productId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				item = new Cart_Items();
				item.setCart_item_id(rs.getInt("cart_item_id"));
				item.setCart_id(rs.getInt("cart_id"));
				item.setProduct_id(rs.getInt("product_id"));
				item.setQuantity(rs.getInt("quantity"));
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions appropriately
		}
		return item;
	}
}