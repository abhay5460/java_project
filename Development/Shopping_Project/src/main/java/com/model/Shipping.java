package com.model;

public class Shipping 
{
	private int Shipping_id;
	private int Order_id;
	private String Shipping_address;
	private String Shipping_Status;
	private String Tracking_Number;
	
	public int getShipping_id() {
		return Shipping_id;
	}
	public void setShipping_id(int shipping_id) {
		Shipping_id = shipping_id;
	}
	public int getOrder_id() {
		return Order_id;
	}
	public void setOrder_id(int order_id) {
		Order_id = order_id;
	}
	public String getShipping_address() {
		return Shipping_address;
	}
	public void setShipping_address(String shipping_address) {
		Shipping_address = shipping_address;
	}
	public String getShipping_Status() {
		return Shipping_Status;
	}
	public void setShipping_Status(String shipping_Status) {
		Shipping_Status = shipping_Status;
	}
	public String getTracking_Number() {
		return Tracking_Number;
	}
	public void setTracking_Number(String tracking_Number) {
		Tracking_Number = tracking_Number;
	}
	
}

