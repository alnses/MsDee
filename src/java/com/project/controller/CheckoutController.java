package com.project.controller;

import com.project.dao.AddressDAO;
import com.project.model.Address;
import com.project.util.DBConnection;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckoutController extends HttpServlet {

    private static final String TOYYIBPAY_API_URL
            = "https://toyyibpay.com/index.php/api/createBill";

    private static final String TOYYIBPAY_PAYMENT_URL
            = "https://toyyibpay.com/";

    private static final String SECRET_KEY
            = "g4unf9oe-mrhg-4h42-8fc6-u38wydg8e864";

    private static final String CATEGORY_CODE
            = "huu88rpz";

    private static final String CART_PAGE
            = "/pages/users/cart.jsp";

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp");
            return;
        }

        Object userObj = session.getAttribute("user_id");

        if (userObj == null) {
            userObj = session.getAttribute("userId");
        }

        if (userObj == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp");
            return;
        }

        int userId = Integer.parseInt(userObj.toString());

        AddressDAO addressDAO = new AddressDAO();
        Address primaryAddress = addressDAO.getPrimaryAddress(userId);

        String addressText = "";

        if (primaryAddress != null) {
            addressText
                    = primaryAddress.getFullName()
                    + " | "
                    + primaryAddress.getPhone()
                    + " | "
                    + primaryAddress.getAddressLine()
                    + ", "
                    + primaryAddress.getCity()
                    + ", "
                    + primaryAddress.getState()
                    + ", "
                    + primaryAddress.getPostcode();
        }

        String fullName = request.getParameter("fullname");

        if (fullName == null || fullName.trim().isEmpty()) {

            Object nameObj = session.getAttribute("fullName");

            if (nameObj == null) {
                nameObj = session.getAttribute("full_name");
            }

            fullName
                    = nameObj != null
                            ? nameObj.toString()
                            : "Customer";
        }

        String email = "customer@email.com";

        if (session.getAttribute("email") != null) {
            email = session.getAttribute("email").toString();
        }

        String phone = request.getParameter("phone");

        if (phone == null || phone.trim().isEmpty()) {
            phone = "0100000000";
        }

        String totalParam
                = request.getParameter("totalAmount");

        String paymentMethod
                = request.getParameter("paymentMethod");

        String membershipTier
                = request.getParameter("membershipTier");

        int discountPercent = 0;

        try {
            discountPercent = Integer.parseInt(
                    request.getParameter("discountPercent"));
        } catch (Exception e) {
        }

        double originalAmount = 0;

        try {
            originalAmount = Double.parseDouble(
                    request.getParameter("originalAmount"));
        } catch (Exception e) {
        }

        if (totalParam == null
                || totalParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + CART_PAGE
                    + "?error=missing_total");

            return;
        }

        try {

            double totalAmount
                    = Double.parseDouble(totalParam);

            if (totalAmount <= 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + CART_PAGE
                        + "?error=empty_cart");

                return;
            }

            int amountInCent
                    = (int) Math.round(totalAmount * 100);

            String orderRef
                    = "MSDEE_" + System.currentTimeMillis();

            String baseUrl
                    = request.getScheme()
                    + "://"
                    + request.getServerName()
                    + ":"
                    + request.getServerPort()
                    + request.getContextPath();

            String returnUrl
                    = baseUrl + "/payment-return";

            String callbackUrl
                    = baseUrl + "/payment-callback";

            String billCode = createToyyibPayBill(
                    orderRef,
                    fullName,
                    email,
                    phone,
                    amountInCent,
                    returnUrl,
                    callbackUrl);

            if (billCode == null
                    || billCode.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + CART_PAGE
                        + "?error=toyyibpay_failed");

                return;
            }

            saveOrder(
                    userId,
                    orderRef,
                    totalAmount,
                    billCode,
                    addressText,
                    paymentMethod,
                    membershipTier,
                    discountPercent,
                    originalAmount
            );

            response.sendRedirect(
                    TOYYIBPAY_PAYMENT_URL + billCode);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + CART_PAGE
                    + "?error=checkout_failed");
        }
    }

    private String createToyyibPayBill(
            String orderRef,
            String fullName,
            String email,
            String phone,
            int amountInCent,
            String returnUrl,
            String callbackUrl) throws IOException {

        String data
                = "userSecretKey=" + encode(SECRET_KEY)
                + "&categoryCode=" + encode(CATEGORY_CODE)
                + "&billName=" + encode("Ms. Dee Order")
                + "&billDescription=" + encode("Payment for order " + orderRef)
                + "&billPriceSetting=1"
                + "&billPayorInfo=1"
                + "&billAmount=" + amountInCent
                + "&billReturnUrl=" + encode(returnUrl)
                + "&billCallbackUrl=" + encode(callbackUrl)
                + "&billExternalReferenceNo=" + encode(orderRef)
                + "&billTo=" + encode(fullName)
                + "&billEmail=" + encode(email)
                + "&billPhone=" + encode(phone);

        URL url = new URL(TOYYIBPAY_API_URL);

        HttpURLConnection conn
                = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(data.getBytes("UTF-8"));
        }

        StringBuilder result = new StringBuilder();

        try (BufferedReader br
                = new BufferedReader(
                        new InputStreamReader(
                                conn.getInputStream(),
                                "UTF-8"))) {

            String line;

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
        }

        String apiResponse = result.toString();

        if (apiResponse.contains("\"BillCode\"")) {

            int start
                    = apiResponse.indexOf("\"BillCode\":\"")
                    + 12;

            int end
                    = apiResponse.indexOf("\"", start);

            if (end > start) {
                return apiResponse.substring(start, end);
            }
        }

        return null;
    }

    private int saveOrder(
            int userId,
            String orderRef,
            double totalAmount,
            String billCode,
            String addressText,
            String paymentMethod,
            String membershipTier,
            int discountPercent,
            double originalAmount)
            throws Exception {

        String sql
                = "INSERT INTO orders "
                + "(userId, orderRef, totalAmount, paymentStatus, "
                + "billCode, orderStatus, addressText, paymentMethod, "
                + "membershipTier, discountPercent, originalAmount) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps
                = conn.prepareStatement(
                        sql,
                        Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.setString(2, orderRef);
            ps.setDouble(3, totalAmount);
            ps.setString(4, "Pending");
            ps.setString(5, billCode);
            ps.setString(6, "Processing");
            ps.setString(7, addressText);
            ps.setString(8, paymentMethod);
            ps.setString(9, membershipTier);
            ps.setInt(10, discountPercent);
            ps.setDouble(11, originalAmount);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    private String encode(String value)
            throws UnsupportedEncodingException {

        return URLEncoder.encode(value, "UTF-8");
    }
}
