<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // --- Session Check ---
    HttpSession sessionProfile = request.getSession(false);
    if (sessionProfile == null || sessionProfile.getAttribute("username") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }
    String sessionEmail = (String) sessionProfile.getAttribute("username");

    // --- DB Connection ---
    String url = "jdbc:mysql://localhost:3306/food_db";
    String dbUser = "root";
    String dbPass = "system";

    String fullName="", phone="", address="", city="", pincode="", payment="", items="", status="";
    double totalAmount=0;
    String orderDate="";
    int orderId = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try(Connection conn = DriverManager.getConnection(url, dbUser, dbPass)) {
            // Fetch latest order for logged-in user
            String sql = "SELECT * FROM orders WHERE email=? ORDER BY order_id DESC LIMIT 1";
            try(PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, sessionEmail);
                try(ResultSet rs = ps.executeQuery()) {
                    if(rs.next()){
                        orderId = rs.getInt("order_id");
                        fullName = rs.getString("full_name");
                        phone = rs.getString("phone");
                        address = rs.getString("address");
                        city = rs.getString("city");
                        pincode = rs.getString("pincode");
                        payment = rs.getString("payment_method");
                        items = rs.getString("items");
                        totalAmount = rs.getDouble("total_amount");
                        status = rs.getString("order_status");
                        orderDate = rs.getString("order_date");
                    } else {
                        out.println("<h3>No orders found for your account.</h3>");
                        return;
                    }
                }
            }
        }
    } catch(Exception e){
        out.println("<h3>Database Error: " + e.getMessage() + "</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice - Order <%= orderId %></title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; }
        .invoice-container {
            width: 700px;
            background: white;
            margin: 50px auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { text-align: center; margin-bottom: 20px; }
        .section { margin-bottom: 20px; }
        .section h3 { margin-bottom: 5px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 8px; text-align: left; }
        .total { text-align: right; font-weight: bold; }
        .btn-download {
            display: block; width: 200px; margin: 20px auto;
            padding: 10px; background: #0d6efd; color: white; text-align: center;
            text-decoration: none; border-radius: 5px;
        }
        .btn-download:hover { background: #084298; }
    </style>
</head>
<body>

<div class="invoice-container" id="invoice">
    <h2>Delicious Food - Invoice</h2>
    <div class="section">
        <h3>Customer Info</h3>
        <p><strong>Name:</strong> <%= fullName %></p>
        <p><strong>Email:</strong> <%= sessionEmail %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
        <p><strong>Address:</strong> <%= address %>, <%= city %> - <%= pincode %></p>
        <p><strong>Payment:</strong> <%= payment %></p>
    </div>

    <div class="section">
        <h3>Order Info</h3>
        <p><strong>Order ID:</strong> <%= orderId %></p>
        <p><strong>Date:</strong> <%= orderDate %></p>
        <p><strong>Status:</strong> <%= status %></p>
    </div>

    <div class="section">
        <h3>Items</h3>
        <table>
            <tr><th>Item</th></tr>
            <%
                if(items != null && !items.trim().isEmpty()){
                    for(String item : items.split(",")){
            %>
            <tr><td><%= item.trim() %></td></tr>
            <%
                }
            } else {
            %>
            <tr><td>No items found</td></tr>
            <% } %>
            <tr>
                <td class="total">Total Amount: ₹<%= totalAmount %></td>
            </tr>
        </table>
    </div>
</div>

<a href="#" class="btn-download" onclick="downloadPDF()">Download Invoice PDF</a>

<script>
    function downloadPDF() {
        const element = document.getElementById('invoice');
        html2pdf()
            .from(element)
            .set({
                margin: 10,
                filename: 'Invoice_Order_<%= orderId %>.pdf',
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
            })
            .save();
    }
</script>

</body>
</html>
