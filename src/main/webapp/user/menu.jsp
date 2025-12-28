<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ✅ Fetch username from session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        username = "Guest";
    }

    // ✅ Fetch user image (from session or default)
    String userImage = (String) session.getAttribute("userImage");
    if (userImage == null || userImage.trim().isEmpty()) {
        // Default image
        userImage = request.getContextPath() + "/images/profile.png";
    } else {
        // Uploaded user image
        userImage = request.getContextPath() + "/images/img/" + userImage;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile Popup</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }

        /* Profile Icon Fixed on Top-Right */
        .profile-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            cursor: pointer;
            z-index: 1050;
        }

        .profile-icon img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        /* Modal Customization */
        .modal-content {
            border-radius: 15px;
            overflow: hidden;
        }

        .modal-header {
            background-color: #0d6efd;
            color: white;
        }

        .list-group-item a {
            text-decoration: none;
            color: #333;
        }

        .list-group-item a:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>

<!-- 🔹 Profile Icon to Open Popup -->
<div class="profile-icon" data-bs-toggle="modal" data-bs-target="#profileModal">
    <img src="<%= userImage %>" alt="Profile"/>
</div>

<!-- 🔹 Profile Popup Modal -->
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
                <!-- Profile Picture -->
                <img src="<%= userImage %>" class="mb-3" style="width:80px; height:80px; border-radius:50%;">

                <ul class="list-group">
                    <li class="list-group-item"><a href="profile.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                    <li class="list-group-item"><a href="myorders.jsp"><i class="fas fa-box me-2"></i> My Orders</a></li>
                    <li class="list-group-item"><a href="mycart.jsp"><i class="fas fa-shopping-cart me-2"></i> My Cart</a></li>
                    <li class="list-group-item"><a href="changepassword.jsp"><i class="fas fa-key me-2"></i> Change Password</a></li>
                    <li class="list-group-item"><a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                </ul>

                <!-- Debug Info -->
                <p class="mt-3 text-muted" style="font-size: 12px;">
                    Debug Image Path: <%= userImage %>
                </p>
            </div>

        </div>
    </div>
</div>

</body>
</html>
