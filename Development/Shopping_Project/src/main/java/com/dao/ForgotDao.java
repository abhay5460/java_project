package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.model.Customer;
import com.util.DBconnection;

public class ForgotDao {
	private DBconnection connection = new DBconnection() ;
	public Customer checkEmail(String email)
	{
		Customer f=new Customer();
		try {
		
			Connection conn =  connection.getConnectionData();
			String sql="select * from  customer where email=?";
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, email);
			ResultSet rs=stmt.executeQuery();
			if(rs.next())
			{
				f.setUser_id(rs.getInt(1));
				f.setEmail(rs.getString(4));
				f.setFirstname(rs.getString(2));
				f.setLastname(rs.getString(3));
			}
			else
			{
				f=null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
		
	}
	public int resetPassword(Customer f)
	{
		int r=0;
		try {
			Connection conn= connection.getConnectionData();
			String sql="update customer set password=? where user_id=?";
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1, f.getPassword());
			stmt.setInt(2, f.getUser_id());
			r=stmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

}