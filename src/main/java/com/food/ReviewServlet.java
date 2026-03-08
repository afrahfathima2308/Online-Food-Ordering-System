package com.food;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ReviewServlet extends HttpServlet {
protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

HttpSession session = request.getSession(false);
int userId = (int) session.getAttribute("userId");
int foodId = Integer.parseInt(request.getParameter("foodId"));
int rating = Integer.parseInt(request.getParameter("rating"));
String comment = request.getParameter("comment");

try {
Connection con = DBConnection.getConnection();
String sql = "INSERT INTO reviews(user_id, food_id, rating, comment) VALUES(?,?,?,?)";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, userId);
ps.setInt(2, foodId);
ps.setInt(3, rating);
ps.setString(4, comment);
ps.executeUpdate();
con.close();
} catch(Exception e) {
e.printStackTrace();
}
response.sendRedirect("reviews.jsp?foodId=" + foodId);
}
}
