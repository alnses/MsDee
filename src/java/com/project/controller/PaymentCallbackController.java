package com.project.controller;

import com.project.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentCallbackController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processCallback(request);
        response.getWriter().write("OK");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processCallback(request);
        response.getWriter().write("OK");
    }

    private void processCallback(HttpServletRequest request) {

        String billCode = request.getParameter("billcode");
        String statusId = request.getParameter("status_id");

        if (billCode == null || billCode.trim().isEmpty()) {
            billCode = request.getParameter("billCode");
        }

        if (billCode == null || statusId == null) {
            return;
        }

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