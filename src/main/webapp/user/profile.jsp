<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Get current session
    HttpSession sessionProfile = request.getSession(false);

    if (sessionProfile == null || sessionProfile.getAttribute("username") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }

    // ✅ Session 'username' actually stores email
    String sessionEmail = (String) sessionProfile.getAttribute("username");

    // ✅ DB variables
    String url = "jdbc:mysql://localhost:3306/food_db";
    String dbUser = "root";
    String dbPass = "system";

    String username = null, firstName = null, lastName = null, email = null, phone = null, address = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, dbUser, dbPass);

        // ✅ Fetch user by email (session username)
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=?");
        ps.setString(1, sessionEmail);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            username = rs.getString("username");
            firstName = rs.getString("first_name");
            lastName = rs.getString("last_name");
            email = rs.getString("email");
            phone = rs.getString("phone");
            address = rs.getString("address");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile | Delicious Food</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- ✅ Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #f4f6f9;
            font-family: 'Poppins', sans-serif;
        }
        .profile-container {
            max-width: 700px;
            margin: 80px auto;
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
            border: 3px solid #0d6efd;
        }
        .info-card p {
            margin: 10px 0;
            font-size: 1rem;
        }
        .info-card i {
            color: #0d6efd;
            width: 25px;
        }
        .btn-custom {
            min-width: 140px;
        }
    </style>
</head>
<body>

<div class="profile-container">
    <div class="profile-header">
        <img src="<%= request.getContextPath() %>/images/profile.png" class="profile-img" alt="Profile">
        <h3 class="mt-2"><i class="fas fa-user-circle me-2"></i><%= (firstName!=null?firstName:"") %> <%= (lastName!=null?lastName:"") %></h3>
        <p class="text-muted mb-0">Welcome, <%= sessionEmail %></p>
    </div>

    <div class="info-card">
        <p><i class="fas fa-user"></i> <b>Username:</b> <%= username %></p>
        <p><i class="fas fa-envelope"></i> <b>Email:</b> <%= email %></p>
        <p><i class="fas fa-phone"></i> <b>Phone:</b> <%= (phone != null ? phone : "Not Provided") %></p>
        <p><i class="fas fa-map-marker-alt"></i> <b>Address:</b> <%= (address != null ? address : "Not Provided") %></p>
    </div>

    <div class="mt-4 d-flex justify-content-center gap-3">
        <a href="myorders.jsp" class="btn btn-primary btn-custom"><i class="fas fa-box me-2"></i>My Orders</a>
        <a href="changepassword.jsp" class="btn btn-warning btn-custom"><i class="fas fa-key me-2"></i>Change Password</a>
        <a href="logout.jsp" class="btn btn-danger btn-custom"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
