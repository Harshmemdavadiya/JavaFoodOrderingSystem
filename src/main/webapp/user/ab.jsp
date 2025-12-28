<!-- Bootstrap & Swiper CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<style>
    /* Slider Section */
    .food-slider {
        padding: 60px 0;
        background: linear-gradient(135deg, #fff8f2, #ffe6e6);
    }
    .food-slider h2 {
        font-weight: 800;
        color: #ff5722;
        text-align: center;
        margin-bottom: 40px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* Food Cards */
    .food-card {
        background: #fff;
        border-radius: 18px;
        box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .food-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 12px 35px rgba(0, 0, 0, 0.18);
    }
    .food-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-bottom: 3px solid #ff5722;
    }
    .food-card-body {
        padding: 18px;
        text-align: center;
    }
    .food-card-body h5 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #333;
    }
    .food-card-body p {
        font-size: 0.95rem;
        color: #666;
        margin-bottom: 12px;
    }
    .food-price {
        font-weight: 800;
        color: #ff5722;
        font-size: 1.3rem;
    }

    /* Buttons */
    .food-btn {
        display: inline-block;
        margin-top: 12px;
        padding: 8px 18px;
        font-size: 0.95rem;
        font-weight: 600;
        border-radius: 25px;
        border: none;
        color: #fff;
        background: linear-gradient(90deg, #ff5722, #ff9800);
        box-shadow: 0 3px 12px rgba(255, 87, 34, 0.4);
        transition: all 0.3s ease;
        cursor: pointer;
    }
    .food-btn:hover {
        background: linear-gradient(90deg, #ff9800, #ff5722);
        transform: scale(1.05);
    }

    /* Swiper navigation */
    .swiper-button-next,
    .swiper-button-prev {
        color: #ff5722;
        font-weight: bold;
        transition: color 0.3s ease;
    }
    .swiper-button-next:hover,
    .swiper-button-prev:hover {
        color: #ff9800;
    }
</style>

<!-- Card Slider -->
<div class="food-slider container">
    <h2>🍕 Popular Dishes</h2>
    <div class="swiper mySwiper">
        <div class="swiper-wrapper">

            <!-- Card 1 -->
            <div class="swiper-slide">
                <div class="food-card">
                    <img src="images/pizza.jpg" alt="Pizza">
                    <div class="food-card-body">
                        <h5>Cheese Pizza</h5>
                        <p>Hot & fresh with extra cheese</p>
                        <div class="food-price">₹299</div>
                        <button class="food-btn">Order Now</button>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="swiper-slide">
                <div class="food-card">
                    <img src="images/burger.jpg" alt="Burger">
                    <div class="food-card-body">
                        <h5>Veggie Burger</h5>
                        <p>Loaded with fresh veggies</p>
                        <div class="food-price">₹199</div>
                        <button class="food-btn">Order Now</button>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="swiper-slide">
                <div class="food-card">
                    <img src="images/pasta.jpg" alt="Pasta">
                    <div class="food-card-body">
                        <h5>Italian Pasta</h5>
                        <p>Creamy white sauce pasta</p>
                        <div class="food-price">₹249</div>
                        <button class="food-btn">Order Now</button>
                    </div>
                </div>
            </div>

            <!-- Card 4 -->
            <div class="swiper-slide">
                <div class="food-card">
                    <img src="images/biryani.jpg" alt="Biryani">
                    <div class="food-card-body">
                        <h5>Hyderabadi Biryani</h5>
                        <p>Spicy & flavorful rice</p>
                        <div class="food-price">₹349</div>
                        <button class="food-btn">Order Now</button>
                    </div>
                </div>
            </div>

            <!-- Card 5 -->
            <div class="swiper-slide">
                <div class="food-card">
                    <img src="images/momos.jpg" alt="Momos">
                    <div class="food-card-body">
                        <h5>Steamed Momos</h5>
                        <p>Served with spicy chutney</p>
                        <div class="food-price">₹149</div>
                        <button class="food-btn">Order Now</button>
                    </div>
                </div>
            </div>

        </div>
        <!-- Swiper Buttons -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>
</div>

<!-- Swiper & Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    var swiper = new Swiper(".mySwiper", {
        slidesPerView: 3,
        spaceBetween: 25,
        loop: true,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            0: { slidesPerView: 1 },
            768: { slidesPerView: 2 },
            1024: { slidesPerView: 3 }
        }
    });
</script>
