<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || !("admin".equals(sess.getAttribute("userRole")))){
response.sendRedirect("login.jsp");
return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Panel</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark px-4">
<span class="navbar-brand fw-bold">⚙️ Admin Panel</span>
<a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
</nav>

<div class="container mt-4">
<h4 class="mb-4">📦 Manage Orders</h4>

<table class="table table-bordered bg-white shadow-sm">
<thead class="table-dark">
<tr>
<th>Order ID</th>
<th>Customer</th>
<th>Total</th>
<th>Status</th>
<th>Date</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<%
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT o.id, u.name, o.total_amount, o.status, o.order_date " +
"FROM orders o JOIN users u ON o.user_id = u.id " +
"ORDER BY o.order_date DESC";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
while(rs.next()) {
%>
<tr>
<td>#<%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td>₹<%= rs.getDouble("total_amount") %></td>
<td><%= rs.getString("status") %></td>
<td><%= rs.getTimestamp("order_date") %></td>
<td>
<form action="AdminServlet" method="post" class="d-flex gap-1">
<input type="hidden" name="orderId" value="<%= rs.getInt("id") %>">
<select name="status" class="form-select form-select-sm">
<option>Pending</option>
<option>Processing</option>
<option>Delivered</option>
<option>Cancelled</option>
</select>
<button type="submit" class="btn btn-sm btn-dark">Update</button>
</form>
</td>
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
