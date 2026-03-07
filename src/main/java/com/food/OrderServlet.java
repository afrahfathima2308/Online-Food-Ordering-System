package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class OrderServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

HttpSession session = request.getSession(false);
int userId = (int) session.getAttribute("userId");
double total = Double.parseDouble(request.getParameter("total"));

try {
Connection con = DBConnection.getConnection();

// Insert order
String sql = "INSERT INTO orders(user_id, total_amount) VALUES(?,?)";
PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
ps.setInt(1, userId);
ps.setDouble(2, total);
ps.executeUpdate();

// Get order ID
ResultSet rs = ps.getGeneratedKeys();
int orderId = 0;
if(rs.next()) orderId = rs.getInt(1);

// Move cart items to order_items
String cartSql = "SELECT * FROM cart WHERE user_id=?";
PreparedStatement cartPs = con.prepareStatement(cartSql);
cartPs.setInt(1, userId);
ResultSet cartRs = cartPs.executeQuery();

while(cartRs.next()) {
String itemSql = "INSERT INTO order_items(order_id, food_id, quantity, price) " +
"SELECT ?, food_id, quantity, f.price FROM cart c " +
"JOIN food_items f ON c.food_id=f.id WHERE c.id=?";
PreparedStatement itemPs = con.prepareStatement(itemSql);
itemPs.setInt(1, orderId);
itemPs.setInt(2, cartRs.getInt("id"));
itemPs.executeUpdate();
}

// Clear cart
String clearSql = "DELETE FROM cart WHERE user_id=?";
PreparedStatement clearPs = con.prepareStatement(clearSql);
clearPs.setInt(1, userId);
clearPs.executeUpdate();

con.close();
response.sendRedirect("orders.jsp");
} catch(Exception e) {
e.printStackTrace();
}
}
}