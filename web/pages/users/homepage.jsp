
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
                <a href="${pageContext.request.contextPath}/products?category=all"
                    class="shop-now-btn">
                    Shop Now →
                </a>
            </div>
        </section>

        <section class="home-section">
            <h2>Shop by Category</h2>

            <div class="category-grid">
                <a href="${pageContext.request.contextPath}/products?category=Kitchen" class="category-card">
                    🍳<h3>Kitchen</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Cleaning" class="category-card">
                    🧹<h3>Cleaning</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Cooling" class="category-card">
                    ❄️<h3>Cooling</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Heating" class="category-card">
                    🔥<h3>Heating</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Laundry" class="category-card">
                    🧺<h3>Laundry</h3>
                </a>

                <a href="${pageContext.request.contextPath}/products?category=Electrical" class="category-card">
                    🔌<h3>Electrical</h3>
                </a>
            </div>
        </section>

        <section class="promo-banner">
            <h2>Special Promotions</h2>
            <p>Up to 30% OFF on selected home appliances</p>
            <a href="${pageContext.request.contextPath}/pages/users/promotions.jsp" class="promo-btn">View All Deals</a>
        </section>

        
        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>
