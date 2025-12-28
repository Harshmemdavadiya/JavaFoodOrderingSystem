<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // ✅ Check user session
  HttpSession sessionUser = request.getSession(false);
  if (sessionUser == null || sessionUser.getAttribute("username") == null) {
    response.sendRedirect("user_login.jsp");
    return;
  }
  String email = (String) sessionUser.getAttribute("username");

  // ✅ Database config
  String dbURL = "jdbc:mysql://localhost:3306/food_db";
  String dbUser = "root";
  String dbPass = "system";

  String message = null;
  String alertClass = "danger";

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String oldPass = request.getParameter("oldPassword");
    String newPass = request.getParameter("newPassword");
    String confirmPass = request.getParameter("confirmPassword");

    if (newPass != null && newPass.equals(confirmPass)) {
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

          // 1️⃣ Verify old password
          String checkSQL = "SELECT password FROM users WHERE email=?";
          try (PreparedStatement ps = conn.prepareStatement(checkSQL)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
              String dbPassword = rs.getString("password");
              if (dbPassword.equals(oldPass)) {

                // 2️⃣ Update new password
                String updateSQL = "UPDATE users SET password=? WHERE email=?";
                try (PreparedStatement ps2 = conn.prepareStatement(updateSQL)) {
                  ps2.setString(1, newPass);
                  ps2.setString(2, email);
                  int rows = ps2.executeUpdate();
                  if (rows > 0) {
                    message = "✅ Password changed successfully!";
                    alertClass = "success";
                  } else {
                    message = "❌ Error updating password!";
                  }
                }
              } else {
                message = "❌ Old password is incorrect!";
              }
            } else {
              message = "❌ User not found!";
            }
          }
        }
      } catch (Exception e) {
        message = "❌ Error: " + e.getMessage();
      }
    } else {
      message = "❌ New Password & Confirm Password do not match!";
    }
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Change Password | Delicious Food</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
    .container { max-width: 450px; margin-top: 80px; }
    .card { border-radius: 12px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); padding: 25px; }
    .btn-custom { background-color: #007bff; color: white; font-weight: 500; } /* Blue Button */
    .btn-custom:hover { background-color: #0056b3; } /* Darker Blue */
    .btn-secondary-custom { background-color: #6c757d; color: white; font-weight: 500; } /* Gray Button */
    .btn-secondary-custom:hover { background-color: #5a6268; }
    .card h3 { text-align: center; margin-bottom: 20px; font-weight: 600; color: #333; }
    .form-label i { color: #007bff; margin-right: 5px; } /* Blue Icon */

    /* ✅ Blue theme for focus and links */
    .form-control:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }
    .btn-check:focus + .btn,
    .btn:focus {
      box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.4);
    }
    a, a:hover { color: #007bff; }
    .alert-success {
      background-color: #007bff !important;
      border-color: #007bff !important;
      color: white !important;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="card">
    <h3><i class="fas fa-key"></i> Change Password</h3>

    <% if (message != null) { %>
    <div class="alert alert-<%= alertClass %> text-center"><%= message %></div>
    <% } %>

    <form method="post">
      <div class="mb-3">
        <label class="form-label"><i class="fas fa-lock"></i> Old Password</label>
        <input type="password" name="oldPassword" class="form-control" required>
      </div>
      <div class="mb-3">
        <label class="form-label"><i class="fas fa-lock"></i> New Password</label>
        <input type="password" name="newPassword" class="form-control" required>
      </div>
      <div class="mb-3">
        <label class="form-label"><i class="fas fa-lock"></i> Confirm New Password</label>
        <input type="password" name="confirmPassword" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-custom w-100 mb-2">Change Password</button>

      <!-- ✅ Back to Cart Button -->
      <a href="all_items.jsp" class="btn btn-secondary-custom w-100">
        <i class="fas fa-shopping-cart"></i> Back to Cart
      </a>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
