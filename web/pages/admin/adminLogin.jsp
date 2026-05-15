<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=99">
</head>

<body class="login-page">

<div class="login-brand">
    <h1>Ms.Dee Admin</h1>
    <p>Backend Management System</p>
</div>

<div class="auth-box">

    <div class="auth-icon">🛠️</div>

    <h2>Admin Login</h2>
    <p>Sign in as administrator</p>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert">Invalid admin email or password.</div>
    <% } %>

    <div class="tab-buttons">
        <a href="${pageContext.request.contextPath}/pages/users/login.jsp" class="inactive-tab">Customer</a>
        <a href="adminLogin.jsp" class="active-tab">Admin</a>
    </div>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <input type="hidden" name="role" value="admin">

        <div class="form-group">
            <label>Admin Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button class="main-btn" type="submit">Sign In as Admin</button>

    </form>

</div>

</body>
</html>