package com.model;

import java.math.BigDecimal;

public class Order_Details 
{
	public int OrderDetailsId;
	public int OrderId;
	public int ProductId;
	public int Quantity;
	public BigDecimal Price;
	public int getOrderDetailsId() {
		return OrderDetailsId;
	}
	public void setOrderDetailsId(int orderDetailsId) {
		OrderDetailsId = orderDetailsId;
	}
	public int getOrderId() {
		return OrderId;
	}
	public void setOrderId(int orderId) {
		OrderId = orderId;
	}
	public int getProductId() {
		return ProductId;
	}
	public void setProductId(int productId) {
		ProductId = productId;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public BigDecimal getPrice() {
		return Price;
	}
	public void setPrice(BigDecimal price) {
		Price = price;
	}
}
