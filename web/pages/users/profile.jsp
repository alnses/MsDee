<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    String fullName = user != null ? user.getFullName() : (String) session.getAttribute("fullName");
    String email = user != null ? user.getEmail() : (String) session.getAttribute("email");
    String phone = user != null ? user.getPhone() : (String) session.getAttribute("phone");

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
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Profile | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=63">
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="profile-page">

            <div class="profile-topbar">
                <div>
                    <h1>My Profile</h1>
                    <p>Update the details Ms. Dee uses for your account.</p>
                </div>

                <a href="${pageContext.request.contextPath}/pages/users/account.jsp" class="small-btn">Back to Account</a>
            </div>

            <% if ("true".equals(request.getParameter("updated"))) { %>
                <div class="profile-message success">Profile updated successfully.</div>
            <% } else if (request.getParameter("error") != null) { %>
                <div class="profile-message error">Please check your details and try again.</div>
            <% } %>

            <form class="profile-edit-card" action="${pageContext.request.contextPath}/profile" method="post">
                <h2>Personal Details</h2>

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input id="fullName" name="fullName" type="text" value="<%= fullName %>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" value="<%= email %>" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input id="phone" name="phone" type="tel" value="<%= phone %>" placeholder="Optional">
                </div>

                <button type="submit" class="main-btn profile-save-btn">Save Changes</button>
            </form>

        </div>

    </body>
</html>
