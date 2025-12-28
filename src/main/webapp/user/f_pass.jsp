<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String message = null;
    boolean redirect = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session1 = request.getSession();
        String email = (String) session1.getAttribute("email");

        if (email == null) {
            message = "Session expired! Please try again.";
        } else if (!password.equals(confirmPassword)) {
            message = "Passwords do not match!";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

                PreparedStatement ps = con.prepareStatement("UPDATE users SET password=? WHERE email=?");
                ps.setString(1, password);  // ⚠️ In real apps, always hash passwords
                ps.setString(2, email);

                int updated = ps.executeUpdate();
                if (updated > 0) {
                    session1.removeAttribute("email");
                    redirect = true; // set redirect flag
                } else {
                    message = "❌ Failed to update password.";
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                message = "❌ Database error!";
            }
        }
    }

    // Perform redirect before any HTML output
    if (redirect) {
        String loginURL = request.getContextPath() + "/user/user_login.jsp?msg=PasswordUpdated";
        response.sendRedirect(loginURL);
        return;
    }

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .reset-card {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
        }
        .reset-card h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .btn-reset {
            width: 100%;
            background: #11998e;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            padding: 12px;
        }
        .btn-reset:hover {
            background: #0c7a65;
        }
    </style>
</head>
<body>
<div class="reset-card">
    <h2>Reset Password</h2>

    <% if (message != null) { %>
    <div class="alert alert-info text-center"><%= message %></div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" class="form-control" name="password" required minlength="6">
        </div>
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" class="form-control" name="confirmPassword" required minlength="6">
        </div>
        <button type="submit" class="btn btn-reset">Update Password</button>
    </form>
</div>
</body>
</html>
