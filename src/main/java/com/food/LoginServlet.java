package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

String email = request.getParameter("email");
String password = request.getParameter("password");

try {
Connection con = DBConnection.getConnection();
String sql = "SELECT * FROM users WHERE email=? AND password=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, email);
ps.setString(2, password);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
HttpSession session = request.getSession();
session.setAttribute("userId", rs.getInt("id"));
session.setAttribute("userName", rs.getString("name"));
session.setAttribute("userRole", rs.getString("role"));

if (rs.getString("role").equals("admin")) {
response.sendRedirect("admin.jsp");
} else {
response.sendRedirect("menu.jsp");
}
} else {
response.sendRedirect("login.jsp?error=1");
}
con.close();
} catch (Exception e) {
e.printStackTrace();
}
}
}