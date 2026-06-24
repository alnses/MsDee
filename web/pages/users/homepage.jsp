<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home | Ms. Dee</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css?v=11">

    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <!-- HERO SLIDESHOW -->
        <section class="home-hero">

            <div class="hero-slide active">
                <div class="home-hero-content">

                    <span class="hero-badge">🔥 <strong>LIMITED TIME OFFER</strong></span>

                    <h1>Mid-Year Mega Sale<br>Up To 30% OFF</h1>

                    <p>
                        Save more on selected home appliances and enjoy
                        exclusive member discounts.
                    </p>

                    <a href="${pageContext.request.contextPath}/pages/users/promotions.jsp"
                       class="shop-now-btn">
                        View Promotions →
                    </a>

                </div>
            </div>
            <div class="hero-slide">
                <div class="home-hero-content">
                    <h1>Quality Home Appliances<br>for Modern Living</h1>

                    <p>
                        Discover the best selection of kitchen,
                        cleaning, and home comfort appliances
                    </p>

                    <a href="${pageContext.request.contextPath}/products"
                       class="shop-now-btn">
                        Shop Now →
                    </a>
                </div>
            </div>

            <div class="hero-slide">
                <div class="home-hero-content">
                    <h1>Kitchen Essentials<br>For Every Home</h1>

                    <p>
                        Cook smarter with our premium kitchen
                        appliance collection
                    </p>

                    <a href="${pageContext.request.contextPath}/products?category=Kitchen"
                       class="shop-now-btn">
                        Explore Kitchen →
                    </a>
                </div>
            </div>

            <div class="hero-slide">
                <div class="home-hero-content">
                    <h1>Stay Cool<br>All Year Round</h1>

                    <p>
                        Discover cooling and comfort appliances
                        at unbeatable prices
                    </p>

                    <a href="${pageContext.request.contextPath}/products?category=Cooling"
                       class="shop-now-btn">
                        View Cooling →
                    </a>
                </div>
            </div>

            <div class="hero-dots">
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>

        </section>

        <!-- CATEGORY SECTION -->
        <section class="home-section">

            <h2>Shop by Category</h2>

            <div class="category-grid">

                <a href="${pageContext.request.contextPath}/products?category=Kitchen"
                   class="category-card">
                    🍳
                    <h3>Kitchen</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Cleaning"
                   class="category-card">
                    🧹
                    <h3>Cleaning</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Cooling"
                   class="category-card">
                    ❄️
                    <h3>Cooling</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Heating"
                   class="category-card">
                    🔥
                    <h3>Heating</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Laundry"
                   class="category-card">
                    🧺
                    <h3>Laundry</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Electrical"
                   class="category-card">
                    🔌
                    <h3>Electrical</h3>
                </a>

            </div>

        </section>

        <!-- PROMOTION -->
        <section class="promo-banner">

            <h2>Special Promotions</h2>

            <p>
                Up to 30% OFF on selected home appliances
            </p>

            <a href="${pageContext.request.contextPath}/pages/users/promotions.jsp"
               class="promo-btn">
                View All Deals
            </a>

        </section>

        <jsp:include page="../../partials/footer.jsp"/>

        <!-- SLIDESHOW SCRIPT -->
        <script>

            const slides = document.querySelectorAll(".hero-slide");
            const dots = document.querySelectorAll(".dot");

            let currentSlide = 0;

            function showSlide(index) {

                slides.forEach(slide => {
                    slide.classList.remove("active");
                });

                dots.forEach(dot => {
                    dot.classList.remove("active");
                });

                slides[index].classList.add("active");
                dots[index].classList.add("active");
            }

            setInterval(() => {

                currentSlide++;

                if (currentSlide >= slides.length) {
                    currentSlide = 0;
                }

                showSlide(currentSlide);

            }, 5000);

            dots.forEach((dot, index) => {

                dot.addEventListener("click", () => {

                    currentSlide = index;
                    showSlide(index);

                });

            });

        </script>

    </body>
</html>