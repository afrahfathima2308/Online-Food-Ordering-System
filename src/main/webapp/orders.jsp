<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || sess.getAttribute("userId") == null){
response.sendRedirect("login.jsp");
return;
}
int userId = (int) sess.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<title>My Orders</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-danger px-4">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<div>
<a href="menu.jsp" class="btn btn-outline-light btn-sm me-2">← Menu</a>
<a href="LogoutServlet" class="btn btn-light btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">
<h4 class="mb-4">📦 My Orders</h4>

<table class="table table-bordered bg-white shadow-sm">
<thead class="table-danger">
<tr>
<th>Order ID</th>
<th>Total Amount</th>
<th>Status</th>
<th>Order Date</th>
</tr>
</thead>
<tbody>
<%
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();
while(rs.next()) {
String status = rs.getString("status");
String badgeColor = status.equals("Delivered") ? "success" :
status.equals("Cancelled") ? "danger" : "warning";
%>
<tr>
<td>#<%= rs.getInt("id") %></td>
<td>₹<%= rs.getDouble("total_amount") %></td>
<td><span class="badge bg-<%= badgeColor %>"><%= status %></span></td>
<td><%= rs.getTimestamp("order_date") %></td>
</tr>
<%
}
con.close();
} catch(Exception e) {
e.printStackTrace();
}
%>
</tbody>
</table>
</div>

</body>
</html>