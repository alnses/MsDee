<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar">
    <div class="logo">
        <h1>Ms. Dee</h1>
        <p>E-Commerce System</p>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/pages/shop.jsp">Shop</a>
        <a href="${pageContext.request.contextPath}/pages/promotions.jsp">Promotions</a>
        
        <a href="${pageContext.request.contextPath}/pages/profile.jsp">
            👤 ${not empty sessionScope.fullName ? sessionScope.fullName : 'Profile'}
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn">
            🛒 Cart <span class="cart-count">0</span>
        </a>
    </div>
</nav>