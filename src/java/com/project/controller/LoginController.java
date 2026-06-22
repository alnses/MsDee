package com.project.controller;

import com.project.util.DBConnection;
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
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String selectedRole = request.getParameter("role");

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users "
                    + "WHERE email = ? "
                    + "AND password = ? "
                    + "AND role = ?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, selectedRole);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session =
                        request.getSession();

                // IMPORTANT
                session.setAttribute(
                        "userId",
                        rs.getInt("user_id")
                );

                // optional backup
                session.setAttribute(
                        "userId",
                        rs.getInt("user_id")
                );

                session.setAttribute(
                        "fullName",
                        rs.getString("full_name")
                );

                session.setAttribute(
                        "email",
                        rs.getString("email")
                );

                session.setAttribute(
                        "role",
                        rs.getString("role")
                );

                session.setAttribute(
                        "membershipTier",
                        rs.getString("membership_tier")
                );

                session.setAttribute(
                        "totalSpent",
                        rs.getDouble("total_spent")
                );

                session.setAttribute(
                        "discount",
                        rs.getInt("discount")
                );

                session.setAttribute(
                        "memberSince",
                        rs.getString("member_since")
                );

                if ("admin".equalsIgnoreCase(
                        rs.getString("role"))) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/adminDashboard.jsp"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/users/homepage.jsp"
                    );
                }

            } else {

                if ("admin".equalsIgnoreCase(selectedRole)) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/admin/adminLogin.jsp?error=1"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/users/login.jsp?error=1"
                    );
                }
            }

            conn.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp?error=1"
            );
        }
    }
}