package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
Connection con = DBConnection.getConnection();
String sql = "INSERT INTO users(name, email, password) VALUES(?,?,?)";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, password);
ps.executeUpdate();
con.close();
response.sendRedirect("login.jsp?registered=1");
} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("register.jsp?error=1");
}
}
}