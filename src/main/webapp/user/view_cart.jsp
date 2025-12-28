<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Cart</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
  <h2 class="text-center mb-4">🛒 My Cart</h2>

  <%
    HttpSession sessionCart = request.getSession();
    List<Map<String,Object>> cart = (List<Map<String,Object>>) sessionCart.getAttribute("cart");

    if(cart == null || cart.isEmpty()){
  %>
  <div class="alert alert-info text-center">
    Your cart is empty. <a href="all_items.jsp" class="alert-link">Shop Now</a>
  </div>
  <%
  } else {
    double grandTotal = 0;
  %>
  <table class="table table-bordered table-hover text-center bg-white shadow">
    <thead class="table-dark">
    <tr>
      <th>Image</th>
      <th>Item</th>
      <th>Price</th>
      <th>Qty</th>
      <th>Total</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      for(int i=0;i<cart.size();i++){
        Map<String,Object> item = cart.get(i);
        double price = (Double)item.get("itemPrice");
        int qty = (Integer)item.get("quantity");
        double total = price * qty;
        grandTotal += total;
    %>
    <tr>
      <td><img src="<%= request.getContextPath()+"/"+item.get("itemImage") %>" width="80"></td>
      <td><%= item.get("itemName") %></td>
      <td>₹<%= (int)price %></td>
      <td><%= qty %></td>
      <td>₹<%= (int)total %></td>
      <td><a href="remove_item.jsp?index=<%=i%>" class="btn btn-danger btn-sm">Remove</a></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

  <div class="text-end mt-3">
    <h4>Grand Total: ₹<%= (int)grandTotal %></h4>
    <a href="checkout.jsp" class="btn btn-success btn-lg mt-3">Proceed to Checkout</a>
  </div>
  <%
    }
  %>
</div>

</body>
</html>
