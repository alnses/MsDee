package com.project.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter({
    "/pages/users/account.jsp",
    "/pages/users/membership.jsp",
    "/pages/users/profile.jsp",
    "/pages/users/orders.jsp",
    "/pages/users/checkout.jsp",
    "/checkout"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // This now matches the key set in LoginController
        boolean loggedIn = session != null && session.getAttribute("userId") != null;

        if (!loggedIn) {
            res.sendRedirect(req.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}