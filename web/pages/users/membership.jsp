<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.dao.UserDAO" %>
<%@ page import="com.project.model.User" %>

<%
    if (session.getAttribute("fullName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        return;
    }

    Integer userId = null;

    if (session.getAttribute("userId") != null) {
        userId = Integer.parseInt(session.getAttribute("userId").toString());
    }

    String tier = "Bronze";
    double totalSpent = 0;
    int discount = 0;

    if (userId != null) {

        UserDAO dao = new UserDAO();
        User user = dao.getUserById(userId);

        if (user != null) {
            tier = user.getMembershipTier();
            totalSpent = user.getTotalSpent();
            discount = user.getDiscount();
        }
    }

    double nextTierTarget = 500;
    String nextTier = "Silver";

    if ("Silver".equalsIgnoreCase(tier)) {
        nextTierTarget = 2000;
        nextTier = "Gold";
    } else if ("Gold".equalsIgnoreCase(tier)) {
        nextTierTarget = 5000;
        nextTier = "Platinum";
    }

    double remaining = Math.max(0, nextTierTarget - totalSpent);

    double progress = 0;

    if ("Bronze".equalsIgnoreCase(tier)) {
        progress = (totalSpent / 500.0) * 100;
    } else if ("Silver".equalsIgnoreCase(tier)) {
        progress = (totalSpent / 2000.0) * 100;
    } else if ("Gold".equalsIgnoreCase(tier)) {
        progress = (totalSpent / 5000.0) * 100;
    } else {
        progress = 100;
    }

    if (progress > 100) {
        progress = 100;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Membership | Ms. Dee</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css?v=99">

        <style>

            .membership-summary-card{
                background:white;
                padding:30px;
                border-radius:20px;
                margin-bottom:30px;
                box-shadow:0 10px 30px rgba(0,0,0,.08);
            }

            .membership-summary-card h2{
                margin-bottom:20px;
            }

            .membership-summary-grid{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:25px;
                margin-bottom:20px;
            }

            .membership-summary-grid span{
                color:#777;
                font-size:14px;
            }

            .membership-summary-grid h3{
                font-size:28px;
                margin-top:6px;
                color:#19172b;
            }

            .membership-progress{
                height:14px;
                background:#e5e7eb;
                border-radius:999px;
                overflow:hidden;
                margin-top:15px;
            }

            .membership-progress-fill{
                height:100%;
                background:linear-gradient(135deg,#6678f2,#7b52b8);
            }

            .active-tier{
                border:4px solid #6678f2 !important;
                transform:scale(1.03);
                box-shadow:0 15px 35px rgba(102,120,242,.25);
            }

            .tier-card{
                transition:.3s;
            }

            .tier-card:hover{
                transform:translateY(-5px);
            }

        </style>

    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="container">

            <div class="account-header">
                <h1>Membership Benefits</h1>

                <a href="${pageContext.request.contextPath}/profile"
                   class="small-btn">
                    ← Back
                </a>
            </div>

            <!-- SUMMARY -->

            <div class="membership-summary-card">

                <h2>Your Membership Status</h2>

                <div class="membership-summary-grid">

                    <div>
                        <span>Current Tier</span>
                        <h3><%= tier%></h3>
                    </div>

                    <div>
                        <span>Total Spent</span>
                        <h3>RM <%= String.format("%.2f", totalSpent)%></h3>
                    </div>

                    <div>
                        <span>Discount</span>
                        <h3><%= discount%>% OFF</h3>
                    </div>

                </div>

                <% if (!"Platinum".equalsIgnoreCase(tier)) {%>

                <p>
                    Spend
                    <strong>
                        RM <%= String.format("%.2f", remaining)%>
                    </strong>
                    more to unlock
                    <strong><%= nextTier%></strong>
                </p>

                <% } else { %>

                <p>
                    Congratulations! You have reached the highest membership tier.
                </p>

                <% }%>

                <div class="membership-progress">
                    <div class="membership-progress-fill"
                         style="width:<%= progress%>%">
                    </div>
                </div>

            </div>

            <!-- MEMBERSHIP CARDS -->

            <div class="membership-grid">

                <div class="tier-card bronze <%= "Bronze".equalsIgnoreCase(tier) ? "active-tier" : ""%>">

                    <h2>🥉</h2>
                    <h2>Bronze</h2>

                    <% if ("Bronze".equalsIgnoreCase(tier)) { %>
                    <div class="current-tier">Your Current Tier</div>
                    <% }%>

                    <h1>0%</h1>
                    <p>Member Discount</p>

                    <br>

                    <p>Starting tier for all members</p>

                </div>

                <div class="tier-card silver <%= "Silver".equalsIgnoreCase(tier) ? "active-tier" : ""%>">

                    <h2>🥈</h2>
                    <h2>Silver</h2>

                    <% if ("Silver".equalsIgnoreCase(tier)) { %>
                    <div class="current-tier">Your Current Tier</div>
                    <% }%>

                    <h1>5%</h1>
                    <p>Member Discount</p>

                    <br>

                    <p>Spend RM 500+ to unlock</p>

                </div>

                <div class="tier-card gold <%= "Gold".equalsIgnoreCase(tier) ? "active-tier" : ""%>">

                    <h2>🥇</h2>
                    <h2>Gold</h2>

                    <% if ("Gold".equalsIgnoreCase(tier)) { %>
                    <div class="current-tier">Your Current Tier</div>
                    <% }%>

                    <h1>10%</h1>
                    <p>Member Discount</p>

                    <br>

                    <p>Spend RM 2000+ to unlock</p>

                </div>

                <div class="tier-card platinum <%= "Platinum".equalsIgnoreCase(tier) ? "active-tier" : ""%>">

                    <h2>💎</h2>
                    <h2>Platinum</h2>

                    <% if ("Platinum".equalsIgnoreCase(tier)) { %>
                    <div class="current-tier">Your Current Tier</div>
                    <% }%>

                    <h1>15%</h1>
                    <p>Member Discount</p>

                    <br>

                    <p>Spend RM 5000+ to unlock</p>

                </div>

            </div>

            <br><br>

            <div class="card">

                <h2>How Membership Works</h2>

                <br>

                <p>1. Shop & Earn — Every successful order increases your total spending.</p>

                <p>2. Unlock Tiers — Your membership tier upgrades automatically.</p>

                <p>3. Save More — Higher tiers receive bigger discounts on future purchases.</p>

                <p>4. Lifetime Benefits — Membership status never expires.</p>

            </div>

        </div>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>