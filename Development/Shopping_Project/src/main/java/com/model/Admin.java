package com.model;

public class Admin 
{
	private int admin_id;
    public int getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}

	private String admin_email;
    private String admin_password;

    public Admin(String admin_email, String admin_password) {
        this.admin_email = admin_email;
        this.admin_password = admin_password;
    }

    public String getEmail() {
        return admin_email;
    }

    public String getPassword() {
        return admin_password;
    }
}