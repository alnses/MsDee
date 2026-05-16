<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.model.User" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }

    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Account | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<jsp:include page="../../partials/header.jsp"/>

<div class="container">

    <div class="account-header">
        <div>
            <h1>My Account</h1>
            <p>Welcome back, <%= user.getFullName() %>!</p>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="signout-btn">Sign Out</a>
    </div>

    <div class="member-card">
        <p>Member Since <%= user.getMemberSince() != null ? user.getMemberSince() : "New Member" %></p>

        <h2><%= user.getFullName() %></h2>
        <p><%= user.getEmail() %></p>

        <div class="member-tier">
            🏅
            <h4><%= user.getMembershipTier() != null ? user.getMembershipTier() : "Bronze" %></h4>
        </div>

        <div class="member-stats">
            <div>
                <p>Total Spent</p>
                <h2>RM <%= String.format("%.2f", user.getTotalSpent()) %></h2>
            </div>

            <div>
                <p>Member Discount</p>
                <h2><%= user.getDiscount() %>% OFF</h2>
            </div>
        </div>
    </div>

    <div class="grid">

        <a href="${pageContext.request.contextPath}/pages/users/profile.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">👤</div>
                <h2>Profile</h2>
                <p>Manage your personal information</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/pages/users/orders.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">📦</div>
                <h2>My Orders</h2>
                <p>View order history</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/pages/users/membership.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">⭐</div>
                <h2>Membership</h2>
                <p>View benefits and upgrade</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/addresses" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">📍</div>
                <h2>Addresses</h2>
                <p>Manage shipping addresses</p>
            </div>
        </a>

    </div>

</div>

<jsp:include page="../../partials/footer.jsp"/>

</body>
</html>