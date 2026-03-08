<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || sess.getAttribute("userId") == null){
response.sendRedirect("login.jsp");
return;
}
int userId = (int) sess.getAttribute("userId");
String foodIdParam = request.getParameter("foodId");
int foodId = 0;
if(foodIdParam != null) foodId = Integer.parseInt(foodIdParam);
%>
<!DOCTYPE html>
<html>
<head>
<title>Reviews</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-danger px-4">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<a href="menu.jsp" class="btn btn-outline-light btn-sm">← Back to Menu</a>
</nav>

<div class="container mt-4">
<h4 class="mb-4">⭐ Ratings & Reviews</h4>

<!-- Add Review Form -->
<div class="card shadow-sm mb-4">
<div class="card-body">
<h5>Write a Review</h5>
<form action="ReviewServlet" method="post">
<input type="hidden" name="foodId" value="<%= foodId %>">
<div class="mb-3">
<label>Rating</label>
<select name="rating" class="form-select">
<option value="5">⭐⭐⭐⭐⭐ Excellent</option>
<option value="4">⭐⭐⭐⭐ Good</option>
<option value="3">⭐⭐⭐ Average</option>
<option value="2">⭐⭐ Poor</option>
<option value="1">⭐ Very Poor</option>
</select>
</div>
<div class="mb-3">
<label>Comment</label>
<textarea name="comment" class="form-control" rows="3"
placeholder="Write your review here..."></textarea>
</div>
<button type="submit" class="btn btn-danger">Submit Review</button>
</form>
</div>
</div>

<!-- Show Reviews -->
<h5 class="mb-3">All Reviews</h5>
<%
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT r.rating, r.comment, r.review_date, u.name, f.name as food_name " +
"FROM reviews r " +
"JOIN users u ON r.user_id = u.id " +
"JOIN food_items f ON r.food_id = f.id " +
"WHERE r.food_id = ? " +
"ORDER BY r.review_date DESC";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, foodId);
ResultSet rs = ps.executeQuery();
boolean hasReviews = false;
while(rs.next()) {
hasReviews = true;
int rating = rs.getInt("rating");
String stars = "";
for(int i = 0; i < rating; i++) stars += "⭐";
%>
<div class="card mb-3 shadow-sm">
<div class="card-body">
<div class="d-flex justify-content-between">
<h6 class="fw-bold"><%= rs.getString("name") %></h6>
<small class="text-muted"><%= rs.getTimestamp("review_date") %></small>
</div>
<p class="mb-1"><%= stars %></p>
<p class="mb-0"><%= rs.getString("comment") %></p>
</div>
</div>
<%
}
if(!hasReviews) {
%>
<div class="alert alert-info">No reviews yet! Be the first to review!</div>
<%
}
con.close();
} catch(Exception e) {
e.printStackTrace();
}
%>
</div>

</body>
</html>