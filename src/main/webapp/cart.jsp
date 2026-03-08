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
<title>Cart - FoodOrder</title>
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
.cart-hero {
background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
url('https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=1600')
center/cover no-repeat;
padding: 40px 30px;
text-align: center;
color: white;
}

.cart-hero h1 {
font-size: 2.2rem;
font-weight: 800;
text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
}

.cart-hero p {
opacity: 0.85;
font-size: 1rem;
}

/* Cart Container */
.cart-container {
max-width: 900px;
margin: 30px auto;
padding: 0 20px;
}

.cart-card {
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.08);
overflow: hidden;
margin-bottom: 15px;
}

.cart-item {
display: flex;
align-items: center;
padding: 15px 20px;
border-bottom: 1px solid #f5f5f5;
transition: background 0.2s;
}

.cart-item:hover {
background: #fff5f5;
}

.cart-item-emoji {
font-size: 2.5rem;
margin-right: 15px;
}

.cart-item-details {
flex: 1;
}

.cart-item-name {
font-weight: 700;
font-size: 1rem;
color: #333;
}

.cart-item-qty {
color: #888;
font-size: 0.85rem;
}

.cart-item-price {
font-weight: 800;
font-size: 1.1rem;
color: #b71c1c;
margin-right: 15px;
}

.btn-remove {
background: #ffebee;
color: #b71c1c;
border: none;
border-radius: 8px;
padding: 6px 12px;
font-size: 0.85rem;
font-weight: 600;
text-decoration: none;
transition: all 0.3s;
}

.btn-remove:hover {
background: #b71c1c;
color: white;
}

/* Total Card */
.total-card {
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.08);
padding: 25px;
margin-top: 20px;
}

.total-row {
display: flex;
justify-content: space-between;
align-items: center;
padding: 10px 0;
border-bottom: 1px solid #f5f5f5;
font-size: 0.95rem;
color: #555;
}

.total-final {
display: flex;
justify-content: space-between;
align-items: center;
padding: 15px 0 5px;
font-size: 1.3rem;
font-weight: 800;
color: #b71c1c;
}

.btn-order {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 12px;
padding: 14px;
font-size: 1.05rem;
font-weight: 700;
color: white;
width: 100%;
transition: all 0.3s;
margin-top: 15px;
letter-spacing: 0.5px;
}

.btn-order:hover {
transform: translateY(-3px);
box-shadow: 0 10px 25px rgba(183,28,28,0.4);
color: white;
}

.empty-cart {
text-align: center;
padding: 60px 20px;
background: white;
border-radius: 15px;
box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

.empty-cart h3 {
color: #555;
margin-bottom: 10px;
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
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<div class="d-flex align-items-center gap-2">
<span class="text-white me-2">👋 <%= userName %>!</span>
<a href="menu.jsp" class="btn btn-outline-light btn-sm">🍽️ Menu</a>
<a href="orders.jsp" class="btn btn-outline-light btn-sm">📦 Orders</a>
<a href="LogoutServlet" class="btn btn-light btn-sm text-danger fw-bold">Logout</a>
</div>
</nav>

<!-- Hero -->
<div class="cart-hero">
<h1>🛒 Your Cart</h1>
<p>Review your items and place your order!</p>
</div>

<div class="cart-container">
<%
double total = 0;
boolean hasItems = false;
Connection con = null;
try {
con = com.food.DBConnection.getConnection();
String sql = "SELECT c.id, f.name, f.price, f.category, c.quantity FROM cart c " +
"JOIN food_items f ON c.food_id = f.id WHERE c.user_id=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();

StringBuilder itemsHtml = new StringBuilder();
while(rs.next()) {
hasItems = true;
double subtotal = rs.getDouble("price") * rs.getInt("quantity");
total += subtotal;
String cat = rs.getString("category").toLowerCase();
String emoji = "🍽️";
if(cat.equals("pizza")) emoji = "🍕";
else if(cat.equals("burger")) emoji = "🍔";
else if(cat.equals("pasta")) emoji = "🍝";
else if(cat.equals("drinks")) emoji = "🥤";

itemsHtml.append("<div class='cart-item'>")
.append("<div class='cart-item-emoji'>").append(emoji).append("</div>")
.append("<div class='cart-item-details'>")
.append("<div class='cart-item-name'>").append(rs.getString("name")).append("</div>")
.append("<div class='cart-item-qty'>Quantity: ").append(rs.getInt("quantity")).append("</div>")
.append("</div>")
.append("<div class='cart-item-price'>₹").append(subtotal).append("</div>")
.append("<a href='CartServlet?action=remove&cartId=").append(rs.getInt("id"))
.append("' class='btn-remove'>🗑️ Remove</a>")
.append("</div>");
}
con.close();

if(hasItems) {
out.println("<div class='cart-card'>" + itemsHtml + "</div>");
%>
<!-- Total Card -->
<div class="total-card">
<div class="total-row">
<span>Subtotal</span>
<span>₹<%= total %></span>
</div>
<div class="total-row">
<span>Delivery Charge</span>
<span class="text-success fw-bold">FREE 🎉</span>
</div>
<div class="total-final">
<span>Total Amount</span>
<span>₹<%= total %></span>
</div>
<form action="<%=request.getContextPath()%>/OrderServlet" method="post">
<input type="hidden" name="total" value="<%= total %>">
<button type="submit" class="btn-order">🎉 Place Order Now</button>
</form>
</div>
<%
} else {
%>
<div class="empty-cart">
<div style="font-size:4rem;">🛒</div>
<h3>Your cart is empty!</h3>
<p class="text-muted">Looks like you haven't added anything yet.</p>
<a href="menu.jsp" class="btn-browse">🍽️ Browse Menu</a>
</div>
<%
}
} catch(Exception e) {
e.printStackTrace();
}
%>
</div>

</body>
</html>
