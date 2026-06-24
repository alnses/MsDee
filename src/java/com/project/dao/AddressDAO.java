package com.project.dao;

import com.project.model.Address;
import com.project.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {

    public List<Address> getAddressesByUserId(int userId) {
        List<Address> list = new ArrayList<>();

        String sql = "SELECT * FROM user_addresses "
                + "WHERE user_id = ? "
                + "ORDER BY is_default DESC, address_id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAddress(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Address getDefaultAddressByUserId(int userId) {

        Address address = null;

        String sql = "SELECT * FROM user_addresses "
                + "WHERE user_id = ? "
                + "ORDER BY is_default DESC, address_id DESC "
                + "LIMIT 1";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    address = mapAddress(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return address;
    }

    public void addAddress(Address address) {

        try (Connection conn = DBConnection.getConnection()) {

            if (address.isDefault()) {

                String reset
                        = "UPDATE user_addresses "
                        + "SET is_default = FALSE "
                        + "WHERE user_id = ?";

                try (PreparedStatement ps = conn.prepareStatement(reset)) {
                    ps.setInt(1, address.getUserId());
                    ps.executeUpdate();
                }
            }

            String sql
                    = "INSERT INTO user_addresses "
                    + "(user_id, full_name, phone, address_line, city, state, postcode, is_default) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, address.getUserId());
                ps.setString(2, address.getFullName());
                ps.setString(3, address.getPhone());
                ps.setString(4, address.getAddressLine());
                ps.setString(5, address.getCity());
                ps.setString(6, address.getState());
                ps.setString(7, address.getPostcode());
                ps.setBoolean(8, address.isDefault());

                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPrimaryAddress(int addressId, int userId) {

        try (Connection conn = DBConnection.getConnection()) {

            String reset
                    = "UPDATE user_addresses "
                    + "SET is_default = FALSE "
                    + "WHERE user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(reset)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            String setPrimary
                    = "UPDATE user_addresses "
                    + "SET is_default = TRUE "
                    + "WHERE address_id = ? AND user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(setPrimary)) {
                ps.setInt(1, addressId);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteAddress(int addressId, int userId) {

        String sql
                = "DELETE FROM user_addresses "
                + "WHERE address_id = ? AND user_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, addressId);
            ps.setInt(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Address getPrimaryAddress(int userId) {

        Address address = null;

        String sql
                = "SELECT * FROM user_addresses "
                + "WHERE user_id = ? "
                + "ORDER BY is_default DESC, address_id ASC "
                + "LIMIT 1";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    address = mapAddress(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return address;
    }

    private Address mapAddress(ResultSet rs) throws Exception {

        Address address = new Address();

        address.setAddressId(rs.getInt("address_id"));
        address.setUserId(rs.getInt("user_id"));
        address.setFullName(rs.getString("full_name"));
        address.setPhone(rs.getString("phone"));
        address.setAddressLine(rs.getString("address_line"));
        address.setCity(rs.getString("city"));
        address.setState(rs.getString("state"));
        address.setPostcode(rs.getString("postcode"));
        address.setDefault(rs.getBoolean("is_default"));

        return address;
    }
}
