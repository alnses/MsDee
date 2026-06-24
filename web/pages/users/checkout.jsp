<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.project.model.CartItem" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Checkout | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=31">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .checkout-container { max-width: 1000px; margin: 40px auto; padding: 20px; background: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.02); }
            .payment-methods { margin-bottom: 30px; }
            .method-option { border: 1px solid #e2e8f0; padding: 15px; border-radius: 8px; margin-bottom: 10px; display: flex; align-items: center; gap: 15px; cursor: pointer; }
            .order-summary-box { background: #f7fafc; padding: 20px; border-radius: 8px; margin-top: 20px; }
            .summary-item { display: flex; justify-content: space-between; padding: 10px 0; font-size: 16px; border-bottom: 1px solid #edf2f7; }
            .summary-item:last-child { border-bottom: none; }
            .total-row { font-size: 18px; font-weight: 700; color: #2d3748; padding-top: 15px; }
            .btn-group { display: flex; gap: 15px; margin-top: 25px; }
            .btn-back { background: #718096; color: white; padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; font-weight: 600; }
            .btn-order { background: #047857; color: white; padding: 12px 35px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; }
            .checkout-item-preview { display: flex; justify-content: space-between; color: #4a5568; font-size: 15px; margin-bottom: 5px; }
        </style>
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="checkout-container">
            <h1 style="color: #1e1e2f; margin-bottom: 25px;">Checkout</h1>

            <form action="${pageContext.request.contextPath}/PlaceOrderController" method="POST">
                
                <div class="payment-methods">
                    <h3>Select Payment Method</h3>
                    <div class="method-option">
                        <input type="radio" name="paymentMethod" value="Online Banking" checked id="bank">
                        <label Skinner for="bank">🌐 Toyyibpay Online Banking <br><small style="color: #718096;">FPX / Bank / E-wallet</small></label>
                    </div>
                    <div class="method-option">
                        <input type="radio" name="paymentMethod" value="COD" id="cod">
                        <label for="cod">💵 Cash On Delivery <br><small style="color: #718096;">Pay when item arrives</small></label>
                    </div>
                    <div class="method-option">
                        <input type="radio" name="paymentMethod" value="QR" id="qr">
                        <label for="qr">📱 QR Payment <br><small style="color: #718096;">DuitNow / TNG / MAE</small></label>
                    </div>
                </div>

                <%
                    // 1. Determine checkout flow type status attributes
                    Boolean isSingle = (Boolean) request.getAttribute("isSingleProductCheckout");
                    
                    int totalQuantity = 0;
                    double subtotal = 0.0;
                    double shippingFee = 8.00; // Fixed flat rate template fee in RM

                    if (isSingle != null && isSingle) {
                        // Flow A: Single direct "Buy Now" product item
                        String name = (String) request.getAttribute("checkoutName");
                        Double price = (Double) request.getAttribute("checkoutPrice");
                        totalQuantity = 1;
                        subtotal = (price != null) ? price : 0.0;
                %>
                    <div class="order-summary-box">
                        <h3>Order Summary</h3>
                        <div style="padding: 10px 0; border-bottom: 1px solid #e2e8f0;">
                            <div class="checkout-item-preview">
                                <span>Item: <strong><%= name %></strong></span>
                                <span>Qty: 1</span>
                            </div>
                        </div>
                <%
                    } else {
                        // Flow B: Loading full multi-item database cart collection rows
                        List<CartItem> items = (List<CartItem>) request.getAttribute("checkoutItems");
                        Double totalObj = (Double) request.getAttribute("checkoutSubtotal");
                        subtotal = (totalObj != null) ? totalObj : 0.0;
                %>
                    <div class="order-summary-box">
                        <h3>Order Summary</h3>
                        <div style="padding: 10px 0; border-bottom: 1px solid #e2e8f0;">
                            <% 
                                if (items != null) {
                                    for (CartItem item : items) {
                                        totalQuantity += item.getQuantity();
                            %>
                                        <div class="checkout-item-preview">
                                            <span><%= item.getProductName() != null ? item.getProductName() : "Premium Item" %> (x<%= item.getQuantity() %>)</span>
                                            <span>RM <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
                                        </div>
                            <% 
                                    }
                                } 
                            %>
                        </div>
                <%
                    }
                    
                    // Fallback control if subtotal returns nothing to display safely
                    if (subtotal == 0.0) {
                        shippingFee = 0.0;
                    }
                    double grandTotal = subtotal + shippingFee;
                %>

                    <div class="summary-item">
                        <span>Total Items count</span>
                        <strong><%= totalQuantity %></strong>
                    </div>
                    <div class="summary-item">
                        <span>Subtotal</span>
                        <strong>RM <%= String.format("%.2f", subtotal) %></strong>
                    </div>
                    <div class="summary-item">
                        <span>Shipping Fee</span>
                        <strong>RM <%= String.format("%.2f", shippingFee) %></strong>
                    </div>
                    <div class="summary-item total-row">
                        <span>Grand Total</span>
                        <span style="color: #ff4d6d;">RM <%= String.format("%.2f", grandTotal) %></span>
                    </div>
                </div>

                <input type="hidden" name="orderSubtotal" value="<%= subtotal %>">
                <input type="hidden" name="orderTotal" value="<%= grandTotal %>">

                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/CartController" class="btn-back">Back</a>
                    <button type="submit" class="btn-order">Place Order</button>
                </div>
            </form>
        </div>

    </body>
</html>