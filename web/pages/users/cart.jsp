<%@ page contentType="text/html;charset=UTF-8" %>

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

            <div class="cart-select-actions" id="cartSelectActions">
                <label>
                    <input type="checkbox" id="selectAllCart" onchange="toggleSelectAll(this)">
                    Select all items
                </label>
            </div>

            <div id="cartItems" class="cart-items"></div>

            <div class="cart-summary">

                <h3>Cart Summary</h3>

                <div class="summary-row">
                    <span>Selected total:</span>
                    <span id="cartTotal">RM 0.00</span>
                </div>

                <form action="${pageContext.request.contextPath}/checkout"
                      method="post"
                      onsubmit="return prepareCheckoutData()">

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

                document.getElementById("cartTotal").innerText =
                        "RM " + total.toFixed(2);

                document.getElementById("totalAmountInput").value =
                        total.toFixed(2);

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

                return true;
            }

            loadCart();

        </script>

    </body>
</html>