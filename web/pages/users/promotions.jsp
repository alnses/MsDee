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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

        <style>
            .promo-container {
                width: 90%;
                max-width: 1200px;
                margin: 50px auto;
            }

            .promo-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 25px;
                margin-top: 40px;
            }

            .promo-card {
                background: white;
                padding: 25px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
                text-align: center;
                position: relative;
                transition: 0.3s;
            }

            .promo-card:hover {
                transform: translateY(-5px);
            }

            .discount-badge {
                position: absolute;
                top: 15px;
                right: 15px;
                background: #ff584d;
                color: white;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 800;
                font-size: 13px;
                box-shadow: 0 4px 10px rgba(255, 88, 77, 0.3);
            }

            .promo-image {
                width: 150px;
                height: 150px;
                object-fit: contain;
                margin-bottom: 15px;
            }

            .promo-card h3 {
                font-size: 20px;
                font-weight: 700;
                margin-bottom: 5px;
                color: #19172b;
            }

            .category-label {
                color: #6b7280;
                font-size: 13px;
                margin-bottom: 12px;
                display: block;
            }

            .promo-price {
                font-size: 20px;
                font-weight: 800;
                color: #19172b;
                margin-bottom: 15px;
                display: block;
            }

            .promo-btn {
                background: #6579f2;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 12px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                transition: 0.3s;
            }

            .promo-btn:hover {
                background: #5468e2;
            }
        </style>
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="promo-container">
            <h1 style="text-align: center; font-size: 32px; font-weight: 800;">Special Promotions</h1>
            <p style="text-align: center; color: #6b7280;">Up to 30% OFF on selected home appliances</p>

            <div class="promo-grid">

                <div class="promo-card">
                    <div class="discount-badge">-40%</div>
                    <img class="promo-image" src="${pageContext.request.contextPath}/assets/images/ricecooker.png" alt="Rice Cooker">
                    <h3>Rice Cooker</h3>
                    <span class="category-label">Kitchen</span>
                    <span class="promo-price">RM 71.92</span>
                    <button class="promo-btn" onclick="addToCart('Rice Cooker', 71.92, '${pageContext.request.contextPath}/assets/images/ricecooker.png')">
                        Add to Cart
                    </button>
                </div>

                <div class="promo-card">
                    <div class="discount-badge">-15%</div>
                    <img class="promo-image" src="${pageContext.request.contextPath}/assets/images/blender.png" alt="Blender">
                    <h3>Blender</h3>
                    <span class="category-label">Kitchen</span>
                    <span class="promo-price">RM 110.42</span>
                    <button class="promo-btn" onclick="addToCart('Blender', 110.42, '${pageContext.request.contextPath}/assets/images/blender.png')">
                        Add to Cart
                    </button>
                </div>

                <div class="promo-card">
                    <div class="discount-badge">-20%</div>
                    <img class="promo-image" src="${pageContext.request.contextPath}/assets/images/aircooler.png" alt="Air Cooler">
                    <h3>Air Cooler</h3>
                    <span class="category-label">Cooling</span>
                    <span class="promo-price">RM 151.92</span>
                    <button class="promo-btn" onclick="addToCart('Air Cooler', 151.92, '${pageContext.request.contextPath}/assets/images/aircooler.png')">
                        Add to Cart
                    </button>
                </div>

            </div>
        </div>

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
                        quantity: 1
                    });
                }

                localStorage.setItem("cart", JSON.stringify(cart));

                const counter = document.querySelector(".cart-count");
                if (counter) {
                    let totalQty = cart.reduce((sum, item) => sum + item.quantity, 0);
                    counter.innerText = totalQty;
                }

                alert(name + " added to cart!");
            }
        </script>

    </body>
</html>