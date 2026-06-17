package com.project.controller;


import com.project.dao.UserDAO;
import com.project.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.project.dao.UserDAO;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserById(userId);

        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/users/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        String fullName = clean(request.getParameter("fullName"));
        String email = clean(request.getParameter("email"));
        String phone = clean(request.getParameter("phone"));

        if (fullName.isEmpty() || email.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile?error=missing");
            return;
        }

        UserDAO dao = new UserDAO();
        boolean updated = dao.updateProfile(userId, fullName, email, phone);

        if (updated) {
            session.setAttribute("fullName", fullName);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            response.sendRedirect(request.getContextPath() + "/profile?updated=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=save");
        }
    }

    private Integer getUserId(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object userObj = session.getAttribute("userId");

        if (userObj == null) {
            userObj = session.getAttribute("user_id");
        }

        if (userObj == null) {
            return null;
        }

        return Integer.parseInt(userObj.toString());
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}
