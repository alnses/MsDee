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

    </body>
</html>