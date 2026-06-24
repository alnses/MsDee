
﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    String fullName = user != null ? user.getFullName() : (String) session.getAttribute("fullName");
    String email = user != null ? user.getEmail() : (String) session.getAttribute("email");
    String phone = user != null ? user.getPhone() : (String) session.getAttribute("phone");
    String memberSince = user != null ? user.getMemberSince() : (String) session.getAttribute("memberSince");
    String membershipTier = user != null ? user.getMembershipTier() : (String) session.getAttribute("membershipTier");
    double totalSpent = user != null ? user.getTotalSpent() : 0.0;
    int discount = user != null ? user.getDiscount() : 0;

    if (session.getAttribute("totalSpent") != null && user == null) {
        totalSpent = Double.parseDouble(session.getAttribute("totalSpent").toString());
    }

    if (session.getAttribute("discount") != null && user == null) {
        discount = Integer.parseInt(session.getAttribute("discount").toString());
    }

    if (fullName == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }

    if (email == null) {
        email = "";
    }

    if (phone == null) {
        phone = "";
    }

    if (memberSince == null) {
        memberSince = "New Member";
    }

    if (membershipTier == null) {
        membershipTier = "Bronze";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Profile | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=68">
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="container profile-account-page">

            <div class="account-header">
                <div>
                    <h1>My Account</h1>
                    <p>Welcome back, <%= fullName%>!</p>
                </div>

                <a href="${pageContext.request.contextPath}/logout" class="signout-btn">Sign Out</a>
            </div>

            <div class="member-card">
                <p>Member Since <%= memberSince%></p>

                <h2><%= fullName%></h2>
                <p><%= email%></p>

                <div class="member-tier">
                    <span class="account-tier-icon">&#127941;</span>
                    <h4><%= membershipTier%></h4>
                </div>

                <div class="member-stats">
                    <div>
                        <p>Total Spent</p>
                        <h2>RM <%= String.format("%.2f", totalSpent)%></h2>
                    </div>

                    <div>
                        <p>Member Discount</p>
                        <h2><%= discount%>% OFF</h2>
                    </div>
                </div>
            </div>

            <% if ("true".equals(request.getParameter("updated"))) { %>
            <div class="profile-message success">Profile updated successfully.</div>
            <% } else if (request.getParameter("error") != null) { %>
            <div class="profile-message error">Please check your details and try again.</div>
            <% }%>

            <div class="profile-dashboard-grid profile-card-grid">
                <button type="button" class="card menu-card profile-toggle-card" onclick="toggleProfileForm()">
                    <div class="icon">&#128100;</div>
                    <h2>Profile</h2>
                    <p>Manage your personal information</p>
                </button>

                <a href="${pageContext.request.contextPath}/orders" class="card menu-card">
                    <div class="icon">&#128230;</div>
                    <h2>My Orders</h2>
                    <p>View order history</p>
                </a>

                <a href="${pageContext.request.contextPath}/pages/users/membership.jsp" class="card menu-card">
                    <div class="icon">&#11088;</div>
                    <h2>Membership</h2>
                    <p>View benefits and upgrade</p>
                </a>

                <a href="${pageContext.request.contextPath}/addresses" class="card menu-card">
                    <div class="icon">&#128205;</div>
                    <h2>Addresses</h2>
                    <p>Manage shipping addresses</p>
                </a>
            </div>

            <form id="profileEditForm" class="profile-edit-card hidden-profile-form" action="${pageContext.request.contextPath}/profile" method="post">
                <div class="icon profile-form-icon">&#128100;</div>
                <h2>Personal Information</h2>
                <p class="profile-card-subtitle">Edit your customer details below.</p>

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input id="fullName" name="fullName" type="text" value="<%= fullName%>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" value="<%= email%>" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input id="phone" name="phone" type="tel" value="<%= phone%>" placeholder="Optional">
                </div>

                <button type="submit" class="main-btn profile-save-btn">Save Changes</button>
            </form>

            <script>
                function toggleProfileForm() {
                    const form = document.getElementById('profileEditForm');
                    form.classList.toggle('show');

                    if (form.classList.contains('show')) {
                        form.scrollIntoView({behavior: 'smooth', block: 'start'});
                    }
                }
            </script>

        </div>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>

