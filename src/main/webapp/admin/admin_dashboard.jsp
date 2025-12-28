<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Disable caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // ✅ Fetch username from session
    String uname = (String) session.getAttribute("uname");

    // ✅ Redirect to login page if session is null
    if (uname == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background-color: #f8f9fa; }
        .content { margin-left: 250px; padding: 30px; }
        h1 { color: #0d6efd; font-weight: bold; }
        .card { border-radius: 15px; }
        .card-title { font-weight: 600; }
        @media (max-width: 768px) {
            .content { margin-left: 0; padding: 20px; }
        }
    </style>
</head>
<body>

<!-- Main Dashboard Content -->
<div class="content" id="main-content">
    <div class="container mt-4">
        <!-- ✅ Display logged-in username dynamically -->
        <h1 class="mb-3">Welcome, <%= uname %> 👋</h1>
        <p class="lead">This is your admin dashboard. From here, you can manage categories, food items, orders, and customers.</p>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-bg-primary mb-3 shadow">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-list-alt me-2"></i> Categories</h5>
                        <p class="card-text">Create, edit, or delete categories.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-bg-success mb-3 shadow">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-utensils me-2"></i> Food Items</h5>
                        <p class="card-text">Manage food menus and pricing.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-bg-warning mb-3 shadow">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-receipt me-2"></i> Orders</h5>
                        <p class="card-text">Track and manage customer orders.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
