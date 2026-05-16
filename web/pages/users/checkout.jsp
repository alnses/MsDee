<%-- 
    Document   : checkout
    Created on : 14 May 2026, 10:42:12 pm
    Author     : user
--%>

<%-- purchase.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Your CSS -->
    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>

<!-- OPEN BUTTON -->
<div class="container mt-5 text-center">
    <button class="btn btn-success px-4" data-bs-toggle="modal" data-bs-target="#checkoutModal">
        Open Checkout
    </button>
</div>

<!-- CHECKOUT MODAL -->
<div class="modal fade" id="checkoutModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered custom-checkout-modal">
        <div class="modal-content checkout-modal">

            <!-- HEADER -->
            <div class="modal-header border-0 pb-0">
                <h3 class="checkout-title">Checkout</h3>

                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- BODY -->
            <div class="modal-body checkout-body">

                <!-- SHIPPING ADDRESS -->
                <h5 class="section-title">Shipping Address</h5>

                <form action="PurchaseServlet" method="post">

                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control custom-input" name="fullname" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <textarea class="form-control custom-input" rows="3" name="address" required></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Phone Number</label>
                        <input type="text" class="form-control custom-input" name="phone" required>
                    </div>

                    <!-- SHIPPING METHOD -->
                    <h5 class="section-title">Shipping Method</h5>
                    <div class="shipping-box">
                        <label class="shipping-option">
                            <input type="radio" name="shipping" value="standard" checked>
                            <div>
                                <strong>Standard Delivery (3-5 days)</strong>
                                <p>RM 8.00</p>
                            </div>
                        </label>

                        <label class="shipping-option">
                            <input type="radio" name="shipping" value="express">
                            <div>
                                <strong>Express Delivery (1-2 days)</strong>
                                <p>RM 15.00</p>
                            </div>
                        </label>
                    </div>

                    <!-- PAYMENT METHOD -->
                    <h5 class="section-title mt-4">Payment Method</h5>

                    <!-- ONLINE BANKING -->
                    <label class="payment-option active-payment">
                        <input type="radio" name="payment" value="banking" checked>

                        <div>
                            <span><strong>🏦 Online Banking</strong></span>
                        </div>
                    </label>

                    <div class="bank-section">
                        <label class="bank-label">Select Your Bank</label>

                        <select class="form-select custom-select" name="bank">
                            <option>Choose a bank...</option>
                            <option>Maybank</option>
                            <option>CIMB Bank</option>
                            <option>Bank Islam</option>
                            <option>RHB Bank</option>
                            <option>Public Bank</option>
                        </select>
                    </div>

                    <!-- QR -->
                    <label class="payment-option">
                        <input type="radio" name="payment" value="qr">

                        <div>
                            <span><strong>📱 QR Pay / E-Wallet</strong></span>
                        </div>
                    </label>

                    <!-- FOOTER BUTTONS -->
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

</body>
</html>