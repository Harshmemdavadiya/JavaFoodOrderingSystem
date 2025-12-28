<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Food ordering system</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/animsition.min.css" rel="stylesheet" />
    <link href="../css/animate.css" rel="stylesheet" />
    <link href="home.css" rel="styesheet" />
    <link href="../css/style.css" rel="stylesheet" />

    <style>
        /* Remove default spacing */
        body, html {
            margin: 0;
            padding: 0;
        }
        header, .navbar, .header, #header {
            margin: 0 !important;
            padding: 0 !important;
            border: none !important;
        }

        /* Banner flush under header with increased height */
        .banner {
            width: 100%;
            height: 530px;               /* adjust to your screen, 450–550 is ideal */
            object-fit: cover;           /* fill without empty space */
            object-position: center top; /* show top part (so chef and burger stay visible) */
            display: block;
            margin: 0;
            padding: 0;
            border: none;
        }
        @media (max-width: 768px) {
            .banner {
                height: 300px;           /* smaller on mobile */
                object-position: center;
            }
        }


        /* ======= FOOD CARD STYLING ======= */
        .carousel-item .card {
            border: none;
            border-radius: 16px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .carousel-item .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }

        /* Image area */
        .card-img-top {
            display: block;
            width: 100%;
            height: 260px;                /* equal height for all */
            object-fit: contain;          /* show full image */
            background: #fafafa;          /* light background for images with transparency */
            padding: 8px;                 /* little breathing space around image */
            transition: transform 0.4s ease;
        }

        /* Hover zoom effect */
        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        /* Card text area */
        .card-body {
            text-align: center;
            padding: 15px 10px;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 8px;
        }

        .card-text {
            font-size: 0.95rem;
            color: #555;
        }

        /* ======= RESPONSIVE ======= */
        @media (max-width: 992px) {
            .card-img-top {
                height: 220px;
            }
        }

        @media (max-width: 576px) {
            .card-img-top {
                height: 180px;
            }
        }

        /* Carousel controls */
        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: rgba(0,0,0,0.6);
            border-radius: 50%;
            width: 40px;
            height: 40px;
        }

    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp"/>

<!-- Banner directly under header -->
<img src="../images/img/mainimg12.jpg" alt="Super Mart Banner" class="banner" />

<!-- Food Slider -->
<div class="container my-5">
    <h2 class="mb-4 text-center">Our Popular Foods</h2>
    <div id="foodCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
        <div class="carousel-inner">
            <!-- First Slide -->
            <div class="carousel-item active">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/pizza12.jpg" class="card-img-top" alt="Pizza">
                            <div class="card-body">
                                <h5 class="card-title">Pizza</h5>
                                <p class="card-text">Cheesy delight with fresh toppings.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/burger12.jpg" class="card-img-top" alt="Burger">
                            <div class="card-body">
                                <h5 class="card-title">Burger</h5>
                                <p class="card-text">Juicy burger with crispy fries.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/food3.jpg" class="card-img-top" alt="Pasta">
                            <div class="card-body">
                                <h5 class="card-title">khaman</h5>
                                <p class="card-text">luffy treat with zesty toppings.”</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Second Slide -->
            <div class="carousel-item">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/food7.jpg" class="card-img-top" alt="Salad">
                            <div class="card-body">
                                <h5 class="card-title">Noodles</h5>
                                <p class="card-text">Savory noodles with crisp veggies.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/dosa.jpg" class="card-img-top" alt="Sushi">
                            <div class="card-body">
                                <h5 class="card-title">Dosa</h5>
                                <p class="card-text">Crispy dosa with savory filling.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="../images/food/dessert.jpg" class="card-img-top" alt="Dessert">
                            <div class="card-body">
                                <h5 class="card-title">Dessert</h5>
                                <p class="card-text">Sweet treats to complete your meal.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#foodCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#foodCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</div>

<!-- How it works block -->
<section class="how-it-works">
    <div class="container">
        <div class="text-xs-center">
            <h2>Easy 3 Step Order</h2>
            <div class="row how-it-works-solution">
                <!-- Step 1 -->
                <div class="col-md-4 how-it-works-steps white-txt col1">
                    <div class="step step-1">
                        <div class="icon" data-step="1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewbox="0 0 380.721 380.721">
                                <g fill="#FFF">
                                    <path d="M58.727 281.236c.32-5.217.657-10.457 1.319-15.709 1.261-12.525 3.974-25.05 6.733-37.296a543.51 543.51 0 0 1 5.449-17.997c2.463-5.729 4.868-11.433 7.25-17.01 5.438-10.898 11.491-21.07 18.724-29.593 1.737-2.19 3.427-4.328 5.095-6.46 1.912-1.894 3.805-3.747 5.676-5.588 3.863-3.509 7.221-7.273 11.107-10.091 7.686-5.711 14.529-11.137 21.477-14.506 6.698-3.724 12.455-6.982 17.631-8.812 10.125-4.084 15.883-6.141 15.883-6.141s-4.915 3.893-13.502 10.207c-4.449 2.917-9.114 7.488-14.721 12.147-5.803 4.461-11.107 10.84-17.358 16.992-3.149 3.114-5.588 7.064-8.551 10.684-1.452 1.83-2.928 3.712-4.427 5.6a1225.858 1225.858 0 0 1-3.84 6.286c-5.537 8.208-9.673 17.858-13.995 27.664-1.748 5.1-3.566 10.283-5.391 15.534a371.593 371.593 0 0 1-4.16 16.476c-2.266 11.271-4.502 22.761-5.438 34.612-.68 4.287-1.022 8.633-1.383 12.979 94 .023 166.775.069 268.589.069.337-4.462.534-8.97.534-13.536 0-85.746-62.509-156.352-142.875-165.705 5.17-4.869 8.436-11.758 8.436-19.433-.023-14.692-11.921-26.612-26.631-26.612-14.715 0-26.652 11.92-26.652 26.642 0 7.668 3.265 14.558 8.464 19.426-80.396 9.353-142.869 79.96-142.869 165.706 0 4.543.168 9.027.5 13.467 9.935-.002 19.526-.002 28.926-.002zM0 291.135h380.721v33.59H0z" /> </g>
                            </svg>
                        </div>
                        <h3>Choose a Product</h3>
                        <p>We've got you covered with menus from over 345 delivery restaurants online.</p>
                    </div>
                </div>
                <!-- Step 2 -->
                <div class="col-md-4 how-it-works-steps white-txt col2">
                    <div class="step step-2">
                        <div class="icon" data-step="2">
                            <img width="80" height="80" src="https://img.icons8.com/ios-filled/50/FFFFFF/receive-change.png" alt="Payment"/>
                        </div>
                        <h3>Complete Payment</h3>
                        <p>Secure and easy online payments are available for all your orders.</p>
                    </div>
                </div>
                <!-- Step 3 -->
                <div class="col-md-4 how-it-works-steps white-txt col3">
                    <div class="step step-3">
                        <div class="icon" data-step="3">
                            <img width="80" height="80" src="https://img.icons8.com/ios-filled/50/FFFFFF/delivery.png" alt="Delivery"/>
                        </div>
                        <h3>Pick up or Delivery</h3>
                        <p>Get your food delivered! Enjoy your meal! Pay online on pickup or delivery.</p>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-sm-12 text-center">
                    <p class="pay-info">Pay by Cash on Delivery</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- App Section -->
<section class="app-section">
    <div class="app-wrap">
        <div class="container">
            <div class="row text-img-block text-xs-left">
                <div class="col-sm-5 right-image text-center">
                    <figure><img src="../images/app.png" alt="app"></figure>
                </div>
                <div class="col-sm-7 left-text">
                    <h3>The Best Super Market App</h3>
                    <p>Now you can make shopping happen wherever you are thanks to the free, easy-to-use Super Market App.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
     <div class="container">
        <div class="bottom-footer">
            <div class="row">
                <div class="col-sm-3 payment-options color-gray">
                    <h5>Payment Options</h5>
                    <img src="../images/paypal.jpg" height="53" alt="PayPal" />
                </div>
                <div class="col-sm-4 address color-gray">
                    <h5>Email</h5>
                    <p>info@foodordering.com</p>
                    <h5>Phone: <a href="tel:+919723898024">+91 9723898024</a></h5>
                </div>
                <div class="col-sm-5 additional-info color-gray">
                    <h5>Additional Information</h5>
                    <p>You can choose your favorite product in an easy and efficient way and enjoy your meal.</p>
                </div>
            </div>
        </div>
    </div>
</footer>


<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

</body>
</html>
