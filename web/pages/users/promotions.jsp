<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Promotions | Ms. Dee</title>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css?v=15">
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>



        <div class="promo-container">

            <!-- HERO BANNER -->
            <div class="promo-hero">

                <span class="promo-tag">
                    🔥 LIMITED TIME OFFER
                </span>

                <h1>Mid-Year Mega Sale</h1>

                <p>
                    Enjoy up to 40% OFF on selected home appliances.
                    Free delivery on orders above RM200.
                </p>

                <a href="#promoProducts" class="promo-hero-btn">
                    Shop Deals →
                </a>

            </div>

            <!-- STATS -->
            <div class="promo-stats">

                <div class="stat-card">
                    <h2>40%</h2>
                    <p>Maximum Discount</p>
                </div>

                <div class="stat-card">
                    <h2>4</h2>
                    <p>Featured Deals</p>
                </div>

                <div class="stat-card">
                    <h2>RM200</h2>
                    <p>Free Delivery</p>
                </div>

            </div>

            <!-- TITLE -->
            <div class="promo-header" id="promoProducts">

                <h2>Featured Promotion Deals</h2>

                <p>
                    Grab these special offers before they are gone.
                </p>

            </div>

            <!-- PRODUCTS -->
            <div class="promo-grid">

                <!-- Rice Cooker -->
                <div class="promo-card">

                    <div class="discount-badge">-40%</div>

                    <img class="promo-image"
                         src="${pageContext.request.contextPath}/assets/images/ricecooker.png"
                         alt="Rice Cooker">

                    <h3>Rice Cooker</h3>

                    <span class="category-label">Kitchen</span>

                    <div class="price-box">
                        <span class="old-price">RM 119.90</span>
                        <span class="promo-price">RM 71.92</span>
                    </div>

                    <button class="promo-btn"
                            onclick="addToCart('Rice Cooker', 71.92, '${pageContext.request.contextPath}/assets/images/ricecooker.png')">

                        Add to Cart

                    </button>

                </div>

                <!-- Blender -->
                <div class="promo-card">

                    <div class="discount-badge">-15%</div>

                    <img class="promo-image"
                         src="${pageContext.request.contextPath}/assets/images/blender.png"
                         alt="Blender">

                    <h3>Blender</h3>

                    <span class="category-label">Kitchen</span>

                    <div class="price-box">
                        <span class="old-price">RM 129.90</span>
                        <span class="promo-price">RM 110.42</span>
                    </div>

                    <button class="promo-btn"
                            onclick="addToCart('Blender', 110.42, '${pageContext.request.contextPath}/assets/images/blender.png')">

                        Add to Cart

                    </button>

                </div>

                <!-- Air Cooler -->
                <div class="promo-card">

                    <div class="discount-badge">-20%</div>

                    <img class="promo-image"
                         src="${pageContext.request.contextPath}/assets/images/aircooler.png"
                         alt="Air Cooler">

                    <h3>Air Cooler</h3>

                    <span class="category-label">Cooling</span>

                    <div class="price-box">
                        <span class="old-price">RM 189.90</span>
                        <span class="promo-price">RM 151.92</span>
                    </div>

                    <button class="promo-btn"
                            onclick="addToCart('Air Cooler', 151.92, '${pageContext.request.contextPath}/assets/images/aircooler.png')">

                        Add to Cart

                    </button>

                </div>

                <!-- Air Fryer -->
                <div class="promo-card">

                    <div class="discount-badge">-25%</div>

                    <img class="promo-image"
                         src="${pageContext.request.contextPath}/assets/images/airfryer.png"
                         alt="Air Fryer">

                    <h3>Air Fryer</h3>

                    <span class="category-label">Kitchen</span>

                    <div class="price-box">
                        <span class="old-price">RM 399.90</span>
                        <span class="promo-price">RM 299.90</span>
                    </div>

                    <button class="promo-btn"
                            onclick="addToCart('Air Fryer', 299.90, '${pageContext.request.contextPath}/assets/images/airfryer.png')">

                        Add to Cart

                    </button>

                </div>

            </div>

            <!-- BENEFITS -->

            <div class="promo-benefits">

                <div class="benefit-card">

                    <div class="benefit-icon">🚚</div>

                    <h3>Free Delivery</h3>

                    <p>Orders above RM200</p>

                </div>

                <div class="benefit-card">

                    <div class="benefit-icon">🔒</div>

                    <h3>Secure Payment</h3>

                    <p>Safe and protected checkout</p>

                </div>

                <div class="benefit-card">

                    <div class="benefit-icon">⭐</div>

                    <h3>Quality Products</h3>

                    <p>Trusted home appliances</p>

                </div>

            </div>

        </div>

        <div id="toast" class="toast"></div>

        <script>

            function addToCart(name, price, image) {

                let cart = JSON.parse(localStorage.getItem("cart")) || [];
                let existingItem = cart.find(item => item.name === name);
                if (existingItem) {

                    existingItem.quantity += 1;
                } else {

                    cart.push({
                        name: name,
                        price: Number(price),
                        image: image,
                        quantity: 1,
                        selected: true
                    });
                }

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartCount();
                showToast(name + " added to cart!");
            }

            function updateCartCount() {

                let cart = JSON.parse(localStorage.getItem("cart")) || [];
                let totalQty = cart.reduce((sum, item) => {

                    return sum + (parseInt(item.quantity) || 0);
                }, 0);
                const counter = document.querySelector(".cart-count");
                if (counter) {
                    counter.innerText = totalQty;
                }
            }

            function showToast(message) {

                const toast = document.getElementById("toast");
                toast.innerText = message;
                toast.style.display = "block";
                toast.style.opacity = "1";
                setTimeout(() => {

                    toast.style.opacity = "0";
                    setTimeout(() => {

                        toast.style.display = "none";
                    }, 300);
                }, 2200);
            }

            updateCartCount();

        </script>
        <jsp:include page="../../partials/footer.jsp"/>
    </body>
</html>