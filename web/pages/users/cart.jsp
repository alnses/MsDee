<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Cart | Ms. Dee</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css?v=60">
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="cart-container">

            <h1>Shopping Cart</h1>

            <div id="cartItems"></div>

            <div class="cart-summary">

                <h3>Cart Summary</h3>

                <div class="summary-row">
                    <span>Total:</span>
                    <span id="cartTotal">RM 0.00</span>
                </div>

                <form action="${pageContext.request.contextPath}/checkout"
                      method="post"
                      onsubmit="prepareCheckoutData()">

                    <input type="hidden"
                           name="totalAmount"
                           id="totalAmountInput">

                    <input type="hidden"
                           name="cartData"
                           id="cartDataInput">

                    <button type="submit" class="main-btn">
                        Proceed To Checkout
                    </button>

                </form>

            </div>

        </div>

        <script>

            function loadCart() {

                let cart =
                        JSON.parse(localStorage.getItem("cart")) || [];

                let cartContainer =
                        document.getElementById("cartItems");

                let total = 0;

                cartContainer.innerHTML = "";

                if (cart.length === 0) {

                    cartContainer.innerHTML =
                            "<p>Your cart is empty.</p>";

                    document.getElementById("cartTotal").innerText =
                            "RM 0.00";

                    return;
                }

                cart.forEach((item, index) => {

                    let subtotal =
                            item.price * item.quantity;

                    total += subtotal;

                    let productHTML = ""

                            + "<div class='cart-item'>"

                            + "<img src='" + item.image + "' class='cart-image'>"

                            + "<div class='cart-details'>"

                            + "<h3>" + item.name + "</h3>"

                            + "<p>RM " + item.price.toFixed(2) + "</p>"

                            + "<div class='qty-controls'>"

                            + "<button onclick='changeQty(" + index + ", -1)'>-</button>"

                            + "<span>" + item.quantity + "</span>"

                            + "<button onclick='changeQty(" + index + ", 1)'>+</button>"

                            + "</div>"

                            + "<p>Subtotal: RM "
                            + subtotal.toFixed(2)
                            + "</p>"

                            + "<button onclick='removeItem(" + index + ")' class='remove-btn'>"

                            + "Remove"

                            + "</button>"

                            + "</div>"

                            + "</div>";

                    cartContainer.innerHTML += productHTML;
                });

                document.getElementById("cartTotal").innerText =
                        "RM " + total.toFixed(2);

                document.getElementById("totalAmountInput").value =
                        total.toFixed(2);
            }

            function changeQty(index, change) {

                let cart =
                        JSON.parse(localStorage.getItem("cart")) || [];

                cart[index].quantity += change;

                if (cart[index].quantity <= 0) {
                    cart.splice(index, 1);
                }

                localStorage.setItem(
                        "cart",
                        JSON.stringify(cart)
                );

                loadCart();
            }

            function removeItem(index) {

                let cart =
                        JSON.parse(localStorage.getItem("cart")) || [];

                cart.splice(index, 1);

                localStorage.setItem(
                        "cart",
                        JSON.stringify(cart)
                );

                loadCart();
            }

            function prepareCheckoutData() {

                let cart =
                        JSON.parse(localStorage.getItem("cart")) || [];

                document.getElementById("cartDataInput").value =
                        JSON.stringify(cart);
            }

            loadCart();

        </script>

    </body>
</html>