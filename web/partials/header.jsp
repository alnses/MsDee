<%@ page contentType="text/html;charset=UTF-8" %>

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

            if (name != null) {
        %>
            <a href="${pageContext.request.contextPath}/pages/users/account.jsp" class="user-nav-link"><span class="user-nav-icon">&#128100;</span> <%= name %></a>
        <%
            } else {
        %>
            <a href="${pageContext.request.contextPath}/pages/users/login.jsp">Sign In</a>
        <%
            }
        %>

        <a href="${pageContext.request.contextPath}/pages/users/cart.jsp" class="cart-btn">
             Cart <span class="cart-count">0</span>
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
</script>

