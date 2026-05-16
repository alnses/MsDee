package com.project.controller;

import com.project.dao.AddressDAO;
import com.project.model.Address;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/addresses")
public class AddressController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        AddressDAO dao = new AddressDAO();
        List<Address> addresses = dao.getAddressesByUserId(userId);

        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("/pages/users/addresses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        AddressDAO dao = new AddressDAO();

        if ("add".equals(action)) {
            Address address = new Address();

            address.setUserId(userId);
            address.setFullName(request.getParameter("fullName"));
            address.setPhone(request.getParameter("phone"));
            address.setAddressLine(request.getParameter("addressLine"));
            address.setCity(request.getParameter("city"));
            address.setState(request.getParameter("state"));
            address.setPostcode(request.getParameter("postcode"));
            boolean primary
                    = request.getParameter("isDefault")
                    != null;

            address.setDefault(primary);
            dao.addAddress(address);
        }

        if ("delete".equals(action)) {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            dao.deleteAddress(addressId, userId);
        }

        if ("primary".equals(action)) {

            int addressId
                    = Integer.parseInt(
                            request.getParameter("addressId"));

            dao.setPrimaryAddress(
                    addressId,
                    userId);

        }

        response.sendRedirect(request.getContextPath() + "/addresses");
    }
}
