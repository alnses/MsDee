<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.project.dao.ProductDAO, com.project.dao.OrderDAO, com.project.util.DBConnection" %>
<%@ page import="java.sql.*" %>

<%
    ProductDAO productDAO = new ProductDAO();
    OrderDAO orderDAO = new OrderDAO();
    
    double monthlySales = orderDAO.getTotalSalesAmount();
    int totalOrders = orderDAO.getTotalOrderCount();
    int lowStock = productDAO.getLowStockCount();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reports | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .spacer { width: 260px; float: left; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 40px; }
        .info-box { background: #ffffff; padding: 40px 20px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); text-align: center; border-top: 6px solid #1a1a2e; transition: all 0.3s ease; }
        .info-box:hover { transform: translateY(-8px); box-shadow: 0 8px 20px rgba(0,0,0,0.15); }
        .info-box h3 { font-size: 1.1em; color: #777; margin-bottom: 15px; text-transform: uppercase; letter-spacing: 1.2px; }
        .info-box p { font-size: 2em; font-weight: 800; color: #1a1a2e; }
        
        /* New styles for the upload form */
        .upload-card { background: #f8f9fa; padding: 20px; border-radius: 12px; margin-bottom: 30px; border: 1px solid #ddd; }
        .admin-table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .admin-table th { background: #1a1a2e; color: white; padding: 15px; text-align: left; }
        .admin-table td { padding: 15px; border-bottom: 1px solid #eee; }
    </style>
</head>
<body>
    <jsp:include page="/partials/admin-sidebar.jsp">
        <jsp:param name="activePage" value="reports" />
    </jsp:include>

    <div class="spacer"></div>

    <main class="admin-main" style="padding: 40px;">
        <h1>Sales & Inventory Reports</h1>
        
        <div class="dashboard-grid">
            <div class="info-box"><h3>Monthly Sales</h3><p>RM <%= String.format("%.2f", monthlySales) %></p></div>
            <div class="info-box"><h3>Total Orders</h3><p><%= totalOrders %></p></div>
            <div class="info-box"><h3>Low Stock</h3><p><%= lowStock %></p></div>
        </div>

        <div class="upload-card">
            <h3>Upload New Report</h3>
            <form action="${pageContext.request.contextPath}/UploadReportServlet" method="post" enctype="multipart/form-data">
                <input type="text" name="reportName" placeholder="Report Title" required style="padding: 8px; width: 300px;">
                <input type="file" name="pdfFile" accept="application/pdf" required>
                <button type="submit" style="padding: 8px 20px; background: #1a1a2e; color: white; border: none; cursor: pointer;">Upload</button>
            </form>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>Report Type</th>
                    <th>Generated Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DBConnection.getConnection();
                         Statement st = conn.createStatement();
                         ResultSet rs = st.executeQuery("SELECT * FROM reports ORDER BY generated_date DESC")) {
                        while(rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("report_name") %></td>
                    <td><%= rs.getTimestamp("generated_date") %></td>
                    <td><a href="<%= rs.getString("file_path") %>" target="_blank">Download PDF</a></td>
                </tr>
                <%
                        }
                    } catch(Exception e) { out.println("<tr><td colspan='3'>No reports uploaded yet.</td></tr>"); }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>