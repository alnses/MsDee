
﻿<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<nav class="navbar">
    <div class="logo">
        <h1>Ms. Dee</h1>
        <p>E-Commerce System</p>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/pages/users/homepage.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/pages/users/shop.jsp">Shop</a>
        <a href="${pageContext.request.contextPath}/pages/users/promotions.jsp">Promotions</a>

        <%
            String name = (String) session.getAttribute("fullName");
            Integer userId = (Integer) session.getAttribute("userId");
            int totalCartItems = 0;

            // Only compute a cart count if a real user session is active
            if (userId != null) {
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("sessionCart");
                if (cart != null) {
                    for (Map<String, Object> item : cart) {
                        int qty = (Integer) item.get("quantity");
                        totalCartItems += qty;
                    }
                }
            }

            if (name != null) {
        %>
        <a href="${pageContext.request.contextPath}/pages/users/account.jsp" class="user-nav-link"><span class="user-nav-icon">&#128100;</span> <%= name%></a>
        <%
        } else {
        %>
        <a href="${pageContext.request.contextPath}/pages/users/login.jsp">Sign In</a>
        <%
            }
        %>

        <a href="${pageContext.request.contextPath}/pages/users/cart.jsp" class="cart-btn">

            <span class="cart-count">0</span>

            🛒 Cart <span class="cart-count" id="headerCartCount"><%= totalCartItems%></span>

        </a>
    </div>
</nav>

<script>
    function refreshHeaderCartCount() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        let totalItems = cart.reduce((total, item) => total + (parseInt(item.quantity) || 0), 0);
        let count = document.querySelector(".cart-count");

        if (count) {
            count.innerText = totalItems;
        }
    }



    refreshHeaderCartCount();
    window.addEventListener("storage", refreshHeaderCartCount);

    document.addEventListener("DOMContentLoaded", function () {
        const userIdActive = <%= (userId != null) ? "true" : "false"%>;
        if (!userIdActive) {
            localStorage.removeItem("cart");
            const badge = document.getElementById("headerCartCount");
            if (badge) {
                badge.innerText = "0";
            }
        }
    });
</script>


