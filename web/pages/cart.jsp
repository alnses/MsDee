<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | Ms. Dee</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body style="background-color: #f5f7fb;">

    <!-- NAVBAR -->
    <jsp:include page="../partials/header.jsp"/>

    <!-- CART SECTION -->
    <div class="container py-5">

        <h2 class="fw-bold mb-4">🛒 Shopping Cart</h2>

        <div class="row g-4">

            <!-- LEFT SIDE -->
            <div class="col-lg-8">

                <!-- CART ITEMS -->
                <div id="cartContainer">

                    <!-- Empty Cart Message -->
                    <div id="emptyCartMessage"
                         class="card border-0 shadow-sm rounded-4 p-5 text-center">

                        <h4 class="fw-bold mb-3">
                            Your cart is empty
                        </h4>

                        <p class="text-muted">
                            Add some products before checkout.
                        </p>

                    </div>

                </div>

            </div>

            <!-- RIGHT SIDE -->
            <div class="col-lg-4">

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body">

                        <h4 class="fw-bold mb-4">
                            Order Summary
                        </h4>

                        <!-- SUBTOTAL -->
                        <div class="d-flex justify-content-between mb-3">
                            <span>Subtotal</span>

                            <span class="fw-bold" id="subtotal">
                                RM 0.00
                            </span>
                        </div>

                        <!-- SHIPPING -->
                        <div class="d-flex justify-content-between mb-3">
                            <span>Shipping</span>

                            <span class="fw-bold" id="shipping">
                                RM 10.00
                            </span>
                        </div>

                        <hr>

                        <!-- TOTAL -->
                        <div class="d-flex justify-content-between mb-4">
                            <h5 class="fw-bold">Total</h5>

                            <h5 class="fw-bold text-danger" id="total">
                                RM 0.00
                            </h5>
                        </div>

                        <!-- VOUCHER -->
                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                Voucher Code
                            </label>

                            <div class="input-group">

                                <input type="text"
                                       id="voucherInput"
                                       class="form-control"
                                       placeholder="Enter voucher code">

                                <button class="btn btn-dark"
                                        type="button"
                                        onclick="applyVoucher()">

                                    Apply

                                </button>

                            </div>

                            <small id="voucherMessage"
                                   class="text-success fw-semibold">
                            </small>

                        </div>

                        <!-- CHECKOUT BUTTON -->
                        <button class="btn btn-success w-100 py-2 fw-bold"
                                id="checkoutBtn"
                                disabled
                                data-bs-toggle="modal"
                                data-bs-target="#checkoutModal">

                            Proceed to Checkout

                        </button>

                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- =========================================
         CHECKOUT MODAL
    ========================================= -->
    <div class="modal fade" id="checkoutModal" tabindex="-1">

        <div class="modal-dialog modal-dialog-centered modal-lg">

            <div class="modal-content checkout-modal">

                <div class="modal-header border-0 pb-0">

                    <h2 class="checkout-title">
                        Checkout
                    </h2>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal">
                    </button>

                </div>

                <div class="modal-body checkout-body">

                    <form action="PurchaseServlet" method="post">

                        <h5 class="section-title">
                            Shipping Address
                        </h5>

                        <div class="mb-3">

                            <label class="form-label">
                                Full Name
                            </label>

                            <input type="text"
                                   class="form-control custom-input"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">
                                Address
                            </label>

                            <textarea class="form-control custom-input"
                                      rows="3"
                                      required></textarea>

                        </div>

                        <div class="mb-4">

                            <label class="form-label">
                                Phone Number
                            </label>

                            <input type="text"
                                   class="form-control custom-input"
                                   required>

                        </div>

                        <h5 class="section-title">
                            Shipping Method
                        </h5>

                        <div class="shipping-box">

                            <label class="shipping-option">

                                <input type="radio"
                                       name="shipping"
                                       checked>

                                <div>

                                    <strong>
                                        Standard Delivery (3-5 days)
                                    </strong>

                                    <p>RM 8.00</p>

                                </div>

                            </label>

                            <label class="shipping-option">

                                <input type="radio"
                                       name="shipping">

                                <div>

                                    <strong>
                                        Express Delivery (1-2 days)
                                    </strong>

                                    <p>RM 15.00</p>

                                </div>

                            </label>

                        </div>

                        <h5 class="section-title mt-4">
                            Payment Method
                        </h5>

                        <label class="payment-option active-payment">

                            <input type="radio"
                                   name="payment"
                                   checked>

                            <span>
                                🏦 Online Banking
                            </span>

                        </label>

                        <div class="bank-section">

                            <label class="bank-label">
                                Select Your Bank
                            </label>

                            <select class="form-select custom-select">

                                <option>
                                    Choose a bank...
                                </option>

                                <option>
                                    Maybank
                                </option>

                                <option>
                                    CIMB
                                </option>

                                <option>
                                    RHB
                                </option>

                            </select>

                        </div>

                        <label class="payment-option">

                            <input type="radio"
                                   name="payment">

                            <span>
                                📱 QR Pay / E-Wallet
                            </span>

                        </label>

                        <div class="checkout-buttons">

                            <button type="button"
                                    class="btn cancel-btn"
                                    data-bs-dismiss="modal">

                                Cancel

                            </button>

                            <button type="submit"
                                    class="btn placeorder-btn">

                                Place Order

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- CART SCRIPT -->
    <script>

        let cart = [];

        let shippingFee = 10;
        let discount = 0;

        renderCart();

        function renderCart() {

            const container =
                document.getElementById("cartContainer");

            container.innerHTML = "";

            if (cart.length === 0) {

                container.innerHTML = `
                    <div class="card border-0 shadow-sm rounded-4 p-5 text-center">

                        <h4 class="fw-bold mb-3">
                            Your cart is empty
                        </h4>

                        <p class="text-muted">
                            Add some products before checkout.
                        </p>

                    </div>
                `;

                updateSummary();
                return;
            }

            cart.forEach((item, index) => {

                container.innerHTML += `

                <div class="card border-0 shadow-sm rounded-4 mb-4">

                    <div class="card-body">

                        <div class="row align-items-center">

                            <!-- CHECKBOX -->
                            <div class="col-md-1 text-center">

                                <input type="checkbox"
                                       class="form-check-input fs-4"
                                       ${item.checked ? "checked" : ""}
                                       onchange="toggleItem(${index})">

                            </div>

                            <!-- IMAGE -->
                            <div class="col-md-2 text-center">

                                <img src="${item.image}"
                                     class="img-fluid"
                                     style="max-height: 120px; object-fit: contain;">

                            </div>

                            <!-- DETAILS -->
                            <div class="col-md-5">

                                <h5 class="fw-bold">
                                    ${item.name}
                                </h5>

                                <span class="fw-bold text-danger fs-5">
                                    RM ${item.price.toFixed(2)}
                                </span>

                            </div>

                            <!-- QUANTITY -->
                            <div class="col-md-4">

                                <div class="d-flex justify-content-center align-items-center">

                                    <button class="btn btn-outline-secondary"
                                            onclick="decreaseQty(${index})">

                                        -

                                    </button>

                                    <span class="mx-3 fw-bold fs-5">
                                        ${item.quantity}
                                    </span>

                                    <button class="btn btn-outline-secondary"
                                            onclick="increaseQty(${index})">

                                        +

                                    </button>

                                </div>

                                <div class="text-center mt-3">

                                    <button class="btn btn-sm btn-danger"
                                            onclick="removeItem(${index})">

                                        Remove

                                    </button>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                `;
            });

            updateSummary();
        }

        function toggleItem(index) {

            cart[index].checked =
                !cart[index].checked;

            updateSummary();
        }

        function increaseQty(index) {

            cart[index].quantity++;
            renderCart();
        }

        function decreaseQty(index) {

            if (cart[index].quantity > 1) {
                cart[index].quantity--;
            }

            renderCart();
        }

        function removeItem(index) {

            cart.splice(index, 1);
            renderCart();
        }

        function updateSummary() {

            let subtotal = 0;

            cart.forEach(item => {

                if (item.checked) {

                    subtotal +=
                        item.price * item.quantity;
                }

            });

            let total =
                subtotal + shippingFee - discount;

            if (subtotal === 0) {
                total = 0;
            }

            document.getElementById("subtotal").innerText =
                "RM " + subtotal.toFixed(2);

            document.getElementById("total").innerText =
                "RM " + total.toFixed(2);

            document.getElementById("checkoutBtn").disabled =
                subtotal === 0;
        }

        function applyVoucher() {

            const code =
                document.getElementById("voucherInput")
                .value
                .trim()
                .toUpperCase();

            const message =
                document.getElementById("voucherMessage");

            discount = 0;
            shippingFee = 10;

            document.getElementById("shipping").innerText =
                "RM " + shippingFee.toFixed(2);

            message.classList.remove("text-danger");
            message.classList.add("text-success");

            if (code === "SAVE10") {

                discount = 10;

                message.innerHTML =
                    "Voucher applied! RM10 discount.";

            }
            else if (code === "FREESHIP") {

                shippingFee = 0;

                document.getElementById("shipping").innerText =
                    "RM 0.00";

                message.innerHTML =
                    "Free shipping applied!";
            }
            else {

                message.innerHTML =
                    "Invalid voucher code.";

                message.classList.remove("text-success");
                message.classList.add("text-danger");
            }

            updateSummary();
        }

    </script>

</body>
</html>