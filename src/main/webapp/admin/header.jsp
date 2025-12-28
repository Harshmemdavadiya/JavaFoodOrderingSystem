<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }

        /* Navbar */
        .navbar-brand {
            font-weight: bold;
            font-size: 1.25rem;
            color: #ffffff;
        }

        .toggle-btn {
            cursor: pointer;
            color: #ffffff;
            font-size: 1.2rem;
        }

        /* Sidebar */
        .sidebar {
            height: 100vh;
            position: fixed;
            width: 250px;
            top: 0;
            left: 0;
            background-color: #212529;
            padding-top: 56px;
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
        }

        .sidebar a {
            color: #ffffff;          /* Full white text */
            padding: 15px;
            display: block;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.2s;
        }

        .sidebar a:hover {
            background-color: #343a40;
            color: #ffffff;
        }

        /* Submenu */
        .submenu {
            background-color: #2e323e;
            padding-left: 15px;
            display: none;
            border-left: 3px solid #0d6efd;
        }

        .submenu.show {
            display: block;
        }

        .submenu a {
            padding-left: 35px;
            font-weight: normal;
            color: #ffffff;
        }

        .submenu a:hover {
            background-color: #495057;
        }

        /* Main Content */
        .content {
            margin-left: 250px;
            padding: 20px;
            margin-top: 56px;
            transition: all 0.3s;
        }

        @media (max-width: 768px) {
            .sidebar {
                left: -250px;
            }

            .sidebar.active {
                left: 0;
            }

            .content {
                margin-left: 0;
            }

            .content.shifted {
                margin-left: 250px;
            }
        }

        /* Caret Icon on right */
        .sidebar a .fas.fa-caret-down {
            float: right;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <span class="navbar-toggler toggle-btn me-3" id="menu-toggle">
            <i class="fas fa-bars"></i>
        </span>
        <a class="navbar-brand" href="#">Admin Panel</a>
        <div class="ms-auto">
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="adminMenu" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle"></i> Admin
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminMenu">
                        <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>

    <!-- Manage Category -->
    <a href="#" id="categoryMenuToggle">
        <i class="fas fa-list-alt me-2"></i> Manage Category
        <i class="fas fa-caret-down"></i>
    </a>
    <div class="submenu" id="categorySubmenu">
        <a href="add_category.jsp"><i class="fas fa-plus me-2"></i> Add Category</a>
        <a href="view_category.jsp"><i class="fas fa-edit me-2"></i> Edit Category</a>
        <a href="delete_cat.jsp"><i class="fas fa-trash me-2"></i> Delete Category</a>
    </div>

    <!-- Manage Food -->
    <a href="#" id="foodMenuToggle">
        <i class="fas fa-utensils me-2"></i> Manage Food
        <i class="fas fa-caret-down"></i>
    </a>
    <div class="submenu" id="foodSubmenu">
        <a href="add_food.jsp"><i class="fas fa-plus me-2"></i> Add Food</a>
        <a href="edit_food.jsp"><i class="fas fa-edit me-2"></i> Edit Food</a>
        <a href="delete_food.jsp"><i class="fas fa-trash me-2"></i> Delete Food</a>
    </div>

    <a href="admin_orders.jsp"><i class="fas fa-receipt me-2"></i> Orders</a>
    <a href="users.jsp"><i class="fas fa-users me-2"></i> Customers</a>
    <a href="profile.jsp"><i class="fas fa-user me-2"></i> Profile</a>
    <a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="content" id="main-content">
    <!-- Content is empty now -->
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const toggleBtn = document.getElementById("menu-toggle");
    const sidebar = document.getElementById("sidebar");
    const content = document.getElementById("main-content");

    toggleBtn.addEventListener("click", function () {
        sidebar.classList.toggle("active");
        content.classList.toggle("shifted");
    });

    // Submenu toggles
    const categoryToggle = document.getElementById("categoryMenuToggle");
    const categorySubmenu = document.getElementById("categorySubmenu");

    const foodToggle = document.getElementById("foodMenuToggle");
    const foodSubmenu = document.getElementById("foodSubmenu");

    function toggleSubmenu(clickedSubmenu) {
        // Close other submenus (accordion behavior)
        document.querySelectorAll(".submenu").forEach(menu => {
            if (menu !== clickedSubmenu) menu.classList.remove("show");
        });
        clickedSubmenu.classList.toggle("show");
    }

    categoryToggle.addEventListener("click", function (e) {
        e.preventDefault();
        toggleSubmenu(categorySubmenu);
    });

    foodToggle.addEventListener("click", function (e) {
        e.preventDefault();
        toggleSubmenu(foodSubmenu);
    });
</script>

</body>
</html>
