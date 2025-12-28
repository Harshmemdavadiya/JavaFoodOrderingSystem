<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }

    String username = (String) userSession.getAttribute("username");
    String userImage = (String) userSession.getAttribute("userImage");

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
    <title>Our Menu | Delicious Food</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background: #f4f6f9; font-family: 'Poppins', sans-serif; }
        .menu-title { text-align: center; font-weight: 700; font-size: 2.5rem; color: #222; margin: 40px 0; }
        .food-card { border: 1px solid #ddd; border-radius: 15px; background: #fff; overflow: hidden; text-align: center; padding: 15px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .food-card:hover { transform: translateY(-6px); box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15); }
        .food-card img { width: 100%; height: 160px; object-fit: cover; margin-bottom: 10px; border-radius: 10px; }
        .category-name { font-weight: bold; font-size: 0.9rem; color: #007bff; margin-bottom: 5px; }
        .food-title { font-weight: 600; font-size: 1.1rem; color: #222; margin-bottom: 5px; }
        .food-price { color: #000; font-size: 1rem; font-weight: bold; margin-bottom: 10px; }
        .qty-btn { width: 35px; height: 35px; font-size: 18px; font-weight: bold; display: flex; align-items: center; justify-content: center; line-height: 1; border-radius: 50%; padding: 0; }
        .qty-input { width: 45px; text-align: center; background: #fff; }
        .add-btn { background-color: #007bff; color: white; font-weight: 600; padding: 6px 24px; border-radius: 30px; border: none; transition: background-color 0.3s; }
        .add-btn:hover { background-color: #0056b3; }
        .profile-icon { position: fixed; top: 90px; right: 40px; cursor: pointer; z-index: 1050; }
        .profile-icon img { width: 55px; height: 55px; border-radius: 50%; box-shadow: 0 4px 12px rgba(0,0,0,0.25); transition: transform 0.2s; }
        .profile-icon img:hover { transform: scale(1.1); }
        .modal-content { border-radius: 15px; overflow: hidden; }
        .modal-header { background-color: #0d6efd; color: white; }
        .list-group-item a { text-decoration: none; color: #333; }
        .list-group-item a:hover { color: #0d6efd; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<!-- Profile Icon -->
<div class="profile-icon" data-bs-toggle="modal" data-bs-target="#profileModal">
    <img src="<%= userImage %>" alt="Profile"/>
</div>

<!-- Profile Modal -->
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
                <img src="<%= userImage %>" class="mb-3" style="width:80px; height:80px; border-radius:50%;">
                <ul class="list-group">
                    <li class="list-group-item"><a href="profile.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                    <li class="list-group-item"><a href="myorders.jsp"><i class="fas fa-box me-2"></i> My Orders</a></li>
                    <li class="list-group-item"><a href="add_to_cart.jsp"><i class="fas fa-shopping-cart me-2"></i> My Cart</a></li>
                    <li class="list-group-item"><a href="invoice.jsp"><i class="fas fa-file-invoice-dollar me-2"></i> Download Invoice</a></li>
                    <li class="list-group-item"><a href="changepassword.jsp"><i class="fas fa-key me-2"></i> Change Password</a></li>
                    <li class="list-group-item"><a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Menu Section -->
<div class="container">
    <h2 class="menu-title">🍽 Our Special Menu</h2>

    <!-- 🔍 Search Box -->
    <div class="row mb-4">
        <div class="col-md-6 offset-md-3">
            <input type="text" id="searchBox" class="form-control form-control-lg shadow-sm"
                   placeholder="🔍 Search food by name or category...">
        </div>
    </div>

    <div class="row g-4" id="menuContainer">
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

                String query = "SELECT f.food_id, f.food_name, f.price, f.description, f.image_path, c.ctg_name " +
                        "FROM foods f JOIN category c ON f.category_id = c.ctg_id";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                boolean hasItems = false;
                while (rs.next()) {
                    hasItems = true;
                    int id = rs.getInt("food_id");
                    String name = rs.getString("food_name");
                    double price = rs.getDouble("price");
                    String image = rs.getString("image_path") != null ? rs.getString("image_path") : "food_image/noimage.png";
                    String category = rs.getString("ctg_name");
        %>
        <div class="col-lg-3 col-md-4 col-sm-6 food-item">
            <div class="food-card h-100">
                <div class="category-name"><%= category %></div>
                <img src="<%= request.getContextPath() + "/" + image %>" alt="<%= name %>">
                <div class="food-title"><%= name %></div>
                <div class="food-price">PRICE ₹<%= (int)price %></div>

                <!-- Quantity Controls -->
                <form class="d-flex justify-content-center align-items-center gap-2 mb-2">
                    <span>QUANTITY</span>
                    <button type="button" class="btn btn-outline-secondary qty-btn" onclick="updateQty(this, -1)">−</button>
                    <input type="text" name="quantity" value="1" class="form-control qty-input" readonly>
                    <button type="button" class="btn btn-outline-secondary qty-btn" onclick="updateQty(this, 1)">+</button>
                </form>

                <!-- Add to Cart -->
                <form action="add_to_cart.jsp" method="post">
                    <input type="hidden" name="itemId" value="<%= id %>">
                    <input type="hidden" name="itemName" value="<%= name %>">
                    <input type="hidden" name="itemPrice" value="<%= price %>">
                    <input type="hidden" name="itemImage" value="<%= image %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="add-btn">ADD TO CART</button>
                </form>
            </div>
        </div>
        <%
            }
            if (!hasItems) {
        %>
        <div class="col-12 text-center">
            <div class="alert alert-info">No food items available right now. Please check back later!</div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                if (ps != null) try { ps.close(); } catch (Exception ignore) {}
                if (conn != null) try { conn.close(); } catch (Exception ignore) {}
            }
        %>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    function updateQty(btn, change) {
        const input = btn.parentElement.querySelector("input[name='quantity']");
        let value = parseInt(input.value) || 1;
        value = Math.min(10, Math.max(1, value + change)); // limit 1–10
        input.value = value;

        // Disable/enable buttons based on limits
        const minusBtn = btn.parentElement.querySelector("button:first-of-type");
        const plusBtn = btn.parentElement.querySelector("button:last-of-type");
        minusBtn.disabled = (value === 1);
        plusBtn.disabled = (value === 10);

        const hiddenQtyInput = btn.closest('.food-card').querySelector("form:last-of-type input[name='quantity']");
        if (hiddenQtyInput) hiddenQtyInput.value = value;
    }

    // 🔍 Search filter
    document.getElementById("searchBox").addEventListener("keyup", function() {
        const query = this.value.toLowerCase();
        const items = document.querySelectorAll("#menuContainer .food-item");

        items.forEach(item => {
            const name = item.querySelector(".food-title").textContent.toLowerCase();
            const category = item.querySelector(".category-name").textContent.toLowerCase();

            if (name.includes(query) || category.includes(query)) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
