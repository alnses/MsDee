package com.project.controller;

import com.project.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Create session
                HttpSession session = request.getSession();

                session.setAttribute("fullName", rs.getString("full_name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("membershipTier", rs.getString("membership_tier"));
                session.setAttribute("totalSpent", rs.getDouble("total_spent"));
                session.setAttribute("discount", rs.getInt("discount"));
                session.setAttribute("memberSince", rs.getString("member_since"));;

                // ✅ Redirect to account page
                response.sendRedirect(request.getContextPath() + "/pages/homepage.jsp");

            } else {
                // ❌ Login failed
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=1");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=1");
        }
    }
}
