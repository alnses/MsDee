package com.project.controller;

import com.project.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/pages/users/register.jsp?error=empty");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO users (full_name, email, password, phone) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp?registered=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/users/register.jsp?error=fail");
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();

            // temporary: show real error in browser
            response.setContentType("text/html");
            response.getWriter().println("<h2>Registration Error</h2>");
            response.getWriter().println("<p>" + e.getMessage() + "</p>");
        }
    }
}