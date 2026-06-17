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
    const checkoutItems = JSON.parse(localStorage.getItem("checkoutItems")) || [];
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    if (checkoutItems.length > 0) {
        const remainingCart = cart.filter(item =>
            !checkoutItems.some(checkedOut =>
                checkedOut.name === item.name
                && checkedOut.price === item.price
                && checkedOut.image === item.image
            )
        );
        localStorage.setItem("cart", JSON.stringify(remainingCart));
        localStorage.removeItem("checkoutItems");
    } else {
        localStorage.removeItem("cart");
    }
</script>
</body>
</html>