<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || sess.getAttribute("userId") == null){
response.sendRedirect("login.jsp");
return;
}
String userName = (String) sess.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<title>Menu - Food Ordering</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-danger px-4">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<div>
<span class="text-white me-3">Welcome, <%= userName %>!</span>
<a href="cart.jsp" class="btn btn-outline-light btn-sm me-2">🛒 Cart</a>
<a href="orders.jsp" class="btn btn-outline-light btn-sm me-2">📦 My Orders</a>
<a href="LogoutServlet" class="btn btn-light btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">
<h4 class="mb-4">Our Menu</h4>

<!-- Category Filter -->
<div class="mb-4">
<a href="menu.jsp" class="btn btn-danger btn-sm me-2">All</a>
<a href="menu.jsp?category=Pizza" class="btn btn-outline-danger btn-sm me-2">🍕 Pizza</a>
<a href="menu.jsp?category=Burger" class="btn btn-outline-danger btn-sm me-2">🍔 Burger</a>
<a href="menu.jsp?category=Pasta" class="btn btn-outline-danger btn-sm me-2">🍝 Pasta</a>
<a href="menu.jsp?category=Drinks" class="btn btn-outline-danger btn-sm me-2">🥤 Drinks</a>
</div>

<div class="row">
<%
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String category = request.getParameter("category");
String sql;
PreparedStatement ps;

if(category != null && !category.isEmpty()) {
sql = "SELECT * FROM food_items WHERE available=true AND category=?";
ps = con.prepareStatement(sql);
ps.setString(1, category);
} else {
sql = "SELECT * FROM food_items WHERE available=true";
ps = con.prepareStatement(sql);
}

ResultSet rs = ps.executeQuery();
while(rs.next()) {
%>
<div class="col-md-3 mb-4">
<div class="card h-100 shadow-sm">
<div class="card-body text-center">
<h5 class="card-title"><%= rs.getString("name") %></h5>
<span class="badge bg-secondary mb-2"><%= rs.getString("category") %></span>
<p class="text-danger fw-bold fs-5">₹<%= rs.getDouble("price") %></p>
<form action="CartServlet" method="post">
<input type="hidden" name="foodId" value="<%= rs.getInt("id") %>">
<input type="hidden" name="action" value="add">
<div class="input-group mb-2">
<input type="number" name="quantity" value="1" min="1" max="10" class="form-control form-control-sm text-center">
</div>
<button type="submit" class="btn btn-danger btn-sm w-100">Add to Cart</button>
</form>
</div>
</div>
</div>
<%
}
con.close();
} catch(Exception e) {
e.printStackTrace();
}
%>
</div>
</div>

</body>
</html>
