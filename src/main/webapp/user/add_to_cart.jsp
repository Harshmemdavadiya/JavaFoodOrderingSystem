<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    HttpSession sessionCart = request.getSession();
    sessionCart.setMaxInactiveInterval(-1);

    ArrayList<Map<String,Object>> cart =
            (ArrayList<Map<String,Object>>) sessionCart.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
        sessionCart.setAttribute("cart", cart);
    }

    // 🔹 Handle AJAX quantity update
    String ajax = request.getParameter("ajax");
    if ("true".equals(ajax) && "update".equals(request.getParameter("action"))) {
        String updateId = request.getParameter("itemId");
        int newQty = Math.max(1, Integer.parseInt(request.getParameter("quantity")));
        if (newQty > 10) newQty = 10; // ✅ Backend safety check

        double subtotal = 0, total = 0;
        for (Map<String,Object> item : cart) {
            if (item.get("itemId").equals(updateId)) {
                item.put("quantity", newQty);
            }
        }
        for (Map<String,Object> item : cart) {
            double price = (double) item.get("itemPrice");
            int qty = (int) item.get("quantity");
            double sub = price * qty;
            if (item.get("itemId").equals(updateId)) subtotal = sub;
            total += sub;
        }

        response.setContentType("application/json");
        out.print("{\"subtotal\":" + (int)subtotal + ",\"total\":" + (int)total + "}");
        return;
    }

    // 🔹 Remove, clear cart (normal POST)
    String action = request.getParameter("action");
    if ("remove".equals(action)) {
        String removeId = request.getParameter("itemId");
        cart.removeIf(item -> item.get("itemId").equals(removeId));
    } else if ("clear".equals(action)) {
        cart.clear();
    }

    // 🔹 Add new item
    String itemId = request.getParameter("itemId");
    String itemName = request.getParameter("itemName");
    String itemPriceStr = request.getParameter("itemPrice");
    String itemImage = request.getParameter("itemImage");
    String quantityStr = request.getParameter("quantity");

    if (itemId != null && itemName != null && itemPriceStr != null && quantityStr != null && action == null) {
        int quantity = Integer.parseInt(quantityStr);
        if (quantity > 10) quantity = 10; // ✅ Backend limit for adding

        double price = Double.parseDouble(itemPriceStr);
        boolean found = false;
        for (Map<String,Object> item : cart) {
            if (item.get("itemId").equals(itemId)) {
                int newTotalQty = (int)item.get("quantity") + quantity;
                if (newTotalQty > 10) newTotalQty = 10; // ✅ Cap at 10 when increasing
                item.put("quantity", newTotalQty);
                found = true;
                break;
            }
        }
        if (!found) {
            Map<String,Object> newItem = new HashMap<>();
            newItem.put("itemId", itemId);
            newItem.put("itemName", itemName);
            newItem.put("itemPrice", price);
            newItem.put("itemImage", itemImage);
            newItem.put("quantity", quantity);
            cart.add(newItem);
        }
    }

    // 🔹 Profile
    String username = (String) session.getAttribute("username");
    boolean isGuest = (username == null);
    if (isGuest) username = "Guest";
    String userImage = (String) session.getAttribute("userImage");
    if (userImage == null || userImage.trim().isEmpty()) {
        userImage = request.getContextPath() + "/images/profile.png";
    } else {
        userImage = request.getContextPath() + "/images/img/" + userImage;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cart | Delicious Food</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f4f6f9; font-family:'Poppins',sans-serif; }
        .cart-container { max-width:1000px; margin:80px auto; background:white; border-radius:15px; padding:20px; box-shadow:0 4px 10px rgba(0,0,0,0.1); }
        .cart-title { font-size:2rem; font-weight:700; margin-bottom:20px; text-align:center; }
        .cart-item img { width:60px; height:60px; object-fit:cover; border-radius:10px; }
        .total-price { font-size:1.2rem; font-weight:bold; text-align:right; margin-top:20px; }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="cart-container">
    <h2 class="cart-title">🛒 Your Cart</h2>
    <%
        if (cart.isEmpty()) {
    %>
    <div class="alert alert-info text-center">
        Your cart is empty. <a href="all_items.jsp" class="btn btn-sm btn-primary ms-2">Continue Shopping</a>
    </div>
    <%
    } else {
        double total = 0;
    %>
    <table class="table table-bordered align-middle text-center">
        <thead class="table-dark">
        <tr>
            <th>Image</th>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Map<String,Object> item : cart) {
                double price = (double) item.get("itemPrice");
                int qty = (int) item.get("quantity");
                double subtotal = price * qty;
                total += subtotal;
        %>
        <tr class="cart-item" data-id="<%= item.get("itemId") %>">
            <td><img src="<%= request.getContextPath() + "/" + item.get("itemImage") %>"></td>
            <td><%= item.get("itemName") %></td>
            <td>₹<%= (int)price %></td>
            <td>
                <input type="number" value="<%= qty %>" min="1" max="10" class="form-control qty-input" style="width:60px">
            </td>
            <td class="subtotal">₹<%= (int)subtotal %></td>
            <td>
                <form method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="itemId" value="<%= item.get("itemId") %>">
                    <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="d-flex justify-content-between">
        <div>
            <a href="all_items.jsp" class="btn btn-secondary">← Continue Shopping</a>
            <form method="post" style="display:inline;">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="btn btn-warning ms-2">Clear Cart</button>
            </form>
        </div>
        <div>
            <span class="total-price">Total: ₹<%= (int)total %></span>
            <a href="checkout.jsp" class="btn btn-success ms-3">Checkout →</a>
        </div>
    </div>
    <%
        }
    %>
</div>

<script>
    document.querySelectorAll('.qty-input').forEach(input => {
        input.addEventListener('change', function() {
            if (this.value > 10) { // ✅ Frontend validation
                this.value = 10;
                alert("You can only order up to 10 units of this item.");
            }

            let row = this.closest('tr');
            let itemId = row.dataset.id;
            let quantity = this.value;

            fetch('add_to_cart.jsp?action=update&ajax=true&itemId=' + itemId + '&quantity=' + quantity)
                .then(res => res.json())
                .then(data => {
                    row.querySelector('.subtotal').textContent = '₹' + data.subtotal;
                    document.querySelector('.total-price').textContent = 'Total: ₹' + data.total;
                });
        });
    });
</script>
</body>
</html>
