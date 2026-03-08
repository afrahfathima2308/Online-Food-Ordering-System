<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || sess.getAttribute("userId") == null){
response.sendRedirect("login.jsp");
return;
}
int userId = (int) sess.getAttribute("userId");
String userName = (String) sess.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<title>My Orders - FoodOrder</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
font-family: 'Segoe UI', sans-serif;
background: #f8f8f8;
}

.navbar {
background: linear-gradient(135deg, #b71c1c, #e53935) !important;
padding: 15px 30px;
box-shadow: 0 4px 15px rgba(183,28,28,0.4);
}

.navbar-brand {
font-size: 1.6rem;
font-weight: 800;
}

/* Hero */
.orders-hero {
background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
url('https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=1600')
center/cover no-repeat;
padding: 40px 30px;
text-align: center;
color: white;
}

.orders-hero h1 {
font-size: 2.2rem;
font-weight: 800;
text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
}

.orders-hero p {
opacity: 0.85;
font-size: 1rem;
}

/* Orders Container */
.orders-container {
max-width: 900px;
margin: 30px auto;
padding: 0 20px;
}

.order-card {
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.08);
padding: 20px 25px;
margin-bottom: 15px;
transition: all 0.3s;
border-left: 5px solid #b71c1c;
}

.order-card:hover {
transform: translateY(-3px);
box-shadow: 0 10px 30px rgba(0,0,0,0.12);
}

.order-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 10px;
}

.order-id {
font-size: 1.1rem;
font-weight: 800;
color: #333;
}

.order-date {
color: #999;
font-size: 0.85rem;
}

.order-amount {
font-size: 1.2rem;
font-weight: 800;
color: #b71c1c;
}

.badge-pending {
background: #fff3e0;
color: #e65100;
padding: 5px 15px;
border-radius: 20px;
font-size: 0.85rem;
font-weight: 700;
}

.badge-processing {
background: #e3f2fd;
color: #1565c0;
padding: 5px 15px;
border-radius: 20px;
font-size: 0.85rem;
font-weight: 700;
}

.badge-delivered {
background: #e8f5e9;
color: #2e7d32;
padding: 5px 15px;
border-radius: 20px;
font-size: 0.85rem;
font-weight: 700;
}

.badge-cancelled {
background: #ffebee;
color: #b71c1c;
padding: 5px 15px;
border-radius: 20px;
font-size: 0.85rem;
font-weight: 700;
}

.empty-orders {
text-align: center;
padding: 60px 20px;
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

.btn-browse {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 10px;
padding: 12px 30px;
color: white;
font-weight: 700;
text-decoration: none;
display: inline-block;
margin-top: 15px;
transition: all 0.3s;
}

.btn-browse:hover {
transform: translateY(-2px);
box-shadow: 0 8px 20px rgba(183,28,28,0.4);
color: white;
}

/* Progress tracker */
.progress-tracker {
display: flex;
justify-content: space-between;
margin-top: 12px;
position: relative;
}

.progress-tracker::before {
content: '';
position: absolute;
top: 12px;
left: 0;
right: 0;
height: 2px;
background: #eee;
z-index: 0;
}

.progress-step {
display: flex;
flex-direction: column;
align-items: center;
z-index: 1;
font-size: 0.75rem;
color: #aaa;
}

.progress-dot {
width: 24px;
height: 24px;
border-radius: 50%;
background: #eee;
margin-bottom: 5px;
display: flex;
align-items: center;
justify-content: center;
font-size: 0.7rem;
}

.progress-dot.active {
background: #b71c1c;
color: white;
}

.progress-step.active {
color: #b71c1c;
font-weight: 700;
}
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<div class="d-flex align-items-center gap-2">
<span class="text-white me-2">👋 <%= userName %>!</span>
<a href="menu.jsp" class="btn btn-outline-light btn-sm">🍽️ Menu</a>
<a href="cart.jsp" class="btn btn-outline-light btn-sm">🛒 Cart</a>
<a href="LogoutServlet" class="btn btn-light btn-sm text-danger fw-bold">Logout</a>
</div>
</nav>

<!-- Hero -->
<div class="orders-hero">
<h1>📦 My Orders</h1>
<p>Track all your delicious orders here!</p>
</div>

<div class="orders-container">
<%
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();
boolean hasOrders = false;

while(rs.next()) {
hasOrders = true;
String status = rs.getString("status");
String badgeClass = "badge-pending";
String statusEmoji = "⏳";
if(status.equals("Processing")) { badgeClass = "badge-processing"; statusEmoji = "👨‍🍳"; }
else if(status.equals("Delivered")) { badgeClass = "badge-delivered"; statusEmoji = "✅"; }
else if(status.equals("Cancelled")) { badgeClass = "badge-cancelled"; statusEmoji = "❌"; }

boolean isPending = status.equals("Pending");
boolean isProcessing = status.equals("Processing") || status.equals("Delivered");
boolean isDelivered = status.equals("Delivered");
%>
<div class="order-card">
<div class="order-header">
<div>
<div class="order-id">🧾 Order #<%= rs.getInt("id") %></div>
<div class="order-date">📅 <%= rs.getTimestamp("order_date") %></div>
</div>
<div style="text-align:right;">
<div class="order-amount">₹<%= rs.getDouble("total_amount") %></div>
<span class="<%= badgeClass %>"><%= statusEmoji %> <%= status %></span>
</div>
</div>

<!-- Progress Tracker -->
<div class="progress-tracker">
<div class="progress-step active">
<div class="progress-dot active">✓</div>
<span>Placed</span>
</div>
<div class="progress-step <%= isPending || isProcessing || isDelivered ? "active" : "" %>">
<div class="progress-dot <%= isPending || isProcessing || isDelivered ? "active" : "" %>">👨‍🍳</div>
<span>Preparing</span>
</div>
<div class="progress-step <%= isProcessing || isDelivered ? "active" : "" %>">
<div class="progress-dot <%= isProcessing || isDelivered ? "active" : "" %>">🚴</div>
<span>On the way</span>
</div>
<div class="progress-step <%= isDelivered ? "active" : "" %>">
<div class="progress-dot <%= isDelivered ? "active" : "" %>">✅</div>
<span>Delivered</span>
</div>
</div>
</div>
<%
}

if(!hasOrders) {
%>
<div class="empty-orders">
<div style="font-size:4rem;">📦</div>
<h3 class="mt-3">No orders yet!</h3>
<p class="text-muted">You haven't placed any orders yet.</p>
<a href="menu.jsp" class="btn-browse">🍽️ Order Now</a>
</div>
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
