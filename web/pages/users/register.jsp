<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>


<div class="auth-box">
    <h2>Create Account</h2>
    <p>Join Ms. Dee today</p>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert">Registration failed. Email may already exist.</div>
    <% } %>

    <div class="tab-buttons">
        <a href="login.jsp" class="inactive-tab">Sign In</a>
        <a href="register.jsp" class="active-tab">Register</a>
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullName" required>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" minlength="6" required>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <input type="text" name="phone" required>
        </div>

        <button class="main-btn" type="submit">Create Account</button>
    </form>
</div>

</body>
</html>