<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Product Details | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=31">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .details-wrapper {
                max-width: 1200px;
                margin: 50px auto;
                padding: 20px;
                display: flex;
                gap: 50px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.03);
            }
            .details-img-side {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                background: #f8f9fa;
                border-radius: 12px;
                padding: 40px;
            }
            .details-img-side img {
                max-width: 100%;
                max-height: 400px;
                object-fit: contain;
            }
            .details-info-side {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .details-category {
                color: #7a869a;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 1px;
                margin-bottom: 10px;
            }
            .details-title {
                font-size: 36px;
                color: #1e1e2f;
                margin-bottom: 15px;
            }
            .details-price {
                font-size: 28px;
                color: #ff4d6d;
                font-weight: 700;
                margin-bottom: 25px;
            }
            .details-desc {
                color: #4a5568;
                line-height: 1.6;
                margin-bottom: 35px;
            }
            .actions-row {
                display: flex;
                gap: 15px;
            }
            .btn-action {
                padding: 15px 30px;
                font-size: 16px;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: transform 0.2s, opacity 0.2s;
            }
            .btn-action:active { transform: scale(0.98); }
            .btn-add-cart {
                background: #2d3748;
                color: #fff;
            }
            .btn-buy-now {
                background: #ff4d6d;
                color: #fff;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="details-wrapper">
            <div class="details-img-side">
                <img id="prodImageDisplay" src="" alt="">
            </div>
            <div class="details-info-side">
                <span class="details-category" id="prodCategoryDisplay"></span>
                <h1 class="details-title" id="prodNameDisplay"></h1>
                <div class="details-price">RM <span id="prodPriceDisplay"></span></div>
                
                <p class="details-desc">
                    High quality appliances designed to make your daily home tasks simpler, more efficient, and incredibly smooth. Part of our exclusive premium collection.
                </p>

                <div class="actions-row">
                    <form action="${pageContext.request.contextPath}/AddToCartController" method="POST" onsubmit="return checkAuthentication(event)">
                        <input type="hidden" name="prodName" id="formCartName">
                        <input type="hidden" name="prodPrice" id="formCartPrice">
                        <input type="hidden" name="prodImage" id="formCartImage">
                        <button type="submit" class="btn-action btn-add-cart">Add to Cart</button>
                    </form>

                    <form action="${pageContext.request.contextPath}/CheckoutController" method="POST" onsubmit="return checkAuthentication(event)">
                        <input type="hidden" name="prodName" id="formCheckoutName">
                        <input type="hidden" name="prodPrice" id="formCheckoutPrice">
                        <input type="hidden" name="prodImage" id="formCheckoutImage">
                        <button type="submit" class="btn-action btn-buy-now">Buy Now</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Retrieve details passed dynamically via URL strings
            const urlParams = new URLSearchParams(window.location.search);
            const pName = urlParams.get('name') || "Product";
            const pPrice = urlParams.get('price') || "0.00";
            const pCategory = urlParams.get('category') || "General";
            const pImage = urlParams.get('image') || "";

            // Bind values directly into display visual containers
            document.getElementById('prodNameDisplay').innerText = pName;
            document.getElementById('prodPriceDisplay').innerText = pPrice;
            document.getElementById('prodCategoryDisplay').innerText = pCategory;
            document.getElementById('prodImageDisplay').src = pImage;
            document.getElementById('prodImageDisplay').alt = pName;

            // Bind data directly into the input parameters for hidden form submission elements
            document.getElementById('formCartName').value = pName;
            document.getElementById('formCartPrice').value = pPrice;
            document.getElementById('formCartImage').value = pImage;

            document.getElementById('formCheckoutName').value = pName;
            document.getElementById('formCheckoutPrice').value = pPrice;
            document.getElementById('formCheckoutImage').value = pImage;

            // Sync user authentication mapping using your backend LoginController session configuration parameters
            const userIsLoggedIn = ${not empty sessionScope.userId ? "true" : "false"};

            function checkAuthentication(event) {
                if (!userIsLoggedIn) {
                    event.preventDefault();
                    alert("Please log in first to perform this action.");
                    window.location.href = "${pageContext.request.contextPath}/pages/users/login.jsp";
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>