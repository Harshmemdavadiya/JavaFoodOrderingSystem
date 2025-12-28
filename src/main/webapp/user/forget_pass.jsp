<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Email OTP Verification</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="card shadow p-4" style="max-width: 400px; margin: auto;">
    <h3 class="text-center">Get OTP</h3>
    <form action="EmailServlet" method="post">
      <div class="mb-3">
        <label for="email" class="form-label">Enter your Email</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Send OTP</button>
    </form>
  </div>
</div>
</body>
</html>
