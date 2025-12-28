<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionProfile = request.getSession(false);
    if (sessionProfile == null || sessionProfile.getAttribute("username") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }

    String sessionEmail = (String) sessionProfile.getAttribute("username");

    String url = "jdbc:mysql://localhost:3306/food_db";
    String dbUser = "root";
    String dbPass = "system";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders | Delicious Food</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background: #f4f6f9; font-family: 'Poppins', sans-serif; }
        .orders-container { max-width: 1100px; margin: 50px auto; }
        .orders-title { text-align: center; margin-bottom: 30px; font-weight: 700; color: #222; }
        .table { background: #fff; border-radius: 10px; overflow: hidden; }
        .table thead { background: #0d6efd; color: white; }
        .status-pending { color: #ffc107; font-weight: bold; }
        .status-completed { color: #28a745; font-weight: bold; }
        .status-cancelled { color: #dc3545; font-weight: bold; }
        .item-table { width: 100%; font-size: 14px; margin-top: 5px; }
        .item-table td { border: none !important; padding: 2px 8px; }
        .order-row { background: #f8f9fa; }
        .edit-btn { background-color: #0d6efd; color: white; border: none; padding: 5px 12px; border-radius: 5px; font-size: 13px; }
        .edit-btn:hover { background-color: #084298; }
        .disabled-text { color: gray; font-style: italic; font-size: 13px; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="orders-container">
    <h2 class="orders-title"><i class="fas fa-box me-2"></i> My Orders</h2>

    <div class="table-responsive shadow-sm">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Status</th>
                <th>Total Amount</th>
                <th>Items</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPass);

                    String sql = "SELECT order_id, order_date, order_status, total_amount, items FROM orders WHERE email = ? ORDER BY order_date DESC";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, sessionEmail);
                    rs = ps.executeQuery();

                    boolean hasOrders = false;
                    while (rs.next()) {
                        hasOrders = true;
                        int orderId = rs.getInt("order_id");
                        String orderDate = rs.getString("order_date");
                        String status = rs.getString("order_status");
                        double totalAmount = rs.getDouble("total_amount");
                        String items = rs.getString("items");

                        String statusClass = "status-pending";
                        if ("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                        else if ("Cancelled".equalsIgnoreCase(status)) statusClass = "status-cancelled";
            %>
            <tr class="order-row">
                <td><%= orderId %></td>
                <td><%= orderDate %></td>
                <td class="<%= statusClass %>"><%= status %></td>
                <td>₹<%= totalAmount %></td>
                <td>
                    <table class="item-table">
                        <%
                            if(items != null && !items.trim().isEmpty()) {
                                String[] itemList = items.split(",");
                                for(String item : itemList) {
                        %>
                        <tr><td>• <%= item.trim() %></td></tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </td>
                <td>
                    <% if("Pending".equalsIgnoreCase(status)) { %>
                    <button class="edit-btn"
                            onclick="openEditModal('<%= orderId %>', '<%= items.replace("'", "\\'") %>', '<%= totalAmount %>')">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <form action="cancel_order.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="<%= orderId %>">
                        <button type="submit" class="btn btn-danger btn-sm ms-1">Cancel</button>
                    </form>
                    <% } else { %>
                    <span class="disabled-text">Not Editable</span>
                    <% } %>
                </td>
            </tr>
            <%
                }
                if (!hasOrders) {
            %>
            <tr>
                <td colspan="6" class="text-center text-muted">You have no orders yet.</td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="update_order.jsp" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="orderId" id="modalOrderId">
                    <div class="mb-3">
                        <label>Items (comma separated)</label>
                        <textarea name="items" id="modalItems" class="form-control" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label>Total Amount</label>
                        <input type="number" name="totalAmount" id="modalTotal" class="form-control" required step="0.01">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openEditModal(orderId, items, total){
        document.getElementById("modalOrderId").value = orderId;
        document.getElementById("modalItems").value = items;
        document.getElementById("modalTotal").value = total;
        var modal = new bootstrap.Modal(document.getElementById('editModal'));
        modal.show();
    }
</script>
</body>
</html>
