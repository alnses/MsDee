<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout | Ms. Dee</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

<jsp:include page="../../partials/header.jsp"/>

<div class="container mt-5 mb-5 text-center">

    <button class="btn btn-success px-5 py-3"
            data-bs-toggle="modal"
            data-bs-target="#checkoutModal">

        Proceed To Checkout

    </button>

</div>


<!-- ===========================
     CHECKOUT MODAL
============================ -->

<div class="modal fade"
     id="checkoutModal"
     tabindex="-1">

    <div class="modal-dialog modal-dialog-centered custom-checkout-modal">

        <div class="modal-content checkout-modal">

            <!-- HEADER -->

            <div class="modal-header border-0">

                <h3 class="checkout-title">
                    Checkout
                </h3>

                <button class="btn-close"
                        data-bs-dismiss="modal">
                </button>

            </div>


            <!-- BODY -->

            <div class="modal-body checkout-body">

                <!-- ERROR MESSAGE -->

                <%
                    String error = request.getParameter("error");

                    if ("toyyibpay_failed".equals(error)) {
                %>

                <div class="alert alert-danger">

                    Payment failed.
                    Please try again.

                </div>

                <%
                    }
                %>



                <!-- FORM -->

                <form action="${pageContext.request.contextPath}/checkout"
                      method="post">

                    <!-- SHIPPING ADDRESS -->

                    <h5 class="section-title">
                        Shipping Address
                    </h5>


                    <div class="mb-3">

                        <label>
                            Full Name
                        </label>

                        <input
                            type="text"
                            name="fullname"
                            class="form-control custom-input"
                            required>

                    </div>


                    <div class="mb-3">

                        <label>
                            Address
                        </label>

                        <textarea
                            name="address"
                            rows="3"
                            class="form-control custom-input"
                            required></textarea>

                    </div>


                    <div class="mb-4">

                        <label>
                            Phone Number
                        </label>

                        <input
                            type="text"
                            name="phone"
                            class="form-control custom-input"
                            required>

                    </div>



                    <!-- SHIPPING -->

                    <h5 class="section-title">

                        Shipping Method

                    </h5>


                    <div class="shipping-box">

                        <label class="shipping-option">

                            <input
                                type="radio"
                                name="shipping"
                                value="standard"
                                checked>

                            <div>

                                <strong>
                                    Standard Delivery
                                </strong>

                                <p>
                                    RM 8.00 (3-5 days)
                                </p>

                            </div>

                        </label>


                        <label class="shipping-option">

                            <input
                                type="radio"
                                name="shipping"
                                value="express">

                            <div>

                                <strong>
                                    Express Delivery
                                </strong>

                                <p>
                                    RM 15.00 (1-2 days)
                                </p>

                            </div>

                        </label>

                    </div>



                    <!-- PAYMENT -->

                    <h5 class="section-title mt-4">

                        Payment Method

                    </h5>


                    <label class="payment-option active-payment">

                        <input
                            type="radio"
                            name="payment"
                            value="toyyibpay"
                            checked>

                        <div>

                            <strong>
                                🏦 ToyyibPay Online Banking
                            </strong>

                            <p>

                                FPX / Online Banking /
                                E-wallet

                            </p>

                        </div>

                    </label>



                    <!-- ORDER SUMMARY -->

                    <div class="mt-4">

                        <h5 class="section-title">

                            Order Summary

                        </h5>

                        <div class="summary-box">

                            <p>
                                Products:
                                <strong>
                                    From Cart
                                </strong>
                            </p>

                            <p>
                                Payment:
                                <strong>
                                    ToyyibPay
                                </strong>
                            </p>

                        </div>

                    </div>



                    <!-- BUTTONS -->

                    <div class="checkout-buttons mt-4">

                        <button
                            type="button"
                            class="btn cancel-btn"
                            data-bs-dismiss="modal">

                            Cancel

                        </button>


                        <button
                            type="submit"
                            class="btn placeorder-btn">

                            Pay with ToyyibPay

                        </button>

                    </div>


                </form>

            </div>

        </div>

    </div>

</div>



<jsp:include page="../../partials/footer.jsp"/>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>