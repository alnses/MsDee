package com.project.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = request.getParameter("role");

        if (session != null) {
            session.invalidate();
        }

        // Redirect based on role
        if ("admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/pages/admin/adminLogin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
        }
    }
}