<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="../partials/header.jsp"/>

<div class="container">

    <div class="account-header">
        <h1>My Profile</h1>
        <a href="${pageContext.request.contextPath}/pages/account.jsp" class="small-btn">← Back to Account</a>
    </div>

    <div class="card" style="margin-top:25px;">
        <h2>Personal Information</h2>
        <br>

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" value="<%= session.getAttribute("fullName") %>" readonly>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" value="<%= session.getAttribute("email") %>" readonly>
        </div>

        <div class="form-group">
            <label>Membership Tier</label>
            <input type="text" value="<%= session.getAttribute("membershipTier") %>" readonly>
        </div>

        <div class="form-group">
            <label>Total Spent</label>
            <input type="text" value="RM <%= session.getAttribute("totalSpent") %>" readonly>
        </div>

        <div class="form-group">
            <label>Discount</label>
            <input type="text" value="<%= session.getAttribute("discount") %>% OFF" readonly>
        </div>
    </div>

</div>

</body>
</html>