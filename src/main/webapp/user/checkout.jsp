<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionCart = request.getSession(false);
    ArrayList<Map<String,Object>> cart = null;
    if (sessionCart != null) {
        cart = (ArrayList<Map<String,Object>>) sessionCart.getAttribute("cart");
    }

    if (cart == null || cart.isEmpty()) {
%>
<script>
    alert("Your cart is empty! Please add items first.");
    window.location.href = "all_items.jsp";
</script>
<%
        return;
    }

    // Fetch username, email, phone & user image from session
    String username = (String) session.getAttribute("username");
    boolean isGuest = (username == null);
    if (isGuest) username = "";

    String userEmail = (String) session.getAttribute("email");
    if(userEmail == null) userEmail = "";

    String userPhone = (String) session.getAttribute("phone");
    if(userPhone == null) userPhone = "";

    String userImage = (String) session.getAttribute("userImage");
    if (userImage == null || userImage.trim().isEmpty()) {
        userImage = request.getContextPath() + "/images/profile.png";
    } else {
        userImage = request.getContextPath() + "/images/img/" + userImage;
    }

    double total = 0;
    for (Map<String,Object> item : cart) {
        double price = (double)item.get("itemPrice");
        int qty = (int)item.get("quantity");
        total += price * qty;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout | Delicious Food</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background:#f4f6f9; font-family:'Poppins',sans-serif; }
        .checkout-container { max-width:1100px; margin:80px auto 40px; background:white; border-radius:15px; padding:30px; box-shadow:0 4px 10px rgba(0,0,0,0.1); }
        .checkout-title { font-size:2rem; font-weight:700; margin-bottom:20px; text-align:center; }
        .order-summary { background:#f8f9fa; border-radius:10px; padding:15px; }
        .cart-item img { width:50px; height:50px; border-radius:8px; object-fit:cover; }
        .total-price { font-size:1.3rem; font-weight:bold; text-align:right; margin-top:15px; }
        .form-section { margin-top:30px; }
        .card-details { display:none; background:#f9f9f9; padding:15px; border-radius:10px; margin-top:10px; }
        .profile-icon { position: fixed; top: 90px; right: 40px; cursor: pointer; z-index: 1050; }
        .profile-icon img { width: 55px; height: 55px; border-radius: 50%; box-shadow: 0 4px 12px rgba(0,0,0,0.25); transition: transform 0.2s; }
        .profile-icon img:hover { transform: scale(1.1); }
        .profile-popup-img { width: 80px; height: 80px; border-radius: 50%; opacity: 0; transform: translateY(-30px); transition: all 0.5s ease; }
        .profile-popup-img.show { opacity: 1; transform: translateY(0); }
        .modal-content { border-radius: 15px; overflow: hidden; }
        .modal-header { background-color: #0d6efd; color: white; }
        .list-group-item a { text-decoration: none; color: #333; }
        .list-group-item a:hover { color: #0d6efd; }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<!-- Profile Icon + Popup -->
<div class="profile-icon" data-bs-toggle="modal" data-bs-target="#profileModal">
    <img src="<%= userImage %>" alt="Profile"/>
</div>

<div class="modal fade" id="profileModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-user-circle me-2"></i> Welcome, <%= username %>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center p-4">
                <img src="<%= userImage %>" class="mb-3 profile-popup-img">
                <ul class="list-group">
                    <%
                        if (isGuest) {
                    %>
                    <li class="list-group-item"><a href="login.jsp"><i class="fas fa-sign-in-alt me-2"></i> Login</a></li>
                    <li class="list-group-item"><a href="register.jsp"><i class="fas fa-user-plus me-2"></i> Register</a></li>
                    <%
                    } else {
                    %>
                    <li class="list-group-item"><a href="profile.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                    <li class="list-group-item"><a href="myorders.jsp"><i class="fas fa-box me-2"></i> My Orders</a></li>
                    <li class="list-group-item"><a href="add_to_cart.jsp"><i class="fas fa-shopping-cart me-2"></i> My Cart</a></li>
                    <li class="list-group-item"><a href="invoice.jsp"><i class="fas fa-file-invoice-dollar me-2"></i> Download Invoice</a></li>
                    <li class="list-group-item"><a href="changepassword.jsp"><i class="fas fa-key me-2"></i> Change Password</a></li>
                    <li class="list-group-item"><a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Checkout Section -->
<div class="checkout-container">
    <h2 class="checkout-title">🛒 Checkout</h2>
    <div class="row g-4">
        <!-- Order Summary -->
        <div class="col-lg-6">
            <div class="order-summary">
                <h4 class="mb-3">Order Summary</h4>
                <table class="table table-bordered align-middle text-center">
                    <thead class="table-dark">
                    <tr>
                        <th>Image</th>
                        <th>Item</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Map<String,Object> item : cart) {
                            double price = (double)item.get("itemPrice");
                            int qty = (int)item.get("quantity");
                            double subtotal = price * qty;
                    %>
                    <tr class="cart-item">
                        <td><img src="<%= request.getContextPath() + "/" + item.get("itemImage") %>"></td>
                        <td><%= item.get("itemName") %></td>
                        <td><%= qty %></td>
                        <td>₹<%= (int)price %></td>
                        <td>₹<%= (int)subtotal %></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                <div class="total-price">Total: ₹<%= (int)total %></div>
            </div>
        </div>

        <!-- Checkout Form -->
        <div class="col-lg-6">
            <div class="form-section">
                <h4 class="mb-3">Delivery & Payment Details</h4>
                <form action="place_order.jsp" method="post">
                    <!-- Full Name auto-filled from session -->
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control"  required>
                    </div>

                    <!-- Email auto-filled from session, read-only -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="<%= username%>" readonly required>
                    </div>

                    <!-- Phone auto-filled from session -->
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="text" name="phone" class="form-control" pattern="[0-9]{10}" value="<%= userPhone %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Delivery Address</label>
                        <textarea name="address" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">City</label>
                        <input type="text" name="city" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Pin Code</label>
                        <input type="text" name="pincode" class="form-control" pattern="[0-9]{6}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Payment Method</label>
                        <select name="paymentMethod" class="form-select" required onchange="toggleCardDetails(this.value)">
                            <option value="">Select Payment Method</option>
                            <option value="COD">Cash on Delivery</option>
                            <option value="Card">Credit/Debit Card</option>
                        </select>
                    </div>

                    <!-- Card Details Section -->
                    <div class="card-details" id="cardDetails">
                        <div class="mb-2">
                            <label class="form-label">Card Number</label>
                            <input type="text" name="cardNumber" id="cardNumber" maxlength="19" class="form-control" placeholder="####-####-####-####">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Expiry Date</label>
                            <input type="month" name="expiry" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">CVV</label>
                            <input type="password" name="cvv" class="form-control" maxlength="3" pattern="[0-9]{3}">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100 py-2 mt-3">Place Order →</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleCardDetails(value) {
        const cardSection = document.getElementById("cardDetails");
        const cardInputs = cardSection.querySelectorAll("input");

        if(value === "Card") {
            cardSection.style.display = "block";
            cardInputs.forEach(inp => inp.required = true);
        } else {
            cardSection.style.display = "none";
            cardInputs.forEach(inp => inp.required = false);
        }
    }

    // Auto-format card number
    const cardInput = document.getElementById("cardNumber");
    if(cardInput){
        cardInput.addEventListener("input", function(e) {
            let value = e.target.value.replace(/\D/g, "").substring(0,16);
            let formatted = value.match(/.{1,4}/g);
            e.target.value = formatted ? formatted.join("-") : "";
        });
    }

    // Animate popup image
    const profileModal = document.getElementById('profileModal');
    profileModal.addEventListener('shown.bs.modal', () => {
        document.querySelector('.profile-popup-img').classList.add('show');
    });
    profileModal.addEventListener('hidden.bs.modal', () => {
        document.querySelector('.profile-popup-img').classList.remove('show');
    });
</script>
</body>
</html>
