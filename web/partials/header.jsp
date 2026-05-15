<%@ page contentType="text/html;charset=UTF-8" %>

<div class="navbar">
    <div class="logo">
        <h1>Ms. Dee</h1>
        <p>Home Appliances Specialist</p>
    </div>

    <div class="nav-links">
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
    </div>
</div>