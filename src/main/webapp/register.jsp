<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Register - FoodOrder</title>
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
background: url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1200&q=80')
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

.left-logo { font-size: 5rem; margin-bottom: 10px; }

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
margin-bottom: 30px;
}

.stats {
display: flex;
gap: 15px;
margin-top: 10px;
}

.stat-item {
background: rgba(255,255,255,0.12);
backdrop-filter: blur(5px);
padding: 12px 15px;
border-radius: 12px;
border: 1px solid rgba(255,255,255,0.15);
text-align: center;
}

.stat-number {
font-size: 1.3rem;
font-weight: 800;
}

.stat-label {
font-size: 0.72rem;
opacity: 0.85;
}

/* RIGHT SIDE */
.right-side {
width: 480px;
background: #fafafa;
display: flex;
flex-direction: column;
justify-content: center;
padding: 40px 45px;
position: relative;
overflow-y: auto;
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
font-size: 0.85rem;
color: #b71c1c;
font-weight: 600;
letter-spacing: 2px;
text-transform: uppercase;
margin-bottom: 6px;
}

.form-title {
font-size: 1.9rem;
font-weight: 800;
color: #1a1a1a;
margin-bottom: 4px;
line-height: 1.2;
}

.form-subtitle {
color: #aaa;
font-size: 0.85rem;
margin-bottom: 25px;
}

.input-group-custom {
position: relative;
margin-bottom: 16px;
}

.input-icon {
position: absolute;
left: 14px;
top: 68%;
transform: translateY(-50%);
font-size: 0.95rem;
z-index: 1;
}

.form-control {
border-radius: 12px;
padding: 12px 15px 12px 40px;
border: 2px solid #eee;
font-size: 0.88rem;
font-family: 'Poppins', sans-serif;
background: white;
transition: all 0.3s;
width: 100%;
}

.form-control:focus {
border-color: #e53935;
box-shadow: 0 0 0 3px rgba(229,57,53,0.08);
outline: none;
}

.form-label {
font-weight: 600;
color: #333;
font-size: 0.82rem;
margin-bottom: 6px;
display: block;
}

.btn-register {
background: linear-gradient(135deg, #e53935, #b71c1c);
border: none;
border-radius: 12px;
padding: 13px;
font-size: 0.95rem;
font-weight: 700;
color: white;
width: 100%;
transition: all 0.3s;
font-family: 'Poppins', sans-serif;
box-shadow: 0 5px 20px rgba(183,28,28,0.3);
margin-top: 5px;
cursor: pointer;
}

.btn-register:hover {
transform: translateY(-3px);
box-shadow: 0 12px 30px rgba(183,28,28,0.45);
color: white;
}

.login-link {
text-align: center;
color: #888;
font-size: 0.85rem;
margin-top: 18px;
}

.login-link a {
color: #b71c1c;
font-weight: 700;
text-decoration: none;
}

.login-link a:hover { text-decoration: underline; }

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
Join thousands of food lovers and enjoy amazing meals delivered to your door!
</div>
<div class="stats">
<div class="stat-item">
<div class="stat-number">10K+</div>
<div class="stat-label">Happy Customers</div>
</div>
<div class="stat-item">
<div class="stat-number">100+</div>
<div class="stat-label">Menu Items</div>
</div>
<div class="stat-item">
<div class="stat-number">30 min</div>
<div class="stat-label">Avg Delivery</div>
</div>
</div>
</div>
</div>

<!-- RIGHT SIDE -->
<div class="right-side">
<div class="welcome-text">🎉 Get Started</div>
<div class="form-title">Create your<br>free account</div>
<div class="form-subtitle">Join us and start ordering your favourite food today!</div>

<% if(request.getParameter("error") != null) { %>
<div class="alert alert-danger rounded-3 py-2 mb-3"
style="font-size:0.85rem;">
❌ Email already exists!
</div>
<% } %>

<form action="<%=request.getContextPath()%>/RegisterServlet" method="post">
<div class="input-group-custom">
<label class="form-label">Full Name</label>
<span class="input-icon">👤</span>
<input type="text" name="name" class="form-control"
placeholder="Enter your full name" required>
</div>
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
placeholder="Create a strong password" required>
</div>
<button type="submit" class="btn-register">Create Account 🚀</button>
</form>

<div class="login-link">
Already have an account? <a href="login.jsp">Login here →</a>
</div>
</div>

</body>
</html>

