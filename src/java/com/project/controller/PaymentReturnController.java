package com.project.controller;

import com.project.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billCode = request.getParameter("billcode");
        String statusId = request.getParameter("status_id");

        if (billCode == null || billCode.trim().isEmpty()) {
            billCode = request.getParameter("billCode");
        }

        if (billCode != null && statusId != null) {
            updatePaymentStatus(billCode, statusId);
        }

        if ("1".equals(statusId)) {
            response.sendRedirect(request.getContextPath() + "/pages/users/paymentSuccess.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/users/cart.jsp?error=payment_failed");
        }
    }

    private void updatePaymentStatus(String billCode, String statusId) {

        String paymentStatus = "Pending";
        String orderStatus = "Processing";

        if ("1".equals(statusId)) {
            paymentStatus = "Paid";
            orderStatus = "Paid";
        } else if ("2".equals(statusId)) {
            paymentStatus = "Pending";
            orderStatus = "Processing";
        } else if ("3".equals(statusId)) {
            paymentStatus = "Failed";
            orderStatus = "Payment Failed";
        }

        String sql =
                "UPDATE orders "
                + "SET paymentStatus = ?, orderStatus = ? "
                + "WHERE billCode = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ps.setString(2, orderStatus);
            ps.setString(3, billCode);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}