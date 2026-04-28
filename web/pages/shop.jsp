<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - Ms. Dee</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="shop-container">
        <%@ include file="sidebar.jsp" %>
        <main class="product-area">
            <div class="shop-header">
                <h2>Products</h2>
                <select id="sortSelect" onchange="sortProducts()" style="padding:5px; border-radius:5px;">
                    <option value="name">Sort by Name</option>
                    <option value="priceLow">Price: Low to High</option>
                </select>
            </div>
            <div class="product-grid" id="productGrid">
                <div class="product-card" data-category="Cooling" data-name="Air Cooler" data-price="189.90">
                    <div class="product-img"><i class="fas fa-snowflake" style="color:skyblue"></i></div>
                    <h4>Air Cooler</h4>
                    <div class="card-footer">
                        <span class="price-text">RM 189.90</span>
                        <button class="add-btn" onclick="showToast('Air Cooler')">Add</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <div id="toast" class="toast"></div>
    <script>
        function filterProducts(cat) {
            document.querySelectorAll('.product-card').forEach(card => {
                card.style.display = (cat === 'all' || card.dataset.category === cat) ? 'block' : 'none';
            });
            document.querySelectorAll('.category-menu li').forEach(li => li.classList.remove('active'));
            event.currentTarget.classList.add('active');
        }
        function showToast(name) {
            const t = document.getElementById('toast');
            t.innerText = name + " added to cart!";
            t.style.display = 'block';
            setTimeout(() => t.style.display = 'none', 2500);
        }
    </script>
</body>
</html>