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
<title>Admin Panel - FoodOrder</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
font-family: 'Poppins', sans-serif;
background: #f8f8f8;
}

/* Navbar - matches other pages style but dark */
.navbar {
background: linear-gradient(135deg, #1a1a2e, #16213e) !important;
padding: 15px 30px;
box-shadow: 0 4px 15px rgba(0,0,0,0.3);
}

.navbar-brand {
font-size: 1.6rem;
font-weight: 800;
letter-spacing: 1px;
}

.admin-badge {
background: linear-gradient(135deg, #e53935, #b71c1c);
color: white;
padding: 4px 14px;
border-radius: 20px;
font-size: 0.75rem;
font-weight: 700;
margin-left: 10px;
letter-spacing: 1px;
}

/* Hero - same style as menu/orders hero */
.admin-hero {
background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
url('https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?w=1600')
center/cover no-repeat;
padding: 50px 30px;
text-align: center;
color: white;
}

.admin-hero h1 {
font-size: 2.5rem;
font-weight: 800;
text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
margin-bottom: 8px;
}

.admin-hero p {
opacity: 0.85;
font-size: 1rem;
}

/* Stats - same card style as other pages */
.main-container {
max-width: 1200px;
margin: 30px auto;
padding: 0 25px;
}

.section-title {
font-size: 1.3rem;
font-weight: 800;
color: #1a1a1a;
margin-bottom: 20px;
}

.stat-card {
background: white;
border-radius: 15px;
padding: 22px 25px;
box-shadow: 0 5px 20px rgba(0,0,0,0.07);
display: flex;
align-items: center;
gap: 15px;
transition: all 0.3s;
height: 100%;
}

.stat-card:hover {
transform: translateY(-5px);
box-shadow: 0 15px 35px rgba(0,0,0,0.12);
}

.stat-icon {
width: 58px;
height: 58px;
border-radius: 14px;
display: flex;
align-items: center;
justify-content: center;
font-size: 1.6rem;
flex-shrink: 0;
}

.stat-icon.red { background: #ffebee; }
.stat-icon.orange { background: #fff3e0; }
.stat-icon.green { background: #e8f5e9; }
.stat-icon.blue { background: #e3f2fd; }

.stat-info h3 {
font-size: 1.8rem;
font-weight: 800;
color: #1a1a1a;
line-height: 1;
margin-bottom: 4px;
}

.stat-info p {
font-size: 0.82rem;
color: #999;
margin: 0;
font-weight: 500;
}

/* Order Cards - same style as cart/orders */
.order-card {
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.07);
margin-bottom: 12px;
transition: all 0.3s;
overflow: hidden;
border-left: 4px solid #b71c1c;
}

.order-card:hover {
transform: translateY(-3px);
box-shadow: 0 12px 30px rgba(0,0,0,0.12);
}

.order-row {
display: flex;
align-items: center;
padding: 18px 25px;
gap: 15px;
flex-wrap: wrap;
}

.order-id {
font-weight: 800;
font-size: 0.95rem;
color: #1a1a1a;
min-width: 75px;
}

.customer-name {
flex: 1;
font-weight: 600;
color: #333;
font-size: 0.92rem;
min-width: 120px;
}

.order-amount {
font-weight: 800;
color: #b71c1c;
font-size: 1rem;
min-width: 80px;
}

.order-date {
color: #bbb;
font-size: 0.78rem;
min-width: 160px;
}

/* Status badges - same as orders page */
.status-badge {
padding: 5px 14px;
border-radius: 20px;
font-size: 0.8rem;
font-weight: 700;
}

.badge-pending { background: #fff3e0; color: #e65100; }
.badge-processing { background: #e3f2fd; color: #1565c0; }
.badge-delivered { background: #e8f5e9; color: #2e7d32; }
.badge-cancelled { background: #ffebee; color: #b71c1c; }

/* Update form */
.update-form {
display: flex;
align-items: center;
gap: 8px;
}

.status-select {
border-radius: 10px;
border: 2px solid #eee;
padding: 7px 12px;
font-size: 0.82rem;
font-family: 'Poppins', sans-serif;
font-weight: 600;
cursor: pointer;
transition: all 0.3s;
background: #fafafa;
}

.status-select:focus {
border-color: #b71c1c;
outline: none;
box-shadow: 0 0 0 3px rgba(183,28,28,0.1);
}

.btn-update {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 10px;
padding: 8px 18px;
color: white;
font-size: 0.82rem;
font-weight: 700;
font-family: 'Poppins', sans-serif;
cursor: pointer;
transition: all 0.3s;
box-shadow: 0 3px 10px rgba(183,28,28,0.3);
}

.btn-update:hover {
transform: translateY(-2px);
box-shadow: 0 6px 18px rgba(183,28,28,0.4);
}

.btn-logout {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 8px;
padding: 9px 20px;
color: white;
font-weight: 700;
font-family: 'Poppins', sans-serif;
text-decoration: none;
transition: all 0.3s;
font-size: 0.88rem;
box-shadow: 0 3px 10px rgba(183,28,28,0.3);
}

.btn-logout:hover {
transform: translateY(-2px);
box-shadow: 0 8px 20px rgba(183,28,28,0.4);
color: white;
}

.empty-state {
text-align: center;
padding: 50px;
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.07);
color: #999;
}
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark">
<div class="d-flex align-items-center">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<span class="admin-badge">ADMIN</span>
</div>
<a href="LogoutServlet" class="btn-logout">Logout 👋</a>
</nav>

<!-- Hero -->
<div class="admin-hero">
<h1>⚙️ Admin Dashboard</h1>
<p>Manage orders, track deliveries and monitor your restaurant!</p>
</div>

<%
Connection con = null;
int totalOrders = 0, pendingOrders = 0, deliveredOrders = 0, totalUsers = 0;
double totalRevenue = 0;
try {
con = com.food.DBConnection.getConnection();

ResultSet rs1 = con.prepareStatement("SELECT COUNT(*) FROM orders").executeQuery();
if(rs1.next()) totalOrders = rs1.getInt(1);

ResultSet rs2 = con.prepareStatement("SELECT COUNT(*) FROM orders WHERE status='Pending'").executeQuery();
if(rs2.next()) pendingOrders = rs2.getInt(1);

ResultSet rs3 = con.prepareStatement("SELECT COUNT(*) FROM orders WHERE status='Delivered'").executeQuery();
if(rs3.next()) deliveredOrders = rs3.getInt(1);

ResultSet rs4 = con.prepareStatement("SELECT COUNT(*) FROM users WHERE role='user'").executeQuery();
if(rs4.next()) totalUsers = rs4.getInt(1);

ResultSet rs5 = con.prepareStatement("SELECT SUM(total_amount) FROM orders WHERE status='Delivered'").executeQuery();
if(rs5.next()) totalRevenue = rs5.getDouble(1);

} catch(Exception e) { e.printStackTrace(); }
%>

<div class="main-container">

<!-- Stats -->
<div class="row g-3 mb-4">
<div class="col-md-3 col-sm-6">
<div class="stat-card">
<div class="stat-icon red">📦</div>
<div class="stat-info">
<h3><%= totalOrders %></h3>
<p>Total Orders</p>
</div>
</div>
</div>
<div class="col-md-3 col-sm-6">
<div class="stat-card">
<div class="stat-icon orange">⏳</div>
<div class="stat-info">
<h3><%= pendingOrders %></h3>
<p>Pending Orders</p>
</div>
</div>
</div>
<div class="col-md-3 col-sm-6">
<div class="stat-card">
<div class="stat-icon green">✅</div>
<div class="stat-info">
<h3><%= deliveredOrders %></h3>
<p>Delivered Orders</p>
</div>
</div>
</div>
<div class="col-md-3 col-sm-6">
<div class="stat-card">
<div class="stat-icon blue">👥</div>
<div class="stat-info">
<h3><%= totalUsers %></h3>
<p>Total Customers</p>
</div>
</div>
</div>
</div>

<!-- Orders List -->
<div class="section-title">📋 Manage Orders</div>

<%
try {
String sql = "SELECT o.id, u.name, o.total_amount, o.status, o.order_date " +
"FROM orders o JOIN users u ON o.user_id = u.id " +
"ORDER BY o.order_date DESC";
PreparedStatement ps = con.prepareStatement(sql);
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
%>
<div class="order-card">
<div class="order-row">
<div class="order-id">🧾 #<%= rs.getInt("id") %></div>
<div class="customer-name">👤 <%= rs.getString("name") %></div>
<div class="order-amount">₹<%= rs.getDouble("total_amount") %></div>
<div class="order-date">📅 <%= rs.getTimestamp("order_date") %></div>
<span class="status-badge <%= badgeClass %>"><%= statusEmoji %> <%= status %></span>
<form action="<%=request.getContextPath()%>/AdminServlet"
method="post" class="update-form">
<input type="hidden" name="orderId" value="<%= rs.getInt("id") %>">
<select name="status" class="status-select">
<option <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
<option <%= status.equals("Processing") ? "selected" : "" %>>Processing</option>
<option <%= status.equals("Delivered") ? "selected" : "" %>>Delivered</option>
<option <%= status.equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
</select>
<button type="submit" class="btn-update">Update ✓</button>
</form>
</div>
</div>
<%
}
if(!hasOrders) {
%>
<div class="empty-state">
<div style="font-size:3rem;">📦</div>
<h5 class="mt-3">No orders yet!</h5>
<p>Orders will appear here once customers start ordering.</p>
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