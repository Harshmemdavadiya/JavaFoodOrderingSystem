<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
  // ✅ Check if admin is logged in
  String uname = (String) session.getAttribute("uname");
  if (uname == null) {
    response.sendRedirect("admin_login.jsp");
    return;
  }

  // ✅ Fetch admin details from DB
  String email = "";
  String fullName = "";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

    PreparedStatement ps = conn.prepareStatement("SELECT * FROM admin_login WHERE username=?");
    ps.setString(1, uname);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
      fullName = rs.getString("full_name"); // make sure column exists
      email = rs.getString("email");        // make sure column exists
    }

    rs.close();
    ps.close();
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #f8f9fa; }
    .profile-card {
      max-width: 500px;
      margin: 60px auto;
      background: white;
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      padding: 30px;
    }
    .profile-card img {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      object-fit: cover;
    }
    h3 { color: #0d6efd; font-weight: bold; }
  </style>
</head>
<body>

<div class="profile-card text-center">
  <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile Image">
  <h3 class="mt-3"><%= uname %></h3>
  <p class="text-muted">Administrator</p>

  <hr>

  <p><i class="fas fa-user me-2 text-primary"></i> <strong>Full Name:</strong> <%= uname%></p>


  <div class="mt-3">
    <a href="admin_dashboard.jsp" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <a href="logout.jsp" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</div>

</body>
</html>
