<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login - FoodOrder</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
min-height: 100vh;
display: flex;
font-family: 'Poppins', sans-serif;
}

/* LEFT SIDE */
.left-side {
flex: 1;
position: relative;
overflow: hidden;
}

.left-bg {
position: absolute;
inset: 0;
background: url('https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=1200&q=80')
center/cover no-repeat;
animation: slowZoom 15s ease infinite alternate;
}

@keyframes slowZoom {
from { transform: scale(1); }
to { transform: scale(1.08); }
}

.left-overlay {
position: absolute;
inset: 0;
background: linear-gradient(160deg,
rgba(183,28,28,0.88) 0%,
rgba(0,0,0,0.75) 100%);
}

.left-content {
position: relative;
z-index: 1;
height: 100%;
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
padding: 60px 50px;
color: white;
text-align: center;
}

.left-logo {
font-size: 5rem;
margin-bottom: 10px;
filter: drop-shadow(0 5px 15px rgba(0,0,0,0.3));
}

.left-brand {
font-size: 3rem;
font-weight: 900;
letter-spacing: 2px;
margin-bottom: 10px;
text-shadow: 2px 4px 15px rgba(0,0,0,0.4);
}

.left-tagline {
font-size: 1rem;
opacity: 0.9;
max-width: 280px;
line-height: 1.7;
margin-bottom: 35px;
}

.features {
display: flex;
flex-direction: column;
gap: 15px;
width: 100%;
max-width: 300px;
}

.feature-item {
display: flex;
align-items: center;
gap: 15px;
background: rgba(255,255,255,0.12);
backdrop-filter: blur(5px);
padding: 12px 18px;
border-radius: 12px;
border: 1px solid rgba(255,255,255,0.15);
text-align: left;
transition: all 0.3s;
}

.feature-item:hover {
background: rgba(255,255,255,0.2);
transform: translateX(5px);
}

.feature-icon {
font-size: 1.5rem;
}

.feature-text {
font-size: 0.88rem;
font-weight: 500;
opacity: 0.95;
}

/* RIGHT SIDE */
.right-side {
width: 500px;
background: #fafafa;
display: flex;
flex-direction: column;
justify-content: center;
padding: 60px 50px;
position: relative;
}

.right-side::before {
content: '';
position: absolute;
top: 0;
left: 0;
width: 4px;
height: 100%;
background: linear-gradient(180deg, #b71c1c, #e53935, #ff6f60);
}

.welcome-text {
font-size: 0.9rem;
color: #b71c1c;
font-weight: 600;
letter-spacing: 2px;
text-transform: uppercase;
margin-bottom: 8px;
}

.form-title {
font-size: 2.2rem;
font-weight: 800;
color: #1a1a1a;
margin-bottom: 5px;
line-height: 1.2;
}

.form-subtitle {
color: #aaa;
font-size: 0.88rem;
margin-bottom: 35px;
}

.input-group-custom {
position: relative;
margin-bottom: 20px;
}

.input-icon {
position: absolute;
left: 15px;
top: 50%;
transform: translateY(-50%);
font-size: 1rem;
z-index: 1;
}

.form-control {
border-radius: 12px;
padding: 14px 15px 14px 42px;
border: 2px solid #eee;
font-size: 0.9rem;
font-family: 'Poppins', sans-serif;
background: white;
transition: all 0.3s;
width: 100%;
}

.form-control:focus {
border-color: #e53935;
box-shadow: 0 0 0 4px rgba(229,57,53,0.08);
outline: none;
}

.form-label {
font-weight: 600;
color: #333;
font-size: 0.85rem;
margin-bottom: 8px;
display: block;
}

.btn-login {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 12px;
padding: 15px;
font-size: 1rem;
font-weight: 700;
color: white;
width: 100%;
transition: all 0.3s;
font-family: 'Poppins', sans-serif;
letter-spacing: 0.5px;
box-shadow: 0 5px 20px rgba(183,28,28,0.3);
margin-top: 5px;
}

.btn-login:hover {
transform: translateY(-3px);
box-shadow: 0 12px 30px rgba(183,28,28,0.45);
color: white;
}

.btn-login:active {
transform: translateY(0);
}

.register-link {
text-align: center;
color: #888;
font-size: 0.88rem;
margin-top: 25px;
}

.register-link a {
color: #b71c1c;
font-weight: 700;
text-decoration: none;
}

.register-link a:hover { text-decoration: underline; }

.alert {
border-radius: 10px;
font-size: 0.88rem;
padding: 10px 15px;
margin-bottom: 20px;
}

@media (max-width: 768px) {
.left-side { display: none; }
.right-side { width: 100%; padding: 40px 25px; }
}
</style>
</head>
<body>

<!-- LEFT SIDE -->
<div class="left-side">
<div class="left-bg"></div>
<div class="left-overlay"></div>
<div class="left-content">
<div class="left-logo">🍕</div>
<div class="left-brand">FoodOrder</div>
<div class="left-tagline">
Discover amazing food from the best restaurants delivered fresh to your door!
</div>
<div class="features">
<div class="feature-item">
<div class="feature-icon">🚀</div>
<div class="feature-text">Lightning fast delivery in 30 mins</div>
</div>
<div class="feature-item">
<div class="feature-icon">🍽️</div>
<div class="feature-text">100+ mouth-watering dishes</div>
</div>
<div class="feature-item">
<div class="feature-icon">⭐</div>
<div class="feature-text">Top rated by 10,000+ customers</div>
</div>
<div class="feature-item">
<div class="feature-icon">🎉</div>
<div class="feature-text">Exclusive deals & discounts</div>
</div>
</div>
</div>
</div>

<!-- RIGHT SIDE -->
<div class="right-side">
<div class="welcome-text">👋 Welcome Back</div>
<div class="form-title">Login to your<br>account</div>
<div class="form-subtitle">Enter your credentials to continue ordering delicious food!</div>

<% if(request.getParameter("error") != null) { %>
<div class="alert alert-danger">❌ Invalid email or password!</div>
<% } %>
<% if(request.getParameter("registered") != null) { %>
<div class="alert alert-success">✅ Account created! Please login.</div>
<% } %>

<form action="<%=request.getContextPath()%>/LoginServlet" method="post">
<div class="input-group-custom">
<label class="form-label">Email Address</label>
<span class="input-icon">📧</span>
<input type="email" name="email" class="form-control"
placeholder="Enter your email" required>
</div>
<div class="input-group-custom">
<label class="form-label">Password</label>
<span class="input-icon">🔒</span>
<input type="password" name="password" class="form-control"
placeholder="Enter your password" required>
</div>
<button type="submit" class="btn-login">Login to FoodOrder 🚀</button>
</form>

<div class="register-link">
New to FoodOrder? <a href="register.jsp">Create free account →</a>
</div>
</div>

</body>
</html>
