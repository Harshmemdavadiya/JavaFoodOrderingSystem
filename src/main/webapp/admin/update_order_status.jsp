<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String orderId = request.getParameter("orderId");

    // ✅ Validate orderId
    if (orderId == null || orderId.trim().isEmpty()) {
        response.sendRedirect("admin_orders.jsp?msg=invalid");
        return;
    }

    String currentStatus = "";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

        // ✅ If POST request, update order status
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String newStatus = request.getParameter("status");
            ps = conn.prepareStatement("UPDATE orders SET order_status=? WHERE order_id=?");
            ps.setString(1, newStatus);
            ps.setInt(2, Integer.parseInt(orderId));
            int updated = ps.executeUpdate();
            ps.close();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("admin_orders.jsp?msg=updated");
            } else {
                response.sendRedirect("admin_orders.jsp?msg=failed");
            }
            return;
        }

        // ✅ Fetch current order status
        ps = conn.prepareStatement("SELECT order_status FROM orders WHERE order_id=?");
        ps.setInt(1, Integer.parseInt(orderId));
        rs = ps.executeQuery();
        if (rs.next()) {
            currentStatus = rs.getString("order_status");
        } else {
            response.sendRedirect("admin_orders.jsp?msg=notfound");
            return;
        }

    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Order Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .update-box {
            max-width: 500px;
            margin: 80px auto;
            padding: 30px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
        }
        .update-box h3 {
            text-align: center;
            margin-bottom: 25px;
        }
        .btn-success {
            width: 100%;
            border-radius: 8px;
            padding: 10px;
            font-weight: 500;
        }
        .btn-secondary {
            width: 100%;
            border-radius: 8px;
            padding: 10px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="update-box shadow">
        <div class="text-center">
            <i class="fas fa-edit login-icon mb-3" style="font-size:40px;color:#28a745;"></i>
            <h3>Update Order #<%= orderId %></h3>
        </div>

        <form method="post">
            <div class="mb-3">
                <label class="form-label">Current Status</label>
                <input type="text" class="form-control bg-light" value="<%= currentStatus %>" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">New Status</label>
                <select name="status" class="form-select shadow-sm" required>
                    <option value="">Select Status</option>
                    <option value="Pending" <%= "Pending".equalsIgnoreCase(currentStatus)?"selected":"" %>>Pending</option>
                    <option value="Processing" <%= "Processing".equalsIgnoreCase(currentStatus)?"selected":"" %>>Processing</option>
                    <option value="Delivered" <%= "Delivered".equalsIgnoreCase(currentStatus)?"selected":"" %>>Delivered</option>
                    <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(currentStatus)?"selected":"" %>>Cancelled</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Update Status</button>
            <a href="admin_orders.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Orders</a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
