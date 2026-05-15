<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar">
    <div class="logo">
        <h1>Ms. Dee</h1>
        <p>E-Commerce System</p>
    </div>
    <div class="nav-links">
<<<<<<< HEAD
        <a href="${pageContext.request.contextPath}/pages/users/homepage.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/pages/users/shop.jsp">Shop</a>
        <a href="#">Promotions</a>

        <%
            String name = (String) session.getAttribute("fullName");
            if (name != null) {
        %>
        <a href="${pageContext.request.contextPath}/pages/users/account.jsp">👤 <%= name%></a>
        <%
        } else {
        %>
        <a href="${pageContext.request.contextPath}/pages/users/login.jsp">Sign In</a>
        <%
            }
        %>

        <a href="${pageContext.request.contextPath}/pages/users/cart.jsp" class="cart-btn">🛒 Cart <span class="cart-count">0</span></a>
=======
        <a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/pages/shop.jsp">Shop</a>
        <a href="${pageContext.request.contextPath}/pages/promotions.jsp">Promotions</a>
        
        <a href="${pageContext.request.contextPath}/pages/profile.jsp">
            👤 ${not empty sessionScope.fullName ? sessionScope.fullName : 'Profile'}
        </a>
        
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn">
            🛒 Cart <span class="cart-count">0</span>
        </a>
>>>>>>> de1e052a0f22f813002f6d89cab149c67f9625f6
    </div>
</nav>