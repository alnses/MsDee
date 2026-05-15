<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<head>
    <title>Shop | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        .shop-container {
            display: flex;
            width: 90%;
            max-width: 1400px;
            margin: 40px auto;
            gap: 30px;
        }
        .shop-sidebar {
            width: 280px;
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            height: fit-content;
            flex-shrink: 0;
        }
        .category-btn {
            width: 100%;
            text-align: left;
            padding: 12px 18px;
            margin-bottom: 10px;
            border: 1px solid #f0f0f5;
            background: #fff;
            border-radius: 12px;
            font-weight: 600;
            color: #7c8193;
            cursor: pointer;
            transition: 0.3s;
        }
        .category-btn.active, .category-btn:hover {
            background: #6579f2;
            color: white !important;
        }
        .shop-content { flex-grow: 1; }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }
        .shop-card {
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
        }
        .price-tag { color: #6579f2; font-weight: bold; margin: 10px 0; }
    </style>
</head>
<body>

<jsp:include page="../partials/header.jsp"/>

<div class="shop-container">
    <aside class="shop-sidebar">
        <h3 style="margin-bottom: 20px;">Categories</h3>
        <button class="category-btn active">All Products</button>
        <button class="category-btn">🍳 Kitchen</button>
        <button class="category-btn">🧹 Cleaning</button>
        <button class="category-btn">❄️ Cooling</button>
        <button class="category-btn">🔥 Heating</button>
        <button class="category-btn">🧺 Laundry</button>
        <button class="category-btn">🔌 Electrical</button>
    </aside>

    <main class="shop-content">
        <h1 class="section-title">All Products</h1>
        <div class="product-grid">
            <div class="shop-card">
                <div style="font-size: 50px;">❄️</div>
                <h3>Air Cooler</h3>
                <p>Advanced Cooling</p>
                <h4 class="price-tag">RM 189.90</h4>
                <button class="main-btn" onclick="addToCart('Air Cooler', 189.90, '❄️')">Add to Cart</button>
            </div>
            
            <div class="shop-card">
                <div style="font-size: 50px;">🍳</div>
                <h3>Power Blender</h3>
                <p>Kitchen Essentials</p>
                <h4 class="price-tag">RM 110.42</h4>
                <button class="main-btn" onclick="addToCart('Blender', 110.42, '🍳')">Add to Cart</button>
            </div>
        </div>
    </main>
</div>

<script>
    function addToCart(name, price, icon) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        cart.push({ name: name, price: price, icon: icon });
        localStorage.setItem("cart", JSON.stringify(cart));
        
        // Update cart UI if element exists
        const counter = document.querySelector(".cart-count");
        if(counter) counter.innerText = cart.length;
    }
</script>

</body>
</html>