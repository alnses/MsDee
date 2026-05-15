<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 🔒 Protect page
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Membership | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body>

        <!-- Navbar -->
        <jsp:include page="../../partials/header.jsp"/>


        <div class="container">

            <!-- Header -->
            <div class="account-header">
                <h1>Membership Benefits</h1>
                <a href="${pageContext.request.contextPath}/pages/users/account.jsp" class="small-btn">← Back</a>
            </div>

            <div class="membership-grid">

                <!-- Bronze -->
                <div class="tier-card bronze">
                    <h2>🥉</h2>
                    <h2>Bronze</h2>

                    <%
                        String tier = (String) session.getAttribute("membershipTier");
                        if ("Bronze".equalsIgnoreCase(tier)) {
                    %>
                    <div class="current-tier">Your Current Tier</div>
                    <%
                        }
                    %>

                    <h1>0%</h1>
                    <p>Member Discount</p>
                    <br>
                    <p>Starting tier for all members</p>
                </div>

                <!-- Silver -->
                <div class="tier-card silver">
                    <h2>🥈</h2>
                    <h2>Silver</h2>

                    <%
                        if ("Silver".equalsIgnoreCase(tier)) {
                    %>
                    <div class="current-tier">Your Current Tier</div>
                    <%
                        }
                    %>

                    <h1>5%</h1>
                    <p>Member Discount</p>
                    <br>
                    <p>Spend RM 500+ to unlock</p>
                </div>

                <!-- Gold -->
                <div class="tier-card gold">
                    <h2>🥇</h2>
                    <h2>Gold</h2>

                    <%
                        if ("Gold".equalsIgnoreCase(tier)) {
                    %>
                    <div class="current-tier">Your Current Tier</div>
                    <%
                        }
                    %>

                    <h1>10%</h1>
                    <p>Member Discount</p>
                    <br>
                    <p>Spend RM 2000+ to unlock</p>
                </div>

                <!-- Platinum -->
                <div class="tier-card platinum">
                    <h2>💎</h2>
                    <h2>Platinum</h2>

                    <%
                        if ("Platinum".equalsIgnoreCase(tier)) {
                    %>
                    <div class="current-tier">Your Current Tier</div>
                    <%
                        }
                    %>

                    <h1>15%</h1>
                    <p>Member Discount</p>
                    <br>
                    <p>Spend RM 5000+ to unlock</p>
                </div>

            </div>

            <br><br>

            <!-- Info Section -->
            <div class="card">
                <h2>How Membership Works</h2>
                <br>
                <p>1. Shop & Earn — Every purchase increases your total spending.</p>
                <p>2. Unlock Tiers — You are automatically upgraded when you reach spending thresholds.</p>
                <p>3. Save More — Higher tiers enjoy better discounts on every purchase.</p>
            </div>

        </div>

        <!-- Footer -->
        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>