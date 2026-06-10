<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=31">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>


        <div class="shop-container">

            <aside class="shop-sidebar">
                <h2>Categories</h2>
                <button class="category-btn active" onclick="filterProducts('all', this)">All Products</button>
                <button class="category-btn" onclick="filterProducts('Kitchen', this)">🍳 Kitchen</button>
                <button class="category-btn" onclick="filterProducts('Cleaning', this)">🧹 Cleaning</button>
                <button class="category-btn" onclick="filterProducts('Cooling', this)">❄️ Cooling</button>
                <button class="category-btn" onclick="filterProducts('Heating', this)">🔥 Heating</button>
                <button class="category-btn" onclick="filterProducts('Laundry', this)">🧺 Laundry</button>
                <button class="category-btn" onclick="filterProducts('Electrical', this)">🔌 Electrical</button>
            </aside>

            <main class="shop-main">
                <div class="shop-header">
                    <h1>All Products</h1>

                    <div>
                        <label>Sort by:</label>
                        <select id="sortSelect" onchange="sortProducts()">
                            <option value="name">Name</option>
                            <option value="priceLow">Price: Low to High</option>
                        </select>
                    </div>
                </div>

                <div class="shop-product-list" id="productGrid">

                    <div class="shop-product-card" data-category="Cooling" data-name="Air Cooler" data-price="189.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/aircooler.png" alt="Air Cooler">
                        </div>
                        <h3>Air Cooler</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 189.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Blender" data-price="110.42" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/blender.png" alt="Blender">
                        </div>
                        <h3>Blender</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 110.42</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Rice Cooker" data-price="71.92" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/ricecooker.png" alt="Rice Cooker">
                        </div>
                        <h3>Rice Cooker</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 71.92</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Electric Kettle" data-price="49.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/electrickettle.png" alt="Electric Kettle">
                        </div>
                        <h3>Electric Kettle</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 49.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Air Fryer" data-price="199.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/airfryer.png" alt="Air Fryer">
                        </div>
                        <h3>Air Fryer</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 199.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Microwave Oven" data-price="249.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/microwave.png" alt="Microwave Oven">
                        </div>
                        <h3>Microwave Oven</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 249.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Bread Toaster" data-price="55.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/toaster.png" alt="Bread Toaster">
                        </div>
                        <h3>Bread Toaster</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 55.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cleaning" data-name="Vacuum Cleaner" data-price="159.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/vacuum.png" alt="Vacuum Cleaner">
                        </div>
                        <h3>Vacuum Cleaner</h3>
                        <p>Cleaning</p>
                        <div class="shop-card-footer">
                            <span>RM 159.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cleaning" data-name="Steam Mop" data-price="129.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/steammop.png" alt="Steam Mop">
                        </div>
                        <h3>Steam Mop</h3>
                        <p>Cleaning</p>
                        <div class="shop-card-footer">
                            <span>RM 129.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cooling" data-name="Table Fan" data-price="59.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/tablefan.png" alt="Table Fan">
                        </div>
                        <h3>Table Fan</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 59.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cooling" data-name="Stand Fan" data-price="89.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/standfan.png" alt="Stand Fan">
                        </div>
                        <h3>Stand Fan</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 89.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Heating" data-name="Steam Iron" data-price="69.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/iron.png" alt="Steam Iron">
                        </div>
                        <h3>Steam Iron</h3>
                        <p>Heating</p>
                        <div class="shop-card-footer">
                            <span>RM 69.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Laundry" data-name="Washing Machine" data-price="699.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/washingmachine.png" alt="Washing Machine">
                        </div>
                        <h3>Washing Machine</h3>
                        <p>Laundry</p>
                        <div class="shop-card-footer">
                            <span>RM 699.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Electrical" data-name="Extension Plug" data-price="29.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/extensionplug.png" alt="Extension Plug">
                        </div>
                        <h3>Extension Plug</h3>
                        <p>Electrical</p>
                        <div class="shop-card-footer">
                            <span>RM 29.90</span>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Electrical" data-name="LED Desk Lamp" data-price="39.90" onclick="viewProduct(this)" style="cursor: pointer;">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/desklamp.png" alt="LED Desk Lamp">
                        </div>
                        <h3>LED Desk Lamp</h3>
                        <p>Electrical</p>
                        <div class="shop-card-footer">
                            <span>RM 39.90</span>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <div id="toast" class="toast"></div>

        <script>
            // Redirects to detailed product page with parameters passed in URL string safely
            function viewProduct(card) {
                const name = encodeURIComponent(card.dataset.name);
                const price = encodeURIComponent(card.dataset.price);
                const category = encodeURIComponent(card.dataset.category);
                const image = encodeURIComponent(card.querySelector('img').src);
                
                window.location.href = "${pageContext.request.contextPath}/pages/users/productDetails.jsp?name=" + name + "&price=" + price + "&category=" + category + "&image=" + image;
            }

            function filterProducts(cat, btn) {
                document.querySelectorAll('.shop-product-card').forEach(card => {
                    card.style.display = (cat === 'all' || card.dataset.category === cat) ? 'block' : 'none';
                });

                document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');

                document.querySelector('.shop-header h1').innerText =
                        cat === 'all' ? 'All Products' : cat + ' Products';
            }

            function sortProducts() {
                const grid = document.getElementById('productGrid');
                const cards = Array.from(grid.children);
                const sortValue = document.getElementById('sortSelect').value;

                cards.sort((a, b) => {
                    if (sortValue === 'priceLow') {
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    }
                    return a.dataset.name.localeCompare(b.dataset.name);
                });

                cards.forEach(card => grid.appendChild(card));
            }

            function showToast(message) {
                const t = document.getElementById('toast');
                if (t) {
                    t.innerText = message;
                    t.style.display = 'block';
                    setTimeout(() => {
                        t.style.display = 'none';
                    }, 2500);
                }
            }

            // Checks the URL parameters on page load to see if an item was successfully added
            document.addEventListener("DOMContentLoaded", function() {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('added') === 'true') {
                    showToast("Item successfully added to cart!");
                    
                    // Clean up URL parameters so refreshing doesn't keep showing the toast message
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            });
        </script>

    </body>
</html>