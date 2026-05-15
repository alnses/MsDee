<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=100">
    </head>

    <body class="login-page">

        <div class="login-brand">
            <h1>Ms.Dee</h1>
            <p>Home Appliances Specialist</p>
        </div>

        <div class="auth-box">

            <div class="auth-icon">👤</div>

            <h2>Welcome Back</h2>
            <p>Sign in to your account</p>

            <% if (request.getParameter("error") != null) { %>
            <div class="alert">Invalid email or password.</div>
            <% }%>

            <div class="tab-buttons">
                <a href="login.jsp" class="active-tab">Customer</a>
                <a href="${pageContext.request.contextPath}/pages/admin/adminLogin.jsp" class="inactive-tab">Admin</a>
            </div>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <input type="hidden" name="role" value="customer">

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <button class="main-btn" type="submit">
                    Sign In
                </button>

            </form>

            <div class="auth-footer">
                Don't have an account?
                <a href="register.jsp">Register Here</a>
            </div>

        </div>

    </body>
</html>