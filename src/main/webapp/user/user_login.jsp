<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Delicious Food Ordering</title>

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
      font-family: 'Roboto', sans-serif;
      background: url('<%=request.getContextPath()%>/images/f3.jpg') no-repeat center center fixed !important;
      background-size: cover !important;
      min-height: 100vh;
      margin: 0;
    }
    .pen-title {
      text-align: center;
      margin: 50px 0 30px;
    }
    .pen-title h1 {
      font-weight: 500;
      color: #fff; /* White text for visibility on background */
      text-shadow: 1px 1px 5px rgba(0,0,0,0.6);
    }
    .form-module {
      background: #ffffff;
      max-width: 400px;
      margin: auto;
      padding: 40px 30px;
      border-radius: 10px;
      box-shadow: 0 5px 30px rgba(0,0,0,0.3);
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
      background-color: #007bff;
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
      background-color: #0056b3;
    }
    .forgot-link {
      text-align: center;
      margin-top: 12px;
    }
    .forgot-link a {
      font-size: 0.9rem;
      color: #007bff;
      text-decoration: none;
    }
    .forgot-link a:hover {
      text-decoration: underline;
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

<body>

<!-- Page Title -->
<div class="pen-title">
  <h1>Login Form</h1>
</div>

<!-- Login Form -->
<div class="form-module">
  <div class="form">
    <h2>Login to your account</h2>
    <form action="<%= request.getContextPath() %>/login_srlt" method="post">
      <div class="input-group mb-3">
        <span class="input-group-text"><i class="fa fa-user"></i></span>
        <input type="text" class="form-control" placeholder="Enter EmailId" name="username" required>
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text"><i class="fa fa-lock"></i></span>
        <input type="password" class="form-control" placeholder="Password" name="password" required>
      </div>
      <input type="submit" id="buttn" value="Login">
      <!-- Forgot Password Link After Button -->
      <div class="forgot-link">
        <a href="email.jsp">Forgot Password?</a>
      </div>
    </form>
  </div>
  <div class="cta">Not registered?
    <a href="registration.jsp"> Create An Account</a>
  </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Wrong Password Modal -->
<div class="modal fade" id="wrongPasswordModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content text-center p-4" style="border-radius: 15px;">
      <div class="modal-body">
        <!-- Red Circle with Lock -->
        <div class="mb-3">
          <div style="width:90px;height:90px;margin:auto;border-radius:50%;background:#f44336;display:flex;align-items:center;justify-content:center;">
            <i class="fa fa-lock" style="font-size:40px;color:#fff;"></i>
          </div>
        </div>
        <!-- Error Message -->
        <h4 class="fw-bold text-danger">WRONG PASSWORD!</h4>
        <p class="text-muted">Please try again.</p>
        <button type="button" class="btn btn-danger mt-3" data-bs-dismiss="modal">Try Again</button>
      </div>
    </div>
  </div>
</div>

<!-- Show Modal if status=fail -->
<%
  String status = request.getParameter("status");
  if ("fail".equals(status)) {
%>
<script>
  var modal = new bootstrap.Modal(document.getElementById('wrongPasswordModal'));
  modal.show();

  // ✅ Remove the query parameter from URL so refresh doesn't trigger again
  if (window.history.replaceState) {
    const url = new URL(window.location);
    url.searchParams.delete("status");
    window.history.replaceState({}, document.title, url);
  }
</script>
<%
  }
%>

</body>
</html>
