package com.model;

import java.time.format.DateTimeFormatter;

public class Review 
{
	private int Review_id;
	private int product_id;
	private int user_id;
	private int Rating;
	private String Description;
	private DateTimeFormatter Review_Date;
	public int getReview_id() {
		return Review_id;
	}
	public void setReview_id(int review_id) {
		Review_id = review_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getRating() {
		return Rating;
	}
	public void setRating(int rating) {
		Rating = rating;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public DateTimeFormatter getReview_Date() {
		return Review_Date;
	}
	public void setReview_Date(DateTimeFormatter review_Date) {
		Review_Date = review_Date;
	}
}

