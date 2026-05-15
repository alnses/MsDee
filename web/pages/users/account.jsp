<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // 🔒 SECURITY: Block users who are not logged in
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
    
    // Retrieve session data
    String name = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");
    String date = (String) session.getAttribute("memberSince");
    String tier = (String) session.getAttribute("membershipTier");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Account | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<<<<<<< HEAD:web/pages/users/account.jsp
<!-- Navbar -->
<jsp:include page="../../partials/header.jsp"/>
=======
<jsp:include page="../partials/header.jsp"/>
>>>>>>> de1e052a0f22f813002f6d89cab149c67f9625f6:web/pages/account.jsp

<div class="container">
    <div class="account-header">
        <div>
            <h1>My Account</h1>
            <p>Welcome back, <%= name %>!</p>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="signout-btn">Sign Out</a>
    </div>

    <div class="member-card">
        <p>Member Since <%= (date != null) ? date : "New Member" %></p>
        <h2><%= name %></h2>
        <p><%= email %></p>

        <div class="member-tier">
            🏅 <h4><%= tier %></h4>
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

<<<<<<< HEAD:web/pages/users/account.jsp
    <!-- Menu Cards -->
    <div class="grid">

        <!-- Profile -->
        <a href="${pageContext.request.contextPath}/pages/users/profile.jsp" style="text-decoration:none;color:inherit;">
            <div class="card menu-card">
                <div class="icon">👤</div>
                <h2>Profile</h2>
                <p>Manage your personal information</p>
=======
    <div class="grid" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top: 30px;">
        <a href="${pageContext.request.contextPath}/pages/profile.jsp" style="text-decoration:none; color:inherit;">
            <div class="card menu-card" style="background:white; padding:20px; border-radius:15px; text-align:center;">
                <div style="font-size:30px;">👤</div>
                <h3>Profile</h3>
                <p style="font-size:12px; color:gray;">Manage personal info</p>
>>>>>>> de1e052a0f22f813002f6d89cab149c67f9625f6:web/pages/account.jsp
            </div>
        </a>
        <div class="card menu-card" style="background:white; padding:20px; border-radius:15px; text-align:center;">
            <div style="font-size:30px;">📦</div>
            <h3>My Orders</h3>
            <p style="font-size:12px; color:gray;">View order history</p>
        </div>
<<<<<<< HEAD:web/pages/users/account.jsp

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

=======
>>>>>>> de1e052a0f22f813002f6d89cab149c67f9625f6:web/pages/account.jsp
    </div>
</div>

<<<<<<< HEAD:web/pages/users/account.jsp
<!-- Footer -->
<jsp:include page="../../partials/footer.jsp"/>

=======
>>>>>>> de1e052a0f22f813002f6d89cab149c67f9625f6:web/pages/account.jsp
</body>
</html>