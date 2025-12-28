<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-box {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .btn-primary {
            width: 100%;
            border-radius: 8px;
            padding: 10px;
            font-weight: 500;
        }

        .login-icon {
            font-size: 40px;
            color: #007bff;
            margin-bottom: 10px;
        }

        .input-group-text {
            background-color: #f0f2f5;
            border: 1px solid #ced4da;
            border-right: 0;
        }

        .form-control {
            border-left: 0;
            border-radius: 0 10px 10px 0;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-box shadow">
        <div class="text-center">
            <i class="fas fa-user-shield login-icon"></i>
            <h2>Admin Login</h2>
        </div>
        <form action="<%= request.getContextPath() %>/admin_login_srlt" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control"     id="username" name="username"
                           placeholder="Enter username"
                           value="<%= request.getAttribute("enteredUsername") != null ? request.getAttribute("enteredUsername") : "" %>"
                           required>
                </div>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
    </div>
</div>

<!-- SweetAlert2 for login error or logout success -->
<%
    String errorMsg = (String) request.getAttribute("errorMsg");
    if (errorMsg != null) {
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Login Failed',
        text: '<%= errorMsg %>',
        confirmButtonColor: '#d33'
    });
</script>
<%
    }

    String logoutMsg = request.getParameter("logout");
    if ("true".equals(logoutMsg)) {
%>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Logged Out',
        text: 'You have been successfully logged out.',
        confirmButtonColor: '#3085d6'
    });
</script>
<%
    }
%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
