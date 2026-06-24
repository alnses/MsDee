<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=63">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>


        <div class="shop-container">

            <aside class="shop-sidebar">
                <h2>Categories</h2>
                <button class="category-btn active" onclick="filterProducts('all', this)">All Products</button>
                <button class="category-btn" onclick="filterProducts('Kitchen', this)">Kitchen</button>
                <button class="category-btn" onclick="filterProducts('Cleaning', this)">Cleaning</button>
                <button class="category-btn" onclick="filterProducts('Cooling', this)">Cooling</button>
                <button class="category-btn" onclick="filterProducts('Heating', this)">Heating</button>
                <button class="category-btn" onclick="filterProducts('Laundry', this)">Laundry</button>
                <button class="category-btn" onclick="filterProducts('Electrical', this)">Electrical</button>
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

                    <div class="shop-product-card" data-category="Cooling" data-name="Air Cooler" data-price="189.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/aircooler.png" alt="Air Cooler">
                        </div>
                        <h3>Air Cooler</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 189.90</span>
                            <button onclick="addToCart('Air Cooler', 189.90, '${pageContext.request.contextPath}/assets/images/aircooler.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Blender" data-price="110.42">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/blender.png" alt="Blender">
                        </div>
                        <h3>Blender</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 110.42</span>
                            <button onclick="addToCart('Blender', 110.42, '${pageContext.request.contextPath}/assets/images/blender.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Rice Cooker" data-price="71.92">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/ricecooker.png" alt="Rice Cooker">
                        </div>
                        <h3>Rice Cooker</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 71.92</span>
                            <button onclick="addToCart('Rice Cooker', 71.92, '${pageContext.request.contextPath}/assets/images/ricecooker.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Electric Kettle" data-price="49.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/electrickettle.png" alt="Electric Kettle">
                        </div>
                        <h3>Electric Kettle</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 49.90</span>
                            <button onclick="addToCart('Electric Kettle', 49.90, '${pageContext.request.contextPath}/assets/images/electrickettle.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Air Fryer" data-price="199.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/airfryer.png" alt="Air Fryer">
                        </div>
                        <h3>Air Fryer</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 199.90</span>
                            <button onclick="addToCart('Air Fryer', 199.90, '${pageContext.request.contextPath}/assets/images/airfryer.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Microwave Oven" data-price="249.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/microwave.png" alt="Microwave Oven">
                        </div>
                        <h3>Microwave Oven</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 249.90</span>
                            <button onclick="addToCart('Microwave Oven', 249.90, '${pageContext.request.contextPath}/assets/images/microwave.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Kitchen" data-name="Bread Toaster" data-price="55.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/breadtoaster.png" alt="Bread Toaster">
                        </div>
                        <h3>Bread Toaster</h3>
                        <p>Kitchen</p>
                        <div class="shop-card-footer">
                            <span>RM 55.90</span>
                            <button onclick="addToCart('Bread Toaster', 55.90, '${pageContext.request.contextPath}/assets/images/breadtoaster.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cleaning" data-name="Vacuum Cleaner" data-price="159.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/vacuum.png" alt="Vacuum Cleaner">
                        </div>
                        <h3>Vacuum Cleaner</h3>
                        <p>Cleaning</p>
                        <div class="shop-card-footer">
                            <span>RM 159.90</span>
                            <button onclick="addToCart('Vacuum Cleaner', 159.90, '${pageContext.request.contextPath}/assets/images/vacuum.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cleaning" data-name="Steam Mop" data-price="129.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/steammop.png" alt="Steam Mop">
                        </div>
                        <h3>Steam Mop</h3>
                        <p>Cleaning</p>
                        <div class="shop-card-footer">
                            <span>RM 129.90</span>
                            <button onclick="addToCart('Steam Mop', 129.90, '${pageContext.request.contextPath}/assets/images/steammop.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cooling" data-name="Table Fan" data-price="59.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/tablefan.png" alt="Table Fan">
                        </div>
                        <h3>Table Fan</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 59.90</span>
                            <button onclick="addToCart('Table Fan', 59.90, '${pageContext.request.contextPath}/assets/images/tablefan.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Cooling" data-name="Stand Fan" data-price="89.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/standfan.png" alt="Stand Fan">
                        </div>
                        <h3>Stand Fan</h3>
                        <p>Cooling</p>
                        <div class="shop-card-footer">
                            <span>RM 89.90</span>
                            <button onclick="addToCart('Stand Fan', 89.90, '${pageContext.request.contextPath}/assets/images/standfan.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Heating" data-name="Steam Iron" data-price="69.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/steamiron.png" alt="Steam Iron">
                        </div>
                        <h3>Steam Iron</h3>
                        <p>Heating</p>
                        <div class="shop-card-footer">
                            <span>RM 69.90</span>
                            <button onclick="addToCart('Steam Iron', 69.90, '${pageContext.request.contextPath}/assets/images/steamiron.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Laundry" data-name="Washing Machine" data-price="699.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/washingmachine.png" alt="Washing Machine">
                        </div>
                        <h3>Washing Machine</h3>
                        <p>Laundry</p>
                        <div class="shop-card-footer">
                            <span>RM 699.90</span>
                            <button onclick="addToCart('Washing Machine', 699.90, '${pageContext.request.contextPath}/assets/images/washingmachine.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Electrical" data-name="Extension Plug" data-price="29.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/extensionplug.png" alt="Extension Plug">
                        </div>
                        <h3>Extension Plug</h3>
                        <p>Electrical</p>
                        <div class="shop-card-footer">
                            <span>RM 29.90</span>
                            <button onclick="addToCart('Extension Plug', 29.90, '${pageContext.request.contextPath}/assets/images/extensionplug.png')">Add to Cart</button>
                        </div>
                    </div>

                    <div class="shop-product-card" data-category="Electrical" data-name="LED Desk Lamp" data-price="39.90">
                        <div class="shop-product-image">
                            <img src="${pageContext.request.contextPath}/assets/images/desklamp.png" alt="LED Desk Lamp">
                        </div>
                        <h3>LED Desk Lamp</h3>
                        <p>Electrical</p>
                        <div class="shop-card-footer">
                            <span>RM 39.90</span>
                            <button onclick="addToCart('LED Desk Lamp', 39.90, '${pageContext.request.contextPath}/assets/images/desklamp.png')">Add to Cart</button>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <div id="toast" class="toast"></div>
        <div id="quickViewModal" class="quick-view-overlay" onclick="closeQuickView(event)">
            <div class="quick-view-modal">
                <button type="button" class="quick-view-close" onclick="hideQuickView()">&times;</button>

                <div class="quick-view-image">
                    <img id="quickViewImage" src="" alt="">
                </div>

                <div class="quick-view-info">
                    <p class="quick-view-type" id="quickViewType"></p>
                    <h2 id="quickViewName"></h2>
                    <h3 id="quickViewPrice"></h3>
                    <p id="quickViewDescription"></p>

                    <div class="quick-view-specs">
                        <h4>Product Specification</h4>
                        <p id="quickViewSpecs"></p>
                    </div>

                    <div class="quick-view-actions">
                        <div class="quick-view-qty">
                            <button type="button" onclick="changeQuickViewQty(-1)">-</button>
                            <span id="quickViewQty">1</span>
                            <button type="button" onclick="changeQuickViewQty(1)">+</button>
                        </div>

                        <button type="button" class="quick-view-add" onclick="confirmQuickViewAdd()">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>
        </div>

                <script>
            const productDetails = {
                "Air Cooler": {
                    type: "Cooling Appliance",
                    model: "MSD-AC189 Portable Air Cooler",
                    description: "Portable air cooler for comfortable daily cooling in bedrooms, study rooms, and living areas.",
                    specs: "3-speed airflow, portable wheels, easy-fill water tank, energy-saving cooling mode."
                },
                "Blender": {
                    type: "Kitchen Appliance",
                    model: "MSD-BL110 Multi-Purpose Blender",
                    description: "Compact blender for smoothies, sauces, and quick kitchen preparation.",
                    specs: "Stainless steel blades, detachable jar, pulse control, easy-clean parts."
                },
                "Rice Cooker": {
                    type: "Kitchen Appliance",
                    model: "MSD-RC072 Daily Rice Cooker",
                    description: "Simple everyday rice cooker for small family meals and quick cooking.",
                    specs: "Cook and warm functions, non-stick inner pot, compact body, safety lid."
                },
                "Electric Kettle": {
                    type: "Kitchen Appliance",
                    model: "MSD-EK050 Fast Boil Kettle",
                    description: "Fast electric kettle for tea, coffee, and instant meals.",
                    specs: "Auto shut-off, heat-resistant handle, water level indicator, cordless serving."
                },
                "Air Fryer": {
                    type: "Kitchen Appliance",
                    model: "MSD-AF200 Compact Air Fryer",
                    description: "Air fryer for crispy meals with less oil and easy everyday cooking.",
                    specs: "Adjustable temperature, removable basket, timer control, non-stick tray."
                },
                "Microwave Oven": {
                    type: "Kitchen Appliance",
                    model: "MSD-MW250 Digital Microwave Oven",
                    description: "Convenient microwave oven for reheating, defrosting, and quick meals.",
                    specs: "Multiple power levels, timer control, defrost mode, easy-clean interior."
                },
                "Bread Toaster": {
                    type: "Kitchen Appliance",
                    model: "MSD-BT056 Two-Slice Toaster",
                    description: "Two-slice toaster for quick breakfasts and evenly toasted bread.",
                    specs: "Browning control, cancel function, crumb tray, compact countertop design."
                },
                "Vacuum Cleaner": {
                    type: "Cleaning Appliance",
                    model: "MSD-VC160 Home Vacuum Cleaner",
                    description: "Vacuum cleaner for everyday floor, carpet, and dust cleaning.",
                    specs: "Strong suction, washable filter, multi-surface nozzle, easy dust disposal."
                },
                "Steam Mop": {
                    type: "Cleaning Appliance",
                    model: "MSD-SM130 Floor Steam Mop",
                    description: "Steam mop for cleaner hard floors with less chemical use.",
                    specs: "Fast heat-up, reusable mop pad, swivel head, lightweight handle."
                },
                "Table Fan": {
                    type: "Cooling Appliance",
                    model: "MSD-TF060 Table Fan",
                    description: "Compact table fan for personal cooling at desks and small rooms.",
                    specs: "3 fan speeds, oscillation mode, stable base, adjustable tilt."
                },
                "Stand Fan": {
                    type: "Cooling Appliance",
                    model: "MSD-SF090 Adjustable Stand Fan",
                    description: "Adjustable stand fan for wider airflow around bedrooms and living rooms.",
                    specs: "Height adjustment, oscillation, 3-speed control, wide fan guard."
                },
                "Steam Iron": {
                    type: "Heating Appliance",
                    model: "MSD-SI070 Steam Iron",
                    description: "Steam iron for smoother clothes and quick wrinkle removal.",
                    specs: "Steam burst, non-stick soleplate, adjustable temperature, water spray."
                },
                "Washing Machine": {
                    type: "Laundry Appliance",
                    model: "MSD-WM700 Washing Machine",
                    description: "Washing machine for reliable daily laundry care at home.",
                    specs: "Multiple wash programs, large capacity drum, spin dry mode, water-saving cycle."
                },
                "Extension Plug": {
                    type: "Electrical Accessory",
                    model: "MSD-EP030 Extension Plug",
                    description: "Extension plug for safely powering multiple household devices.",
                    specs: "Multiple sockets, durable cable, safety switch, compact layout."
                },
                "LED Desk Lamp": {
                    type: "Electrical Appliance",
                    model: "MSD-DL040 LED Desk Lamp",
                    description: "LED desk lamp for study, work, and bedside lighting.",
                    specs: "Energy-saving LED, adjustable neck, stable base, soft light output."
                }
            };

            let quickViewProduct = null;
            let quickViewQuantity = 1;

            function filterProducts(cat, btn) {
                document.querySelectorAll('.shop-product-card').forEach(card => {
                    card.style.display = (cat === 'all' || card.dataset.category === cat) ? 'block' : 'none';
                });

                document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));

                if (btn) {
                    btn.classList.add('active');
                } else {
                    document.querySelectorAll('.category-btn').forEach(b => {
                        if ((cat === 'all' && b.textContent.includes('All Products')) || b.textContent.includes(cat)) {
                            b.classList.add('active');
                        }
                    });
                }

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

            function addToCart(name, price, image) {
                openQuickView(name, price, image);
            }

            function openQuickView(name, price, image) {
                const details = productDetails[name] || {
                    type: "Home Appliance",
                    model: "Ms. Dee Standard Model",
                    description: "Useful home appliance for everyday household needs.",
                    specs: "Practical design, easy to use, suitable for daily home use."
                };

                quickViewProduct = { name: name, price: price, image: image };
                quickViewQuantity = 1;

                document.getElementById('quickViewImage').src = image;
                document.getElementById('quickViewImage').alt = name;
                document.getElementById('quickViewType').innerText = details.type + ' | ' + details.model;
                document.getElementById('quickViewName').innerText = name;
                document.getElementById('quickViewPrice').innerText = 'RM ' + price.toFixed(2);
                document.getElementById('quickViewDescription').innerText = details.description;
                document.getElementById('quickViewSpecs').innerText = details.specs;
                document.getElementById('quickViewQty').innerText = quickViewQuantity;
                document.getElementById('quickViewModal').classList.add('show');
            }

            function hideQuickView() {
                document.getElementById('quickViewModal').classList.remove('show');
            }

            function closeQuickView(event) {
                if (event.target.id === 'quickViewModal') {
                    hideQuickView();
                }
            }

            function changeQuickViewQty(change) {
                quickViewQuantity += change;

                if (quickViewQuantity < 1) {
                    quickViewQuantity = 1;
                }

                document.getElementById('quickViewQty').innerText = quickViewQuantity;
            }

            function confirmQuickViewAdd() {
                if (!quickViewProduct) {
                    return;
                }

                addCartItem(
                        quickViewProduct.name,
                        quickViewProduct.price,
                        quickViewProduct.image,
                        quickViewQuantity
                );

                hideQuickView();
                showToast(quickViewProduct.name + ' added to cart!');
            }

            function addCartItem(name, price, image, quantity) {
                let cart = JSON.parse(localStorage.getItem("cart")) || [];
                let existingItem = cart.find(item => item.name === name);

                if (existingItem) {
                    existingItem.quantity += quantity;
                    existingItem.selected = true;
                } else {
                    cart.push({
                        name: name,
                        price: price,
                        image: image,
                        quantity: quantity,
                        selected: true
                    });
                }

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartCount();
            }

            function updateCartCount() {
                let cart = JSON.parse(localStorage.getItem("cart")) || [];
                let totalItems = cart.reduce((total, item) => total + (parseInt(item.quantity) || 0), 0);

                const count = document.querySelector(".cart-count");
                if (count) {
                    count.innerText = totalItems;
                }
            }

            function showToast(message) {
                const t = document.getElementById('toast');
                t.innerText = message;
                t.style.display = 'block';

                setTimeout(() => {
                    t.style.display = 'none';
                }, 2500);
            }

            function applyCategoryFromUrl() {
                const params = new URLSearchParams(window.location.search);
                const category = params.get('category');

                if (category) {
                    filterProducts(category, null);
                }
            }

            updateCartCount();
            applyCategoryFromUrl();
        </script>
        <jsp:include page="../../partials/footer.jsp"/>
    </body>
</html>
