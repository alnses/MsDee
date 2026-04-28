package com.project.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter({
    "/pages/account.jsp",
    "/pages/membership.jsp",
    "/pages/profile.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("fullName") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }
}