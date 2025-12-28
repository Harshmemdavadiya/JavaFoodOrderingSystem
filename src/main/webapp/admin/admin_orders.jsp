<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="header.jsp" %> <%-- Sidebar/Menu Include --%>
<head>
    <meta charset="UTF-8">
    <title>Admin | Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background:#f4f6f9; font-family:'Poppins',sans-serif; }

        /* Menu ke niche content shift */
        .orders-page {
            margin-left: 250px; /* sidebar width */
            padding: 30px;
        }

        .orders-container {
            background:white;
            border-radius:15px;
            padding:20px;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
            max-width:1200px;
            margin:auto;
        }

        .orders-title {
            font-size:2rem;
            font-weight:700;
            margin-bottom:20px;
            text-align:center;
        }

        @media(max-width: 992px){
            .orders-page { margin-left: 0; padding:15px; }
        }
    </style>
</head>
<body>

<div class="orders-page">
    <div class="orders-container">
        <h2 class="orders-title">📦 Customer Orders</h2>

        <%
            // --- Handle Update Logic (POST) ---
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String orderId = request.getParameter("orderId");
                String newStatus = request.getParameter("status");

                if (orderId != null && newStatus != null) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

                        PreparedStatement ps = conn.prepareStatement("UPDATE orders SET order_status=? WHERE order_id=?");
                        ps.setString(1, newStatus);
                        ps.setInt(2, Integer.parseInt(orderId));
                        int rows = ps.executeUpdate();

                        ps.close();
                        conn.close();

                        if (rows > 0) {
                            out.println("<script>Swal.fire({icon:'success',title:'Updated!',text:'Order status updated successfully',timer:1500,showConfirmButton:false});</script>");
                        } else {
                            out.println("<script>Swal.fire({icon:'error',title:'Error',text:'Order not found!'});</script>");
                        }
                    } catch (Exception e) {
                        out.println("<script>Swal.fire({icon:'error',title:'DB Error',text:'"+e.getMessage()+"'});</script>");
                    }
                }
            }
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Items</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

                        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while(rs.next()) {
                            int orderId = rs.getInt("order_id");
                            String fullName = rs.getString("full_name");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                            String items = rs.getString("items");
                            double totalAmount = rs.getDouble("total_amount");
                            String status = rs.getString("order_status");
                            Timestamp orderDate = rs.getTimestamp("order_date");

                            // Extract only item names
                            String[] itemList = items.split(",");
                            StringBuilder itemNames = new StringBuilder();
                            for(String item : itemList) {
                                String nameOnly = item.trim().split(" x")[0];
                                if(itemNames.length() > 0) itemNames.append(", ");
                                itemNames.append(nameOnly);
                            }

                            // Decide badge color based on status
                            String badgeClass = "bg-secondary";
                            if("Pending".equalsIgnoreCase(status)) badgeClass = "bg-primary";
                            else if("Completed".equalsIgnoreCase(status)) badgeClass = "bg-success";
                            else if("Canceled".equalsIgnoreCase(status)) badgeClass = "bg-danger";
                            else if("Out for Delivery".equalsIgnoreCase(status)) badgeClass = "bg-warning text-dark";
                %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= fullName %></td>
                    <td><%= email %></td>
                    <td><%= phone %></td>
                    <td style="text-align:left;"><%= itemNames.toString() %></td>
                    <td>₹<%= (int)totalAmount %></td>
                    <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                    <td><%= orderDate %></td>
                    <td>
                        <form method="post" style="display:flex;gap:5px;">
                            <input type="hidden" name="orderId" value="<%= orderId %>">
                            <select name="status" class="form-select form-select-sm">
                                <option value="Pending" <%= status.equals("Pending")?"selected":"" %>>Pending</option>
                                <option value="Out for Delivery" <%= status.equals("Out for Delivery")?"selected":"" %>>Out for Delivery</option>
                                <option value="Completed" <%= status.equals("Completed")?"selected":"" %>>Completed</option>
                                <option value="Canceled" <%= status.equals("Canceled")?"selected":"" %>>Canceled</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">Update</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='9' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
                    } finally {
                        if(rs!=null) try{rs.close();}catch(Exception ignore){}
                        if(ps!=null) try{ps.close();}catch(Exception ignore){}
                        if(conn!=null) try{conn.close();}catch(Exception ignore){}
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
