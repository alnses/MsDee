<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% String sUser = (String) session.getAttribute("userName"); %>
<nav class="navbar">
    <div><h2>Ms. Dee</h2></div>
    <div class="nav-links">
        <a href="homepage.jsp">Home</a>
        <a href="shop.jsp">Shop</a>
        <a href="promotions.jsp">Promotions</a>
        <% if (sUser != null) { %>
            <a href="account.jsp" class="user-profile-nav"><i class="fas fa-user-circle"></i> <%= sUser %></a>
        <% } else { %>
            <a href="login.jsp">Sign In</a>
        <% } %>
        <button class="add-btn" onclick="location.href='cart.jsp'"><i class="fas fa-shopping-cart"></i> Cart</button>
    </div>
</nav>