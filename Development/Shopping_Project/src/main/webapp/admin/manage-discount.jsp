<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Discount"%>
<%@ page import="com.dao.DiscountDAO"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Discounts</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
</head>
<body>


<div class="container mt-5">
    <h2>Manage Discounts</h2>
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Percentage</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            DiscountDAO discountDAO = new DiscountDAO();
            List<Discount> discounts = discountDAO.getAllDiscounts();
            for (Discount discount : discounts) {
            %>
            <tr>
                <td><%= discount.getDiscount_id() %></td>
                <td><%= discount.getDiscount_name() %></td>
                <td><%= discount.getDiscount_type() %></td>
                <td><%= discount.getPercentage() %>%</td>
                <td><%= discount.getStart_date() %></td>
                <td><%= discount.getEnd_date() %></td>
                <td><%= discount.getStatus() %></td>
                <td>
                    <a href="edit-discount.jsp?id=<%= discount.getDiscount_id() %>" class="btn btn-warning">Edit</a>
                    <a href="DeleteDiscountServlet?id=<%= discount.getDiscount_id() %>" class="btn btn-danger">Delete</a>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <a href="add-discount.jsp" class="btn btn-primary">Add New Discount</a>
</div>


<script src="assets/js/jquery-1.11.3.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>