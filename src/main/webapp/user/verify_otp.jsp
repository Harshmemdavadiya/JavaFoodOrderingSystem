<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .otp-card {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .otp-card h2 {
            margin-bottom: 20px;
            color: #333;
            font-weight: bold;
        }
        .otp-input {
            font-size: 18px;
            text-align: center;
            letter-spacing: 5px;
            padding: 10px;
            border-radius: 8px;
        }
        .btn-verify {
            width: 100%;
            background: #2575fc;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            padding: 12px;
            transition: 0.3s ease;
        }
        .btn-verify:hover {
            background: #6a11cb;
        }
    </style>
</head>
<body>
<div class="otp-card">
    <h2>🔐 Verify OTP</h2>
    <form action="<%= request.getContextPath() %>/verifyOTPsrlt" method="post">
        <div class="mb-3">
            <label for="otp" class="form-label">Enter the 6-digit OTP</label>
            <input type="text" class="form-control otp-input" name="otp" maxlength="6" required>
        </div>
        <button type="submit" class="btn btn-verify">Verify</button>
    </form>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
