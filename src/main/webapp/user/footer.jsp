<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Delicious Food Ordering - Signup</title>

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <!-- Animate.css -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
<!-- Footer -->
<footer class="footer mt-5">
  <div class="container">
    <div class="row bottom-footer text-center text-md-start">
      <div class="col-md-3 payment-options mb-3">
        <h5>Payment Options</h5>
        <ul>
          <li><img src="${pageContext.request.contextPath}/images/paypal.png" alt="Paypal"></li>
          <li><img src="${pageContext.request.contextPath}/images/mastercard.png" alt="Mastercard"></li>
          <li><img src="${pageContext.request.contextPath}/images/maestro.png" alt="Maestro"></li>
          <li><img src="${pageContext.request.contextPath}/images/stripe.png" alt="Stripe"></li>
          <li><img src="${pageContext.request.contextPath}/images/bitcoin.png" alt="Bitcoin"></li>
        </ul>
      </div>
      <div class="col-md-4 address mb-3">
        <h5>Email</h5>
        <p>info@foodordering.com</p>
        <h5>Phone: <a href="tel:+919723898024" class="text-light">+91 9723898024</a></h5>
      </div>
      <div class="col-md-5 additional-info">
        <h5>Additional Information</h5>
        <p>Join the thousands of restaurants who benefit from having their menus online.</p>
      </div>
    </div>
  </div>
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>

</body>
</html>