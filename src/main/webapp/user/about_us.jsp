<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
  session = request.getSession();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Delicious Food Ordering System - About Us</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome 5 for working social icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

  <!-- Bootstrap CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/animsition.min.css" rel="stylesheet">
  <link href="css/animate.css" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">

  <style>
    body, html {
      margin: 0;
      padding: 0;
    }

    .ptr {
      background-image: url('<%= request.getContextPath() %>/images/about_us_img.jpg');
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center center;
      min-height: 100vh;
    }

    .container {
      margin: 0 auto;
      max-width: 900px;
      text-align: center;
      padding: 30px 20px;
    }

    p {
      font-size: 1.1em;
      line-height: 1.6;
      margin-bottom: 20px;
      text-align: justify;
      color: white;
    }

    h2, h3 {
      color: white;
      margin-top: 20px;
      margin-bottom: 15px;
    }

    .ctr { padding: 20px; color: white; }
    .ctv { margin: 20px 100px; }

    @media (max-width: 768px) {
      .ctv { margin: 20px; }
    }

    /* Social Media Icons */
    .icon-bar {
      margin-top: 20px;
      text-align: center;
    }

    .icon-bar a {
      display: inline-block;
      margin: 5px;
      padding: 12px;
      border-radius: 50%;
      text-align: center;
      color: white;
      font-size: 24px;
      text-decoration: none;
      transition: 0.3s ease;
    }

    .icon-bar a.facebook { background: #3b5998; }
    .icon-bar a.twitter { background: #55acee; }
    .icon-bar a.google { background: #dd4b39; }
    .icon-bar a.youtube { background: #bb0000; }
    .icon-bar a:hover { opacity: 0.8; }
  </style>
</head>

<body class="ptr">

<!-- Header Include -->
<%@ include file="header.jsp" %>

<section class="section-team">
  <div class="container">
    <h2 class="ctr">About Us</h2>
    <p class="ctv">
      At Delicious Food, we're passionate about food and everything related to it. From creating delicious recipes to exploring different cuisines, we're always on the hunt for the next great meal. Our goal is to share our love of food with others and inspire them to try new things.
    </p>

    <p class="ctv">
      Our team of experienced chefs and food enthusiasts are always experimenting with new flavors and techniques to create exciting dishes that are sure to delight your taste buds. Whether you're a seasoned foodie or just starting to explore the world of food, we've got something for everyone.
    </p>

    <h3 class="ctr">Our Mission</h3>
    <p class="ctv">
      Our mission is to create a community of food lovers and inspire them to explore the world of food. We believe that food has the power to bring people together and create memorable experiences. Our goal is to share our passion for food with others and create a space where everyone can come together to celebrate their love of food.
    </p>

    <h3 class="ctr">Connect with Us</h3>
    <div class="icon-bar">
      <a href="https://www.facebook.com" target="_blank" class="facebook"><i class="fab fa-facebook-f"></i></a>
      <a href="https://twitter.com" target="_blank" class="twitter"><i class="fab fa-twitter"></i></a>
      <a href="https://www.google.com" target="_blank" class="google"><i class="fab fa-google"></i></a>
      <a href="https://www.youtube.com" target="_blank" class="youtube"><i class="fab fa-youtube"></i></a>
    </div>
  </div>
</section>

<!-- Footer Include -->
<%@ include file="footer.jsp" %>

</body>
</html>
