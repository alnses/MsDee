<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String u = (String) session.getAttribute("userName");
    String e = (String) session.getAttribute("userEmail");
    if (u == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="account-container">
        <div class="membership-summary-card">
            <h2><%= u %></h2>
            <p><%= e %></p>
            <hr>
            <p>Tier: <strong>Bronze</strong> | Discount: 0%</p>
        </div>
        <div class="menu-grid">
            <div class="menu-item" onclick="location.href='membership.jsp'"><h3>Membership</h3><p>View benefits</p></div>
            <div class="menu-item" onclick="location.href='LogoutServlet'"><h3>Sign Out</h3><p>End session</p></div>
        </div>
        <div class="how-it-works">
            <h3>How It Works</h3>
            <div class="step-item"><div class="step-number">1</div><p><strong>Shop:</strong> Earn points on every RM.</p></div>
            <div class="step-item"><div class="step-number">2</div><p><strong>Unlock:</strong> Reach RM 500 for Silver.</p></div>
        </div>
    </div>
</body>
</html>