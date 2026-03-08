<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
HttpSession sess = request.getSession(false);
if(sess == null || sess.getAttribute("userId") == null){
response.sendRedirect("login.jsp");
return;
}
String userName = (String) sess.getAttribute("userName");
String category = request.getParameter("category");
String search = request.getParameter("search");
%>
<!DOCTYPE html>
<html>
<head>
<title>Menu - FoodOrder</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#f8f8f8;}
.navbar{background:linear-gradient(135deg,#b71c1c,#e53935)!important;padding:15px 30px;box-shadow:0 4px 15px rgba(183,28,28,0.4);}
.navbar-brand{font-size:1.6rem;font-weight:800;letter-spacing:1px;}
.hero-banner{background:linear-gradient(rgba(0,0,0,0.55),rgba(0,0,0,0.55)),url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1600') center/cover no-repeat;padding:60px 30px;text-align:center;color:white;}
.hero-banner h1{font-size:2.8rem;font-weight:800;margin-bottom:10px;text-shadow:2px 2px 8px rgba(0,0,0,0.5);}
.hero-banner p{font-size:1.1rem;opacity:0.9;margin-bottom:20px;}
.search-box{display:flex;justify-content:center;gap:10px;max-width:500px;margin:0 auto;}
.search-box input{border-radius:25px;padding:10px 20px;border:none;width:100%;font-size:0.95rem;font-family:'Poppins',sans-serif;box-shadow:0 4px 15px rgba(0,0,0,0.2);}
.search-box button{border-radius:25px;padding:10px 25px;background:#b71c1c;border:none;color:white;font-weight:600;font-family:'Poppins',sans-serif;transition:all 0.3s;}
.search-box button:hover{background:#d32f2f;transform:scale(1.05);}
.category-section{background:white;padding:15px 20px;box-shadow:0 2px 10px rgba(0,0,0,0.08);display:flex;gap:8px;justify-content:center;flex-wrap:wrap;position:sticky;top:0;z-index:100;}
.cat-btn{border-radius:25px;padding:7px 16px;font-weight:600;font-size:0.85rem;border:2px solid #b71c1c;color:#b71c1c;background:white;text-decoration:none;transition:all 0.3s;font-family:'Poppins',sans-serif;}
.cat-btn:hover,.cat-btn.active{background:#b71c1c;color:white;transform:translateY(-2px);box-shadow:0 5px 15px rgba(183,28,28,0.3);}
.menu-section{padding:30px;max-width:1300px;margin:0 auto;}
.section-heading{font-size:1.5rem;font-weight:800;color:#1a1a1a;margin-bottom:20px;padding-bottom:10px;border-bottom:3px solid #b71c1c;display:inline-block;}
.food-card{border:none;border-radius:15px;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,0.08);transition:all 0.3s;background:white;height:100%;}
.food-card:hover{transform:translateY(-8px);box-shadow:0 15px 35px rgba(0,0,0,0.15);}
.food-img{width:100%;height:170px;object-fit:cover;}
.food-card-body{padding:14px;text-align:center;}
.food-name{font-size:0.95rem;font-weight:700;color:#333;margin-bottom:5px;}
.food-category{background:#ffebee;color:#b71c1c;padding:3px 10px;border-radius:15px;font-size:0.78rem;font-weight:600;display:inline-block;margin-bottom:8px;}
.food-price{font-size:1.2rem;font-weight:800;color:#b71c1c;margin-bottom:8px;}
.nutrition-info{display:flex;flex-wrap:wrap;gap:4px;justify-content:center;margin-bottom:10px;}
.nutrition-badge{padding:3px 7px;border-radius:10px;font-size:0.7rem;font-weight:600;}
.calories{background:#fff3e0;color:#e65100;}
.protein{background:#e8f5e9;color:#2e7d32;}
.carbs{background:#e3f2fd;color:#1565c0;}
.fat{background:#fce4ec;color:#880e4f;}
.qty-input{border-radius:8px;border:2px solid #eee;text-align:center;padding:6px;font-weight:600;font-family:'Poppins',sans-serif;width:100%;}
.qty-input:focus{border-color:#b71c1c;outline:none;}
.btn-cart{background:linear-gradient(135deg,#e53935,#b71c1c);border:none;border-radius:8px;color:white;padding:8px;font-weight:600;font-family:'Poppins',sans-serif;width:100%;transition:all 0.3s;margin-top:5px;cursor:pointer;}
.btn-cart:hover{transform:scale(1.03);box-shadow:0 5px 15px rgba(183,28,28,0.4);color:white;}
.btn-review{background:white;border:2px solid #b71c1c;border-radius:8px;color:#b71c1c;padding:6px;font-weight:600;font-family:'Poppins',sans-serif;width:100%;transition:all 0.3s;margin-top:5px;text-decoration:none;display:block;font-size:0.82rem;}
.btn-review:hover{background:#b71c1c;color:white;}
.empty-state{text-align:center;padding:50px;background:white;border-radius:15px;box-shadow:0 5px 20px rgba(0,0,0,0.07);}
</style>
</head>
<body>
<nav class="navbar navbar-dark">
<span class="navbar-brand fw-bold">🍕 FoodOrder</span>
<div class="d-flex align-items-center gap-2">
<span class="text-white me-2">👋 <%= userName %>!</span>
<a href="cart.jsp" class="btn btn-outline-light btn-sm">🛒 Cart</a>
<a href="orders.jsp" class="btn btn-outline-light btn-sm">📦 Orders</a>
<a href="LogoutServlet" class="btn btn-light btn-sm text-danger fw-bold">Logout</a>
</div>
</nav>
<div class="hero-banner">
<h1>🍕 What are you craving today?</h1>
<p>Fresh, hot and delicious food delivered to your door!</p>
<form action="menu.jsp" method="get" class="search-box">
<input type="text" name="search" placeholder="🔍 Search for pizza, burger, cake..." value="<%= search != null ? search : "" %>">
<button type="submit">Search</button>
</form>
</div>
<div class="category-section">
<a href="menu.jsp" class="cat-btn <%= (category==null && search==null) ? "active":"" %>">🍽️ All</a>
<a href="menu.jsp?category=Pizza" class="cat-btn <%= "Pizza".equals(category) ?"active":"" %>">🍕 Pizza</a>
<a href="menu.jsp?category=
Burger" class="cat-btn <%= "Burger".equals(category) ?"active":"" %>">🍔 Burger</a>

<a href="menu.jsp?category=Pasta" class="cat-btn <%= "Pasta".equals(category) ?"active":"" %>">🍝 Pasta</a>
<a href="menu.jsp?category=Meals" class="cat-btn <%= "Meals".equals(category) ?"active":"" %>">🍱 Meals</a>
<a href="menu.jsp?category=
Snacks" class="cat-btn <%= "Snacks".equals(category) ?"active":"" %>">🍟 Snacks</a>

<a href="menu.jsp?category=Cakes" class="cat-btn <%= "Cakes".equals(category) ?"active":"" %>">🎂 Cakes</a>
<a href="menu.jsp?category=
Shakes" class="cat-btn <%= "Shakes".equals(category) ?"active":"" %>">🥤 Shakes</a>
<a href="menu.jsp?category=Drinks" class="cat-btn <%= "Drinks".equals(category) ?"active":"" %>">🧃 Drinks</a>
<a href="menu.jsp?category=Desserts" class="cat-btn <%= "Desserts".equals(category) ?"active":"" %>">🍮 Desserts</a>

</div>
<div class="menu-section">
<%
String[] categories = {"Pizza","Burger","Pasta","Meals","Snacks","Cakes","Shakes","Drinks","Desserts"};
String[] catEmojis = {"Pizza","Burger","Pasta","Meals","Snacks","Cakes","Shakes","Drinks","Desserts"};

Connection con = null;
try {
con = com.food.DBConnection.getConnection();
PreparedStatement ps = null;
ResultSet rs = null;
if(search != null && !search.trim().isEmpty()) {
%>
<div class="section-heading">🔍 Results for "<%= search %>"</div>
<div class="row g-4 mb-5">
<%
ps = con.prepareStatement("SELECT * FROM food_items WHERE available=true AND name LIKE ?");
ps.setString(1, "%" + search + "%");
rs = ps.executeQuery();
boolean found = false;
while(rs.next()) {
found = true;
String imgUrl = rs.getString("image_url");
if(imgUrl == null || imgUrl.isEmpty()) imgUrl = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400";
%>
<div class="col-lg-3 col-md-4 col-sm-6">
<div class="food-card">
<img src="<%= imgUrl %>" class="food-img" alt="<%= rs.getString("name") %>">
<div class="food-card-body">
<div class="food-name"><%= rs.getString("name") %></div>
<div class="food-category"><%= rs.getString("category") %></div>
<div class="food-price">₹<%= rs.getDouble("price") %></div>
<div class="nutrition-info">
<span class="nutrition-badge calories">🔥 <%= rs.getInt("calories") %> cal</span>
<span class="nutrition-badge protein">💪 <%= rs.getString("protein") %></span>
<span class="nutrition-badge carbs">🌾 <%= rs.getString("carbs") %></span>
<span class="nutrition-badge fat">🧈 <%= rs.getString("fat") %></span>
</div>
<form action="<%=request.getContextPath()%>/CartServlet" method="post">
<input type="hidden" name="foodId" value="<%= rs.getInt("id") %>">
<input type="hidden" name="action" value="add">
<input type="number" name="quantity" value="1" min="1" max="10" class="form-control qty-input mb-2">
<button type="submit" class="btn-cart">🛒 Add to Cart</button>
</form>
<a href="reviews.jsp?foodId=<%= rs.getInt("id") %>" class="btn-review">⭐ Reviews</a>
</div>
</div>
</div>
<%
}
if(!found) {
%>
<div class="col-12">
<div class="empty-state">
<div style="font-size:3rem;">😕</div>
<h5 class="mt-2">No items found!</h5>
<a href="menu.jsp" class="btn btn-danger mt-2 rounded-pill">View All Menu</a>
</div>
</div>
<%
}
%>
</div>
<%
} else if(category != null && !category.isEmpty()) {
String emoji = "🍽️";
for(int i=0; i<categories.length; i++) {
if(categories[i].equals(category)) { emoji = catEmojis[i]; break; }
}
%>
<div class="section-heading"><%= emoji %> <%= category %></div>
<div class="row g-4 mb-5">
<%
ps = con.prepareStatement("SELECT * FROM food_items WHERE available=true AND category=?");
ps.setString(1, category);
rs = ps.executeQuery();
while(rs.next()) {
String imgUrl = rs.getString("image_url");
if(imgUrl == null || imgUrl.isEmpty()) imgUrl = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400";
%>
<div class="col-lg-3 col-md-4 col-sm-6">
<div class="food-card">
<img src="<%= imgUrl %>" class="food-img" alt="<%= rs.getString("name") %>">
<div class="food-card-body">
<div class="food-name"><%= rs.getString("name") %></div>
<div class="food-category"><%= rs.getString("category") %></div>
<div class="food-price">₹<%= rs.getDouble("price") %></div>
<div class="nutrition-info">
<span class="nutrition-badge calories">🔥 <%= rs.getInt("calories") %> cal</span>
<span class="nutrition-badge protein">💪 <%= rs.getString("protein") %></span>
<span class="nutrition-badge carbs">🌾 <%= rs.getString("carbs") %></span>
<span class="nutrition-badge fat">🧈 <%= rs.getString("fat") %></span>
</div>
<form action="<%=request.getContextPath()%>/CartServlet" method="post">
<input type="hidden" name="foodId" value="<%= rs.getInt("id") %>">
<input type="hidden" name="action" value="add">
<input type="number" name="quantity" value="1" min="1" max="10" class="form-control qty-input mb-2">
<button type="submit" class="btn-cart">🛒 Add to Cart</button>
</form>
<a href="reviews.jsp?foodId=<%= rs.getInt("id") %>" class="btn-review">⭐ Reviews</a>
</div>
</div>
</div>
<%
}
%>
</div>
<%
} else {
for(int c=0; c<categories.length; c++) {
String currentCat = categories[c];
String currentEmoji = catEmojis[c];
ps = con.prepareStatement("SELECT * FROM food_items WHERE available=true AND category=?");
ps.setString(1, currentCat);
rs = ps.executeQuery();
if(!rs.isBeforeFirst()) continue;
%>
<div class="section-heading"><%= currentEmoji %> <%= currentCat %></div>
<div class="row g-4 mb-5">
<%
while(rs.next()) {
String imgUrl = rs.getString("image_url");
if(imgUrl == null || imgUrl.isEmpty()) imgUrl = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400";
%>
<div class="col-lg-3 col-md-4 col-sm-6">
<div class="food-card">
<img src="<%= imgUrl %>" class="food-img" alt="<%= rs.getString("name") %>">
<div class="food-card-body">
<div class="food-name"><%= rs.getString("name") %></div>
<div class="food-category"><%= rs.getString("category") %></div>
<div class="food-price">₹<%= rs.getDouble("price") %></div>
<div class="nutrition-info">
<span class="nutrition-badge calories">🔥 <%= rs.getInt("calories") %> cal</span>
<span class="nutrition-badge protein">💪 <%= rs.getString("protein") %></span>
<span class="nutrition-badge carbs">🌾 <%= rs.getString("carbs") %></span>
<span class="nutrition-badge fat">🧈 <%= rs.getString("fat") %></span>
</div>
<form action="<%=request.getContextPath()%>/CartServlet" method="post">
<input type="hidden" name="foodId" value="<%= rs.getInt("id") %>">
<input type="hidden" name="action" value="add">
<input type="number" name="quantity" value="1" min="1" max="10" class="form-control qty-input mb-2">
<button type="submit" class="btn-cart">🛒 Add to Cart</button>
</form>
<a href="reviews.jsp?foodId=<%= rs.getInt("id") %>" class="btn-review">⭐ Reviews</a>
</div>
</div>
</div>
<%
}
%>
</div>
<%
}
}
con.close();
} catch(Exception e) {
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
e.printStackTrace();
}
%>
</div>
</body>
</html>
