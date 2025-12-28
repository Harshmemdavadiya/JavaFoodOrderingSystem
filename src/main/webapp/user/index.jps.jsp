<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FoodHub - Delicious Food Delivery</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    :root {
      --primary-color: #ff6b35;
      --secondary-color: #f7931e;
      --accent-color: #ffd23f;
      --dark-color: #2c3e50;
      --light-color: #ecf0f1;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
    }

    .hero-section {
      background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
      url('https://images.unsplash.com/photo-1504674900240-7747b97952e5?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
      background-size: cover;
      background-position: center;
      color: white;
      padding: 100px 0;
      text-align: center;
    }

    .hero-title {
      font-size: 3.5rem;
      font-weight: 700;
      margin-bottom: 20px;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }

    .hero-subtitle {
      font-size: 1.3rem;
      margin-bottom: 40px;
      opacity: 0.9;
    }

    .cta-buttons {
      display: flex;
      gap: 20px;
      justify-content: center;
      flex-wrap: wrap;
    }

    .btn-custom {
      padding: 15px 30px;
      border-radius: 50px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 1px;
      transition: all 0.3s ease;
      border: none;
    }

    .btn-primary-custom {
      background: var(--primary-color);
      color: white;
    }

    .btn-primary-custom:hover {
      background: #e55a2b;
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(255, 107, 53, 0.3);
    }

    .btn-outline-custom {
      background: transparent;
      color: white;
      border: 2px solid white;
    }

    .btn-outline-custom:hover {
      background: white;
      color: var(--dark-color);
      transform: translateY(-2px);
    }

    .features-section {
      padding: 80px 0;
      background: white;
    }

    .feature-card {
      text-align: center;
      padding: 40px 20px;
      border-radius: 15px;
      background: white;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
      margin-bottom: 30px;
    }

    .feature-card:hover {
      transform: translateY(-10px);
    }

    .feature-icon {
      font-size: 3rem;
      color: var(--primary-color);
      margin-bottom: 20px;
    }

    .navbar-custom {
      background: rgba(255, 255, 255, 0.95) !important;
      backdrop-filter: blur(10px);
      box-shadow: 0 2px 20px rgba(0,0,0,0.1);
    }

    .navbar-brand {
      font-weight: 700;
      font-size: 1.5rem;
      color: var(--primary-color) !important;
    }

    .nav-link {
      font-weight: 500;
      color: var(--dark-color) !important;
      transition: color 0.3s ease;
    }

    .nav-link:hover {
      color: var(--primary-color) !important;
    }
  </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light navbar-custom fixed-top">
  <div class="container">
    <a class="navbar-brand" href="#">
      <i class="fas fa-utensils me-2"></i>FoodHub
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="#home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#features">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="user/user_login.jsp">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="user/registration.jsp">Register</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero-section">
  <div class="container">
    <h1 class="hero-title">Delicious Food Delivered</h1>
    <p class="hero-subtitle">Order your favorite meals from the best restaurants in town</p>
    <div class="cta-buttons">
      <a href="user/user_login.jsp" class="btn btn-custom btn-primary-custom">
        <i class="fas fa-sign-in-alt me-2"></i>Order Now
      </a>
      <a href="user/registration.jsp" class="btn btn-custom btn-outline-custom">
        <i class="fas fa-user-plus me-2"></i>Join Us
      </a>
    </div>
  </div>
</section>

<!-- Features Section -->
<section id="features" class="features-section">
  <div class="container">
    <div class="row text-center mb-5">
      <div class="col-12">
        <h2 class="display-4 fw-bold text-dark mb-3">Why Choose FoodHub?</h2>
        <p class="lead text-muted">Experience the best food delivery service</p>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-4 col-md-6">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-clock"></i>
          </div>
          <h4>Fast Delivery</h4>
          <p class="text-muted">Get your food delivered within 30 minutes or it's free!</p>
        </div>
      </div>
      <div class="col-lg-4 col-md-6">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-star"></i>
          </div>
          <h4>Quality Food</h4>
          <p class="text-muted">Fresh ingredients and delicious meals from top restaurants</p>
        </div>
      </div>
      <div class="col-lg-4 col-md-6">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-mobile-alt"></i>
          </div>
          <h4>Easy Ordering</h4>
          <p class="text-muted">Simple and intuitive ordering process</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>