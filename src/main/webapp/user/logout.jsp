<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Get current session
    HttpSession sessionProfile = request.getSession(false);

    // ✅ Invalidate session if exists
    if (sessionProfile != null) {
        sessionProfile.invalidate();
    }

    // ✅ Redirect to login after 2 seconds
    response.setHeader("Refresh", "2; URL=user_login.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - Delicious Food</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: Arial, sans-serif;
        }
        .logout-box {
            background: white;
            padding: 40px 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .logout-box h2 {
            color: #28a745;
        }
        .logout-box p {
            margin-top: 10px;
            color: #555;
        }
        .btn-login {
            margin-top: 15px;
            padding: 10px 20px;
            background: #ff3300;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn-login:hover {
            background: #cc2900;
        }
    </style>
</head>
<body>

<div class="logout-box">
    <h2>Logout Successful!</h2>
    <p>You will be redirected to the login page shortly.</p>
    <a href="user_login.jsp" class="btn-login">Go to Login Now</a>
</div>

</body>
</html>
