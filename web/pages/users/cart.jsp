<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=70">
</head>
<body>

<jsp:include page="../../partials/header.jsp"/>

<div class="cart-container">
    <h1>Shopping Cart</h1>

    <div id="cartItems" class="cart-items"></div>

    <div class="cart-summary">
        <h2>Order Summary</h2>

        <div class="summary-row">
            <span>Total Items</span>
            <strong id="totalItems">0</strong>
        </div>

        <div class="summary-row">
            <span>Total Price</span>
            <strong id="totalPrice">RM 0.00</strong>
        </div>

        <form id="checkoutForm"
              action="${pageContext.request.contextPath}/checkout"
              method="post">

            <input type="hidden" name="totalAmount" id="totalAmountInput">
            <input type="hidden" name="cartData" id="cartDataInput">

            <button type="submit" class="checkout-btn">
                Pay with ToyyibPay
            </button>
        </form>

        <button class="clear-cart-btn" onclick="clearCart()">Clear Cart</button>
    </div>
</div>

<div id="toast" class="toast"></div>

<script>
    function loadCart() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        const cartItems = document.getElementById("cartItems");

        cartItems.innerHTML = "";

        if (cart.length === 0) {
            cartItems.innerHTML = `
                <div class="empty-cart">
                    <h2>Your cart is empty</h2>
                    <p>Add some products from the shop page.</p>
                    <a href="${pageContext.request.contextPath}/pages/users/shop.jsp">Go to Shop</a>
                </div>
            `;

            updateSummary();
            updateCartCount();
            return;
        }

        cart.forEach((item, index) => {
            cartItems.innerHTML += `
                <div class="cart-card">
                    <div class="cart-product-img">
                        <img src="\${item.image}" alt="\${item.name}">
                    </div>

                    <div class="cart-product-info">
                        <h3>\${item.name}</h3>
                        <p>RM \${Number(item.price).toFixed(2)}</p>
                    </div>

                    <div class="quantity-control">
                        <button type="button" onclick="decreaseQty(\${index})">-</button>
                        <span>\${item.quantity}</span>
                        <button type="button" onclick="increaseQty(\${index})">+</button>
                    </div>

                    <div class="cart-item-total">
                        RM \${(Number(item.price) * Number(item.quantity)).toFixed(2)}
                    </div>

                    <button type="button" class="remove-btn" onclick="removeItem(\${index})">
                        Remove
                    </button>
                </div>
            `;
        });

        updateSummary();
        updateCartCount();
    }

    function increaseQty(index) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        cart[index].quantity += 1;
        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
    }

    function decreaseQty(index) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        if (cart[index].quantity > 1) {
            cart[index].quantity -= 1;
        } else {
            cart.splice(index, 1);
        }

        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
    }

    function removeItem(index) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        cart.splice(index, 1);
        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
        showToast("Item removed from cart");
    }

    function clearCart() {
        localStorage.removeItem("cart");
        loadCart();
        showToast("Cart cleared");
    }

    function updateSummary() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        let totalItems = cart.reduce((total, item) => total + Number(item.quantity), 0);
        let totalPrice = cart.reduce((total, item) => total + (Number(item.price) * Number(item.quantity)), 0);

        document.getElementById("totalItems").innerText = totalItems;
        document.getElementById("totalPrice").innerText = "RM " + totalPrice.toFixed(2);

        document.getElementById("totalAmountInput").value = totalPrice.toFixed(2);
        document.getElementById("cartDataInput").value = JSON.stringify(cart);
    }

    function updateCartCount() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        let totalItems = cart.reduce((total, item) => total + Number(item.quantity), 0);

        const count = document.querySelector(".cart-count");
        if (count) {
            count.innerText = totalItems;
        }
    }

    document.getElementById("checkoutForm").addEventListener("submit", function (e) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        if (cart.length === 0) {
            e.preventDefault();
            showToast("Your cart is empty");
        }
    });

    function showToast(message) {
        const t = document.getElementById("toast");
        t.innerText = message;
        t.style.display = "block";

        setTimeout(() => {
            t.style.display = "none";
        }, 2500);
    }

    loadCart();
</script>

</body>
</html>