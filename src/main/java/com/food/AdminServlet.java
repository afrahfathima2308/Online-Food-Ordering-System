package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AdminServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

int orderId = Integer.parseInt(request.getParameter("orderId"));
String status = request.getParameter("status");

try {
Connection con = DBConnection.getConnection();
String sql = "UPDATE orders SET status=? WHERE id=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, status);
ps.setInt(2, orderId);
ps.executeUpdate();
con.close();
} catch(Exception e) {
e.printStackTrace();
}
response.sendRedirect("admin.jsp");
}
}