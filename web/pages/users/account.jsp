<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 🔒 Protect page (must login)
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
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

<!-- Navbar -->
<jsp:include page="../../partials/header.jsp"/>

<div class="container">

    <!-- Header -->
    <div class="account-header">
        <div>
            <h1>My Account</h1>
            <p>Welcome back, <%= session.getAttribute("fullName") %>!</p>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="signout-btn">Sign Out</a>
    </div>

    <!-- Membership Card -->
    <div class="member-card">
        <p>Member Since <%= session.getAttribute("memberSince") %></p>
        <h2><%= session.getAttribute("fullName") %></h2>
        <p><%= session.getAttribute("email") %></p>

        <div class="member-tier">
            🏅
            <h4><%= session.getAttribute("membershipTier") %></h4>
        </div>

        <div class="member-stats">
            <div>
                <p>Total Spent</p>
                <h2>RM <%= session.getAttribute("totalSpent") %></h2>
            </div>

            <div>
                <p>Member Discount</p>
                <h2><%= session.getAttribute("discount") %>% OFF</h2>
            </div>
        </div>
    </div>

    <!-- Menu Cards -->
    <div class="grid">

        <!-- Profile -->
        <a href="${pageContext.request.contextPath}/pages/users/profile.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">👤</div>
                <h2>Profile</h2>
                <p>Manage your personal information</p>
            </div>
        </a>

        <!-- Orders -->
        <div class="card menu-card">
            <div class="icon">📦</div>
            <h2>My Orders</h2>
            <p>View order history and status</p>
        </div>

        <!-- Membership -->
        <a href="${pageContext.request.contextPath}/pages/users/membership.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">⭐</div>
                <h2>Membership</h2>
                <p>View benefits and upgrade</p>
            </div>
        </a>

        <!-- Addresses -->
        <div class="card menu-card">
            <div class="icon">📍</div>
            <h2>Addresses</h2>
            <p>Manage shipping addresses</p>
        </div>

    </div>

</div>

<!-- Footer -->
<jsp:include page="../../partials/footer.jsp"/>

</body>
</html>