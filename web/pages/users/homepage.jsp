<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=10">
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <section class="home-hero">
            <div class="home-hero-content">
                <h1>Quality Home Appliances<br>for Modern Living</h1>
                <p>Discover the best selection of kitchen, cleaning, and home comfort appliances</p>
                <a href="${pageContext.request.contextPath}/pages/users/shop.jsp" class="shop-now-btn">Shop Now →</a>
            </div>
        </section>

        <section class="home-section">
            <h2>Shop by Category</h2>

            <div class="category-grid">
                <div class="category-card">🍳<h3>Kitchen</h3></div>
                <div class="category-card">🧹<h3>Cleaning</h3></div>
                <div class="category-card">❄️<h3>Cooling</h3></div>
                <div class="category-card">🔥<h3>Heating</h3></div>
                <div class="category-card">🧺<h3>Laundry</h3></div>
                <div class="category-card">🔌<h3>Electrical</h3></div>
            </div>
        </section>

        <section class="promo-banner">
            <h2>Special Promotions</h2>
            <p>Up to 30% OFF on selected home appliances</p>
            <a href="#" class="promo-btn">View All Deals</a>
        </section>

        <section class="home-section">
            <h2>Featured Products</h2>

            <div class="product-grid">
                <div class="home-product-card">
                    <span class="discount">-40%</span>

                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/assets/images/ricecooker.png" alt="Rice Cooker">
                    </div>

                    <h3>Rice Cooker</h3>
                    <p>Kitchen</p>
                    <h4>RM 71.92</h4>
                    <button onclick="addToCart(
                                    'Rice Cooker',
                                    71.92,
                                    '${pageContext.request.contextPath}/assets/images/ricecooker.png'
                                    )">Add to Cart</button>
                </div>

                <div class="home-product-card">
                    <span class="discount">-15%</span>

                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/assets/images/blender.png" alt="Blender">
                    </div>

                    <h3>Blender</h3>
                    <p>Kitchen</p>
                    <h4>RM 110.42</h4>
                    <button onclick="addToCart(
                                    'Blender',
                                    110.42,
                                    '${pageContext.request.contextPath}/assets/images/blender.png'
                                    )">Add to Cart</button>
                </div>

                <div class="home-product-card">
                    <span class="discount">-20%</span>

                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/assets/images/aircooler.png" alt="Air Cooler">
                    </div>

                    <h3>Air Cooler</h3>
                    <p>Cooling</p>
                    <h4>RM 189.90</h4>
                    <button onclick="addToCart(
                                    'Air Cooler',
                                    189.90,
                                    '${pageContext.request.contextPath}/assets/images/aircooler.png'
                                    )">Add to Cart</button>
                </div>
            </div>
        </section>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>