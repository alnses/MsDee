<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.dao.ProductDAO" %>
<%@ page import="com.project.dao.OrderDAO" %>

<%
    // Fetching live data from your Database
    ProductDAO productDAO = new ProductDAO();
    OrderDAO orderDAO = new OrderDAO();
    
    int totalProducts = productDAO.getTotalProductCount();
    int pendingOrders = orderDAO.getPendingOrderCount();
    int lowStockItems = productDAO.getLowStockCount();
    double totalSales = orderDAO.getTotalSalesAmount();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        /* Layout Fixes */
        .spacer { width: 260px; float: left; }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-top: 30px;
        }

        /* The Functional Info Boxes */
        .info-box {
            background: white;
            padding: 40px 20px;
            min-height: 180px;
            border-radius: 16px;
            border-left: 10px solid;
            box-shadow: 0 6px 12px rgba(0,0,0,0.06);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: 600;
            font-size: 1.1em;
            text-decoration: none; /* Removes link underline */
            color: inherit;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .info-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0,0,0,0.15);
        }

        /* Unique box colors */
        .box-1 { border-color: #3b82f6; color: #1e40af; }
        .box-2 { border-color: #f59e0b; color: #92400e; }
        .box-3 { border-color: #ef4444; color: #991b1b; }
        .box-4 { border-color: #10b981; color: #065f46; }

        .info-box strong { font-size: 2.8em; margin-top: 10px; display: block; }
    </style>
</head>

<body>
    <jsp:include page="/partials/admin-sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <div class="spacer"></div>

    <main class="admin-main" style="padding: 40px;">
        <h1>Admin Dashboard</h1>
        
        <div class="dashboard-grid">
            <a href="manageProducts.jsp" class="info-box box-1">Total Products <strong><%= totalProducts %></strong></a>
            <a href="manageOrders.jsp" class="info-box box-2">Pending Orders <strong><%= pendingOrders %></strong></a>
            <a href="manageInventory.jsp" class="info-box box-3">Low Stock Items <strong><%= lowStockItems %></strong></a>
            <a href="report.jsp" class="info-box box-4">Total Sales <strong>RM <%= String.format("%.2f", totalSales) %></strong></a>
        </div>
    </main>
</body>
</html>