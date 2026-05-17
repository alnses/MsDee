<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>

.admin-sidebar{
    width:250px;
    height:100vh;
    background:#171628;
    color:white;

    position:fixed;
    left:0;
    top:0;

    padding:32px 24px;
    box-sizing:border-box;

    display:flex;
    flex-direction:column;
}

.admin-sidebar h2{
    font-size:28px;
    margin-bottom:40px;
    font-weight:800;
}

.admin-sidebar a{
    color:white;
    text-decoration:none;

    padding:14px 16px;
    margin-bottom:10px;

    border-radius:12px;
    font-weight:700;

    transition:.2s;
}

.admin-sidebar a:hover{
    background:#2b2a4f;
}

.admin-sidebar a.active{
    background:#6366f1;
}

/* push logout to bottom */
.logout-container{
    margin-top:auto;
}

.logout-btn{
    background:#ef4444 !important;
    display:block;
    text-align:center;
}

.logout-btn:hover{
    background:#dc2626 !important;
}

</style>


<div class="admin-sidebar">

    <h2>Ms.Dee Admin</h2>

    <a href="${pageContext.request.contextPath}/pages/admin/adminDashboard.jsp">
        Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/pages/admin/manageProducts.jsp">
        Manage Products
    </a>

    <a href="${pageContext.request.contextPath}/pages/admin/manageInventory.jsp">
        Manage Inventory
    </a>

    <a href="${pageContext.request.contextPath}/pages/admin/manageOrders.jsp">
        Manage Orders
    </a>

    <a href="${pageContext.request.contextPath}/pages/admin/report.jsp">
        Reports
    </a>


    <div class="logout-container">

        <a class="logout-btn"
           href="${pageContext.request.contextPath}/logout">

            Logout

        </a>

    </div>

</div>