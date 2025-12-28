<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .forgot-container {
            background: #ffffff;
            padding: 40px 35px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            animation: fadeInUp 1s ease;
        }
        .forgot-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2575fc;
            font-weight: 600;
        }
        .form-control {
            border-radius: 12px;
            padding: 12px;
        }
        .btn-custom {
            width: 100%;
            background: linear-gradient(135deg, #2575fc, #6a11cb);
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            color: #fff;
            transition: 0.3s ease;
        }
        .btn-custom:hover {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            transform: scale(1.05);
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .note {
            margin-top: 15px;
            font-size: 14px;
            color: #6c757d;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="forgot-container">
    <h2>Forgot Password 🔒</h2>
    <form action="<%= request.getContextPath() %>/forgerpassSrlt" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Enter your Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" required>
        </div>
        <button type="submit" class="btn btn-custom">Send OTP</button>
    </form>
    <p class="note">We will send a 6-digit OTP to your registered email.</p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
