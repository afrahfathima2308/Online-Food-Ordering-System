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
<title>Cart - Food Ordering</title>
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
<h4 class="mb-4">🛒 Your Cart</h4>

<table class="table table-bordered bg-white shadow-sm">
<thead class="table-danger">
<tr>
<th>Item</th>
<th>Price</th>
<th>Quantity</th>
<th>Subtotal</th>
<th>Remove</th>
</tr>
</thead>
<tbody>
<%
double total = 0;
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT c.id, f.name, f.price, c.quantity FROM cart c " +
"JOIN food_items f ON c.food_id = f.id WHERE c.user_id=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();
while(rs.next()) {
double subtotal = rs.getDouble("price") * rs.getInt("quantity");
total += subtotal;
%>
<tr>
<td><%= rs.getString("name") %></td>
<td>₹<%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>
<td>₹<%= subtotal %></td>
<td>
<a href="CartServlet?action=remove&cartId=<%= rs.getInt("id") %>"
class="btn btn-sm btn-outline-danger">Remove</a>
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
<tfoot>
<tr>
<td colspan="3" class="text-end fw-bold">Total:</td>
<td class="fw-bold text-danger">₹<%= total %></td>
<td></td>
</tr>
</tfoot>
</table>

<% if(total > 0) { %>
<form action="OrderServlet" method="post">
<input type="hidden" name="total" value="<%= total %>">
<button type="submit" class="btn btn-danger">Place Order 🎉</button>
</form>
<% } else { %>
<div class="alert alert-warning">Your cart is empty! <a href="menu.jsp">Browse Menu</a></div>
<% } %>
</div>

</body>
</html>