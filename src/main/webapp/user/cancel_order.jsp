<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Ensure user is logged in
  HttpSession sessionProfile = request.getSession(false);
  if (sessionProfile == null || sessionProfile.getAttribute("username") == null) {
    response.sendRedirect("user_login.jsp");
    return;
  }

  String sessionEmail = (String) sessionProfile.getAttribute("username");

  // Get the order ID from the POST request
  String orderIdStr = request.getParameter("orderId");
  if(orderIdStr == null || orderIdStr.trim().isEmpty()){
    response.sendRedirect("myorders.jsp?error=Invalid order ID");
    return;
  }

  int orderId = Integer.parseInt(orderIdStr);

  // DB connection
  String url = "jdbc:mysql://localhost:3306/food_db";
  String dbUser = "root";
  String dbPass = "system";

  Connection conn = null;
  PreparedStatement ps = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPass);

    // ✅ Cancel order only if status is Pending and belongs to this user
    String sql = "UPDATE orders SET order_status='Cancelled' WHERE order_id=? AND email=? AND order_status='Pending'";
    ps = conn.prepareStatement(sql);
    ps.setInt(1, orderId);
    ps.setString(2, sessionEmail);

    int rows = ps.executeUpdate();

    if(rows > 0){
      response.sendRedirect("myorders.jsp?success=Order cancelled successfully");
    } else {
      response.sendRedirect("myorders.jsp?error=Cannot cancel this order");
    }

  } catch(Exception e) {
    out.println("Error: " + e.getMessage());
  } finally {
    if(ps != null) try{ ps.close(); }catch(Exception e){}
    if(conn != null) try{ conn.close(); }catch(Exception e){}
  }
%>
