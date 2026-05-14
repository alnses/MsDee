package com.project.controller;

import com.project.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegistrationController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users (full_name, email, password, phone, member_since) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // Generate Current Date
            LocalDate today = LocalDate.now();
            String formattedDate = today.format(DateTimeFormatter.ofPattern("dd MMM yyyy"));

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, formattedDate);

            int row = ps.executeUpdate();

            if (row > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("fullName", fullName);
                session.setAttribute("email", email);
                session.setAttribute("memberSince", formattedDate); // Fixes the null date
                
                // Default stats for new users
                session.setAttribute("membershipTier", "Bronze");
                session.setAttribute("totalSpent", 0.0);
                session.setAttribute("discount", 0);

                response.sendRedirect(request.getContextPath() + "/pages/homepage.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=1");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/register.jsp?error=1");
        }
    }
}