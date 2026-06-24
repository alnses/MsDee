<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.dao.UserDAO" %>
<%@ page import="com.project.model.User" %>
<%@ page import="com.project.dao.AddressDAO" %>
<%@ page import="com.project.model.Address" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("userId").toString());

    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(userId);

    AddressDAO addressDAO = new AddressDAO();
    Address primaryAddress = addressDAO.getPrimaryAddress(userId);

    String membershipTier = "Bronze";
    int memberDiscount = 0;

    if (user != null) {
        membershipTier = user.getMembershipTier();
        memberDiscount = user.getDiscount();
    }

    String addressDisplay = "";

    if (primaryAddress != null) {

        addressDisplay
                = primaryAddress.getFullName()
                + "<br>"
                + primaryAddress.getPhone()
                + "<br>"
                + primaryAddress.getAddressLine()
                + ", "
                + primaryAddress.getCity()
                + ", "
                + primaryAddress.getState()
                + " "
                + primaryAddress.getPostcode();

    } else {

        addressDisplay
                = "No primary address selected.<br>"
                + "Please add an address first.";

    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cart | Ms. Dee</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css?v=62">
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="cart-container">

            <h1>Shopping Cart</h1>

            <div class="checkout-section">
                <h3>Shipping Address</h3>

                <div class="address-display">
                    <p id="addressText">
                        <%= addressDisplay%>
                    </p>

                    <a href="${pageContext.request.contextPath}/addresses"
                       class="small-btn">
                        Manage Addresses
                    </a>
                </div>
            </div>

            <div class="cart-select-actions" id="cartSelectActions">
                <label>
                    <input type="checkbox" id="selectAllCart" onchange="toggleSelectAll(this)">
                    Select all items
                </label>
            </div>

            <div id="cartItems" class="cart-items"></div>
            <br> 
            <div class="checkout-section membership-box">
                <h3>Membership Discount</h3>

                <p>
                    Current Tier:
                    <strong><%= membershipTier%></strong>
                </p>

                <p>
                    Discount:
                    <strong><%= memberDiscount%>%</strong>
                </p>
            </div>
            <div class="checkout-section">
                <h3>Payment Method</h3>

                <select id="paymentMethod" class="payment-select">
                    <option value="ToyyibPay">ToyyibPay Online Banking</option>
                    <option value="FPX">FPX Transfer</option>
                    <option value="Credit Card">Credit Card</option>
                </select>
            </div>

            <div class="cart-summary">

                <h3>Cart Summary</h3>

                <div class="summary-row">
                    <span>Subtotal</span>
                    <span id="subtotalAmount">RM 0.00</span>
                </div>

                <div class="summary-row">
                    <span>Member Discount</span>
                    <span id="discountAmount">RM 0.00</span>
                </div>

                <div class="summary-row total-row">
                    <span>Total</span>
                    <span id="cartTotal">RM 0.00</span>
                </div>

                <form action="${pageContext.request.contextPath}/checkout"
                      method="post"
                      onsubmit="return prepareCheckoutData()">

                    <input type="hidden"
                           name="addressText"
                           id="addressTextInput">
                    <input type="hidden"
                           name="paymentMethod"
                           id="paymentMethodInput">

                    <input type="hidden"
                           name="membershipTier"
                           value="<%= membershipTier%>">

                    <input type="hidden"
                           name="discountPercent"
                           value="<%= memberDiscount%>">

                    <input type="hidden"
                           name="originalAmount"
                           id="originalAmountInput">
                    <input type="hidden"
                           name="totalAmount"
                           id="totalAmountInput">

                    <input type="hidden"
                           name="cartData"
                           id="cartDataInput">

                    <button type="submit" class="main-btn" id="checkoutBtn">
                        Proceed To Checkout
                    </button>

                </form>

            </div>

        </div>

        <script>
            // 1. Capture the dynamic context path from Tomcat
            const contextPath = "${pageContext.request.contextPath}";

            function getCart() {

                let cart = JSON.parse(localStorage.getItem("cart")) || [];

                return cart.filter(item =>
                    item
                            && item.name
                            && !isNaN(parseFloat(item.price))
                            && !isNaN(parseInt(item.quantity))
                ).map(item => ({
                        name: item.name,
                        price: parseFloat(item.price),
                        // FIX: Maps 'imageUrl' from your backend CartItem model safely
                        image: item.imageUrl || item.image,
                        quantity: parseInt(item.quantity),
                        selected: item.selected !== false
                    }));
            }

            function saveCart(cart) {

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartCount(cart);
            }

            function updateCartCount(cart) {

                let totalItems = cart.reduce((total, item) => total + item.quantity, 0);
                let count = document.querySelector(".cart-count");

                if (count) {
                    count.innerText = totalItems;
                }
            }

            function loadCart() {

                let cart = getCart();
                let cartContainer = document.getElementById("cartItems");
                let selectActions = document.getElementById("cartSelectActions");
                let selectedTotal = 0;

                cartContainer.innerHTML = "";
                selectActions.style.display = cart.length > 0 ? "block" : "none";

                if (cart.length === 0) {

                    cartContainer.innerHTML =
                            "<div class='empty-cart'><h2>Your cart is empty.</h2><p>Add something from the shop to see it here.</p></div>";

                    saveCart(cart);
                    updateSummary(0, 0, 0);

                    return;
                }

                cart.forEach((item, index) => {

                    let subtotal = item.price * item.quantity;

                    if (item.selected) {
                        selectedTotal += subtotal;
                    }

                    // 2. Safely construct the full absolute path for your images
                    let correctedImageSrc = item.image || "";

                    if (correctedImageSrc && !correctedImageSrc.startsWith(contextPath) && !correctedImageSrc.startsWith("http")) {
                        let cleanImagePath = correctedImageSrc.startsWith("/") ? correctedImageSrc : "/" + correctedImageSrc;
                        correctedImageSrc = contextPath + cleanImagePath;
                    }

                    let productHTML = ""

                            + "<div class='cart-card" + (item.selected ? " selected" : "") + "'>"

                            + "<label class='cart-check'>"
                            + "<input type='checkbox' "
                            + (item.selected ? "checked" : "")
                            + " onchange='toggleItem(" + index + ", this.checked)'>"
                            + "</label>"

                            + "<div class='cart-product-img'>"
                            // Uses the dynamically built clean image url
                            + "<img src='" + correctedImageSrc + "' alt='" + item.name + "'>"
                            + "</div>"

                            + "<div class='cart-product-info'>"
                            + "<h3>" + item.name + "</h3>"
                            + "<p>RM " + item.price.toFixed(2) + "</p>"
                            + "</div>"

                            + "<div class='quantity-control'>"
                            + "<button type='button' onclick='changeQty(" + index + ", -1)' aria-label='Decrease quantity'>-</button>"
                            + "<span>" + item.quantity + "</span>"
                            + "<button type='button' onclick='changeQty(" + index + ", 1)' aria-label='Increase quantity'>+</button>"
                            + "</div>"

                            + "<div class='cart-item-total'>RM "
                            + subtotal.toFixed(2)
                            + "</div>"

                            + "<button type='button' onclick='removeItem(" + index + ")' class='remove-btn'>"
                            + "Remove"
                            + "</button>"

                            + "</div>";

                    cartContainer.innerHTML += productHTML;
                });

                saveCart(cart);
                updateSummary(selectedTotal, cart.length, cart.filter(item => item.selected).length);
            }

            function updateSummary(total, itemCount, selectedCount) {

                let discount = <%= memberDiscount%>;

                let discountAmount =
                        total * (discount / 100);

                let finalAmount =
                        total - discountAmount;

                document.getElementById("originalAmountInput").value =
                        total.toFixed(2);

                document.getElementById("totalAmountInput").value =
                        finalAmount.toFixed(2);

                document.getElementById("subtotalAmount").innerText =
                        "RM " + total.toFixed(2);

                document.getElementById("discountAmount").innerText =
                        "- RM " + discountAmount.toFixed(2);

                document.getElementById("cartTotal").innerText =
                        "RM " + finalAmount.toFixed(2);

                let checkoutBtn = document.getElementById("checkoutBtn");

                checkoutBtn.disabled = total <= 0;
                checkoutBtn.innerText = total > 0
                        ? "Proceed To Checkout"
                        : "Select Item To Checkout";

                let selectAll = document.getElementById("selectAllCart");

                selectAll.checked = itemCount > 0 && selectedCount === itemCount;
                selectAll.indeterminate = selectedCount > 0 && selectedCount < itemCount;
            }

            function toggleItem(index, checked) {

                let cart = getCart();

                cart[index].selected = checked;
                saveCart(cart);
                loadCart();
            }

            function toggleSelectAll(checkbox) {

                let cart = getCart();

                cart.forEach(item => {
                    item.selected = checkbox.checked;
                });

                saveCart(cart);
                loadCart();
            }

            function changeQty(index, change) {

                let cart = getCart();

                cart[index].quantity += change;

                if (cart[index].quantity <= 0) {
                    cart.splice(index, 1);
                }

                saveCart(cart);
                loadCart();
            }

            function removeItem(index) {

                let cart = getCart();

                cart.splice(index, 1);

                saveCart(cart);
                loadCart();
            }

            function prepareCheckoutData() {

                let cart = getCart();
                let selectedCart = cart.filter(item => item.selected);

                if (selectedCart.length === 0) {
                    return false;
                }

                document.getElementById("cartDataInput").value =
                        JSON.stringify(selectedCart);

                localStorage.setItem(
                        "checkoutItems",
                        JSON.stringify(selectedCart)
                        );

                document.getElementById("paymentMethodInput").value =
                        document.getElementById("paymentMethod").value;

                document.getElementById("addressTextInput").value =
                        document.getElementById("addressText").innerText;

                return true;
            }

            loadCart();

        </script>

=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shopping Cart | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=31">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .cart-layout {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
                display: flex;
                gap: 30px;
            }
            .cart-items-section {
                flex: 2;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.02);
            }
            .cart-summary-section {
                flex: 1;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.02);
                height: fit-content;
            }
            .cart-item-row {
                display: flex;
                align-items: center;
                gap: 20px;
                padding: 20px 0;
                border-bottom: 1px solid #edf2f7;
            }
            .cart-item-row:last-child {
                border-bottom: none;
            }
            .cart-item-img {
                width: 80px;
                height: 80px;
                object-fit: contain;
                background: #f7fafc;
                border-radius: 8px;
                padding: 5px;
            }
            .cart-item-details {
                flex: 1;
            }
            .cart-item-details h3 {
                font-size: 18px;
                color: #2d3748;
                margin-bottom: 5px;
            }
            .cart-item-details p {
                color: #a0aec0;
                font-size: 14px;
            }
            .cart-item-qty {
                font-weight: 600;
                color: #4a5568;
                background: #edf2f7;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 14px;
            }
            .cart-item-price {
                font-size: 18px;
                font-weight: 700;
                color: #ff4d6d;
                min-width: 100px;
                text-align: right;
            }
            .empty-cart-card {
                background: #fff;
                max-width: 1200px;
                margin: 40px auto;
                padding: 60px;
                text-align: center;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.02);
            }
            .btn-shop {
                background: #5850ec;
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                margin-top: 15px;
            }
            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
                font-size: 16px;
                color: #4a5568;
            }
            .summary-total {
                border-top: 2px dashed #e2e8f0;
                padding-top: 15px;
                font-weight: 700;
                font-size: 20px;
                color: #2d3748;
            }
            .btn-checkout {
                width: 100%;
                background: #5850ec;
                color: white;
                border: none;
                padding: 14px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 15px;
            }
            .btn-clear {
                width: 100%;
                background: #1a202c;
                color: white;
                border: none;
                padding: 14px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
            }
            .btn-action:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div style="max-width: 1200px; margin: 40px auto 0 auto; padding: 0 20px;">
            <h1 style="color: #1e1e2f;">Shopping Cart</h1>
        </div>

        <%
            // 1. Fetch backend Java session data items directly
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("sessionCart");

            int totalItemsCount = 0;
            double totalCartPrice = 0.0;

            if (cart != null && !cart.isEmpty()) {
                // Compute total counters for calculations
                for (Map<String, Object> item : cart) {
                    int qty = (Integer) item.get("quantity");
                    double price = (Double) item.get("price");
                    totalItemsCount += qty;
                    totalCartPrice += (price * qty);
                }
                // FIXED: Bad syntax tokens removed here seamlessly
        %>
        <div class="cart-layout">
            <div class="cart-items-section">
                <%
                    for (Map<String, Object> item : cart) {
                        String name = (String) item.get("name");
                        double price = (Double) item.get("price");
                        int qty = (Integer) item.get("quantity");
                        String img = (String) item.get("image");
                %>
                <div class="cart-item-row">
                    <img class="cart-item-img" src="<%= (img != null && !img.isEmpty()) ? img : request.getContextPath() + "/assets/images/placeholder.png"%>" alt="<%= name%>">
                    <div class="cart-item-details">
                        <h3><%= name%></h3>
                        <p>Premium Household Item</p>
                    </div>
                    <div class="cart-item-qty">Qty: <%= qty%></div>
                    <div class="cart-item-price">RM <%= String.format("%.2f", price * qty)%></div>
                </div>
                <%
                    }
                %>
            </div>

            <div class="cart-summary-section">
                <h2 style="margin-bottom: 20px; color: #2d3748; font-size: 22px;">Order Summary</h2>
                <div class="summary-row">
                    <span>Total Items</span>
                    <strong><%= totalItemsCount%></strong>
                </div>
                <div class="summary-row summary-total">
                    <span>Total Price</span>
                    <span style="color: #ff4d6d;">RM <%= String.format("%.2f", totalCartPrice)%></span>
                </div>

                <form action="${pageContext.request.contextPath}/pages/users/checkout.jsp" method="GET">
                    <button type="submit" class="btn-checkout btn-action">Proceed to checkout</button>
                </form>

                <form action="${pageContext.request.contextPath}/CheckoutController" method="GET">
                    <button type="submit" class="btn-checkout btn-action">Clear </button>
                </form>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="empty-cart-card">
            <h2 style="font-size: 28px; color: #2d3748; margin-bottom: 10px;">Your cart is empty</h2>
            <p style="color: #718096; margin-bottom: 20px;">Add some products from the shop page to get started.</p>
            <a href="${pageContext.request.contextPath}/pages/users/shop.jsp" class="btn-shop">Go to Shop</a>
        </div>
        <%
            }
        %>

>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
    </body>
</html>