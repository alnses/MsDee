<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="../../partials/header.jsp"/>

<div style="max-width:600px;margin:80px auto;background:white;padding:40px;border-radius:18px;text-align:center;">
    <h1>Payment Successful</h1>
    <p>Thank you for your purchase.</p>

    <a href="${pageContext.request.contextPath}/pages/users/shop.jsp">
        Continue Shopping
    </a>
</div>

<script>
    localStorage.removeItem("cart");
</script>

</body>
</html>