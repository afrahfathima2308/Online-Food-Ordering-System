package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CartServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
doGet(request, response);
}

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

HttpSession session = request.getSession(false);
int userId = (int) session.getAttribute("userId");
String action = request.getParameter("action");

try {
Connection con = DBConnection.getConnection();
if(action.equals("add")) {
int foodId = Integer.parseInt(request.getParameter("foodId"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
String sql = "INSERT INTO cart(user_id, food_id, quantity) VALUES(?,?,?)";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ps.setInt(2, foodId);
ps.setInt(3, quantity);
ps.executeUpdate();
} else if(action.equals("remove")) {
int cartId = Integer.parseInt(request.getParameter("cartId"));
String sql = "DELETE FROM cart WHERE id=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, cartId);
ps.executeUpdate();
}
con.close();
} catch(Exception e) {
e.printStackTrace();
}
response.sendRedirect("cart.jsp");
}
}