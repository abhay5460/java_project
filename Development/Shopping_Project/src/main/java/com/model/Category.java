package com.model;

public class Category 
{
	 private int categoryId;
	 private String categoryName;
	 private String description;
	 private int discountId;
	 
	 
	    public Category(int categoryId, String categoryName, String description, int discountId) {
	        this.categoryId = categoryId;
	        this.categoryName = categoryName;
	        this.description = description;
	        this.discountId = discountId;
	    }


		public int getCategoryId() {
			return categoryId;
		}


		public void setCategoryId(int categoryId) {
			this.categoryId = categoryId;
		}


		public String getCategoryName() {
			return categoryName;
		}


		public void setCategoryName(String categoryName) {
			this.categoryName = categoryName;
		}


		public String getDescription() {
			return description;
		}


		public void setDescription(String description) {
			this.description = description;
		}


		public int getDiscountId() {
			return discountId;
		}


		public void setDiscountId(int discountId) {
			this.discountId = discountId;
		}
	    
	    
}
