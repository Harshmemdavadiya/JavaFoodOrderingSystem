<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Forgot Password - Delicious Food Ordering</title>

  <!-- Include Header -->
  <jsp:include page="header.jsp"/>

  <!-- Reset & Fonts -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <style>
    body {
      background: #f8f9fa;
      font-family: 'Roboto', sans-serif;
    }
    .pen-title {
      text-align: center;
      margin: 50px 0 30px;
    }
    .pen-title h1 {
      font-weight: 500;
      color: #333;
    }
    .form-module {
      background: #ffffff;
      max-width: 400px;
      margin: auto;
      padding: 40px 30px;
      border-radius: 10px;
      box-shadow: 0 5px 30px rgba(0,0,0,0.1);
    }
    .form-module h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
      font-weight: 500;
    }
    .input-group-text {
      background-color: #20b2aa;
      color: white;
      border: none;
    }
    .form-module input {
      padding: 12px;
    }
    .form-module input:focus {
      border-color: #007bff;
      outline: none;
    }
    .form-module #buttn {
      width: 100%;
      background-color: #007bff; /* Blue */
      color: #fff;
      padding: 12px;
      border: none;
      border-radius: 5px;
      font-weight: 500;
      cursor: pointer;
      transition: 0.3s;
      margin-top: 15px;
    }
    .form-module #buttn:hover {
      background-color: #0056b3; /* Darker Blue */
    }
    .cta {
      text-align: center;
      margin-top: 15px;
    }
    .cta a {
      color: #007bff;
      text-decoration: none;
      font-weight: 500;
    }
    .cta a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body class="home">

<!-- Page Title -->
<div class="pen-title">
  <h1>Forgot Password</h1>
</div>

<!-- Forgot Password Form -->
<div class="form-module">
  <div class="form">
    <h2>Reset Your Password</h2>
    <form action="<%= request.getContextPath() %>/forgot_password_srlt" method="post">
      <div class="input-group mb-3">
        <span class="input-group-text"><i class="fa fa-envelope"></i></span>
        <input type="email" class="form-control" placeholder="Enter your registered email" name="email" required>
      </div>
      <input type="submit" id="buttn" value="Send Reset Link">
    </form>
  </div>
  <div class="cta">
    Remembered your password? <a href="login.jsp">Login Here</a>
  </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
