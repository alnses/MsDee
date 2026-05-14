<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Clears any old session (like "qis") so the header shows "Profile"
    if (session != null) {
        session.invalidate(); 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="../partials/header.jsp"/>

<div class="auth-box">
    <div class="auth-icon">👤</div>
    <h2>Welcome Back</h2>
    <p>Sign in to your account</p>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert" style="color:red; margin-bottom:10px;">Invalid email or password.</div>
    <% } %>

    <div class="tab-buttons">
        <a href="login.jsp" class="active-tab">Sign In</a>
        <a href="register.jsp" class="inactive-tab">Register</a>
    </div>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button class="main-btn" type="submit">Sign In</button>
    </form>
</div>

</body>
</html>