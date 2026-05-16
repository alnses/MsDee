<%@ page import="java.util.List" %>
<%@ page import="com.project.model.Address" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>My Addresses | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=50">
    </head>

    <body class="page-layout">

        <jsp:include page="../../partials/header.jsp"/>

        <main class="main-content">
            <div class="address-page">

                <div class="address-title">
                    <h1>My Addresses</h1>
                    <p>Manage your saved shipping addresses</p>
                </div>

                <div class="address-form-card">
                    <form action="${pageContext.request.contextPath}/addresses" method="post" class="address-form">
                        <input type="hidden" name="action" value="add">

                        <input type="text" name="fullName" placeholder="Full Name" required>
                        <input type="text" name="phone" placeholder="Phone Number" required>
                        <textarea name="addressLine" placeholder="Full Address" required></textarea>
                        <input type="text" name="city" placeholder="City" required>
                        <input type="text" name="state" placeholder="State" required>
                        <input type="text" name="postcode" placeholder="Postcode" required>

                        <button type="submit" class="add-address-btn">Add Address</button>
                    </form>
                </div>

                <div class="address-list">
                    <%
                        List<Address> addresses = (List<Address>) request.getAttribute("addresses");

                        if (addresses == null || addresses.isEmpty()) {
                    %>
                    <div class="empty-address">
                        <h2>No address added yet</h2>
                        <p>Add your first shipping address above.</p>
                    </div>
                    <%
                    } else {
                        for (Address a : addresses) {
                    %>

                    <div class="address-card">

                        <div>

                            <h3>
                                <%= a.getFullName()%>

                                <%
                                    if (a.isDefault()) {
                                %>

                                <span class="primary-badge">
                                    Primary
                                </span>

                                <%
                                    }
                                %>

                            </h3>


                            <p>
                                <strong>Phone:</strong>
                                <%= a.getPhone()%>
                            </p>

                            <p>
                                <strong>Address:</strong>

                                <%=a.getAddressLine()%>,
                                <%=a.getCity()%>,
                                <%=a.getState()%>,
                                <%=a.getPostcode()%>

                            </p>


                            <form action="${pageContext.request.contextPath}/addresses"
                                  method="post">

                                <input type="hidden"
                                       name="action"
                                       value="primary">

                                <input type="hidden"
                                       name="addressId"
                                       value="<%=a.getAddressId()%>">


                                <label class="primary-check">

                                    <input
                                        type="checkbox"

                                        <%=a.isDefault()
        ? "checked" : ""%>

                                        onchange="this.form.submit()">

                                    Set as Primary

                                </label>

                            </form>

                        </div>

                        <%
                                }
                            }
                        %>
                    </div>

                </div>
        </main>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>