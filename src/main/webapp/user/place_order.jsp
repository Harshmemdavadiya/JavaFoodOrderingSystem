<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    HttpSession sessionCart = request.getSession(false);
    ArrayList<Map<String,Object>> cart = null;
    if (sessionCart != null) {
        cart = (ArrayList<Map<String,Object>>) sessionCart.getAttribute("cart");
    }

    if (cart == null || cart.isEmpty()) {
        out.println("<script>alert('Your cart is empty!');window.location='all_items.jsp';</script>");
        return;
    }

    // Get checkout form data
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String pincode = request.getParameter("pincode");
    String paymentMethod = request.getParameter("paymentMethod");

    double total = 0;
    StringBuilder itemsBuilder = new StringBuilder();
    for (Map<String,Object> item : cart) {
        double price = (double)item.get("itemPrice");
        int qty = (int)item.get("quantity");
        total += price * qty;

        // Store as: Name x Qty (Price)
        itemsBuilder.append(item.get("itemName"))
                .append(" x ")
                .append(qty)
                .append(" (₹")
                .append((int)price)
                .append("), ");
    }

    // Remove last comma
    String items = itemsBuilder.substring(0, itemsBuilder.length()-2);

    int orderId = 0;
    boolean orderSuccess = false;

    Connection conn = null;
    PreparedStatement psOrder = null;
    ResultSet rsKeys = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db","root","system");

        // Insert all data into single orders table
        String sql = "INSERT INTO orders(full_name,email,phone,address,city,pincode,payment_method,items,total_amount,order_status) " +
                "VALUES(?,?,?,?,?,?,?,?,?,?)";

        psOrder = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        psOrder.setString(1, fullName);
        psOrder.setString(2, email);
        psOrder.setString(3, phone);
        psOrder.setString(4, address);
        psOrder.setString(5, city);
        psOrder.setString(6, pincode);
        psOrder.setString(7, paymentMethod);
        psOrder.setString(8, items);  // All cart items
        psOrder.setDouble(9, total);
        psOrder.setString(10, "Pending"); // Default status
        psOrder.executeUpdate();

        rsKeys = psOrder.getGeneratedKeys();
        if (rsKeys.next()) {
            orderId = rsKeys.getInt(1);
            orderSuccess = true;
            sessionCart.removeAttribute("cart"); // Clear cart
        }

    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
    } finally {
        if (rsKeys!=null) try{rsKeys.close();}catch(Exception ignored){}
        if (psOrder!=null) try{psOrder.close();}catch(Exception ignored){}
        if (conn!=null) try{conn.close();}catch(Exception ignored){}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f4f6f9; font-family:'Poppins',sans-serif; }
        .confirm-container { max-width:600px; margin:50px auto; background:white; padding:30px; border-radius:15px; box-shadow:0 4px 10px rgba(0,0,0,0.1);}
        .confirm-title { font-size:2rem; font-weight:700; text-align:center; color:green; }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="confirm-container text-center">
    <%
        if(orderSuccess){
    %>
    <h2 class="confirm-title">✅ Order Placed Successfully!</h2>
    <p>Thank you <b><%= fullName %></b> for your order.</p>
    <p>Your <b>Order ID</b> is: <b>#<%= orderId %></b></p>
    <p>Total Amount: <b>₹<%= (int)total %></b></p>
    <p>Order Status: <b>Pending</b></p>
    <a href="../user/all_items.jsp" class="btn btn-primary mt-3">Continue Shopping</a>
    <%
    } else {
    %>
    <h2 class="text-danger">❌ Order Failed</h2>
    <p>Something went wrong. Please try again later.</p>
    <a href="../user/all_items.jsp" class="btn btn-warning mt-3">Back to Cart</a>
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
