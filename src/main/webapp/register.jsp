<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Register - Food Ordering</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
<div class="row justify-content-center">
<div class="col-md-4">
<div class="card shadow">
<div class="card-body p-4">
<h3 class="text-center mb-4">🍕 Register</h3>

<% if(request.getParameter("error") != null) { %>
<div class="alert alert-danger">Email already exists!</div>
<% } %>

<form action="RegisterServlet" method="post">
<div class="mb-3">
<label>Full Name</label>
<input type="text" name="name" class="form-control" required>
</div>
<div class="mb-3">
<label>Email</label>
<input type="email" name="email" class="form-control" required>
</div>
<div class="mb-3">
<label>Password</label>
<input type="password" name="password" class="form-control" required>
</div>
<button type="submit" class="btn btn-success w-100">Register</button>
</form>
<p class="text-center mt-3">
Already have account? <a href="login.jsp">Login here</a>
</p>
</div>
</div>
</div>
</div>
</div>

</body>
</html>