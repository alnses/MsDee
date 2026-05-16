package com.project.controller;

import com.project.dao.UserDAO;
import com.project.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        UserDAO dao = new UserDAO();
        User user = dao.getUserById(userId);

        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/users/account.jsp").forward(request, response);
    }
}