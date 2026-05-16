package com.project.dao;

import com.project.model.Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {

    public List<Address> getAddressesByUserId(int userId) {
        List<Address> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM user_addresses WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Address address = new Address();
                address.setAddressId(rs.getInt("address_id"));
                address.setUserId(rs.getInt("user_id"));
                address.setFullName(rs.getString("full_name"));
                address.setPhone(rs.getString("phone"));
                address.setAddressLine(rs.getString("address_line"));
                address.setCity(rs.getString("city"));
                address.setState(rs.getString("state"));
                address.setPostcode(rs.getString("postcode"));
                address.setDefault(
                        rs.getBoolean("is_default")
                );

                list.add(address);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void addAddress(Address address) {

        try {
            Connection conn = DBConnection.getConnection();

            if (address.isDefault()) {

                String reset
                        = "UPDATE user_addresses SET is_default = FALSE WHERE user_id=?";

                PreparedStatement ps1
                        = conn.prepareStatement(reset);

                ps1.setInt(1, address.getUserId());
                ps1.executeUpdate();
            }

            String sql
                    = "INSERT INTO user_addresses "
                    + "(user_id,full_name,phone,address_line,city,state,postcode,is_default)"
                    + " VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps
                    = conn.prepareStatement(sql);

            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getFullName());
            ps.setString(3, address.getPhone());
            ps.setString(4, address.getAddressLine());
            ps.setString(5, address.getCity());
            ps.setString(6, address.getState());
            ps.setString(7, address.getPostcode());
            ps.setBoolean(8, address.isDefault());

            ps.executeUpdate();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void setPrimaryAddress(
            int addressId,
            int userId) {

        try {

            Connection conn
                    = DBConnection.getConnection();

            PreparedStatement reset
                    = conn.prepareStatement(
                            "UPDATE user_addresses SET is_default=FALSE WHERE user_id=?");

            reset.setInt(1, userId);
            reset.executeUpdate();

            PreparedStatement set
                    = conn.prepareStatement(
                            "UPDATE user_addresses SET is_default=TRUE WHERE address_id=?");

            set.setInt(1, addressId);
            set.executeUpdate();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void deleteAddress(int addressId, int userId) {
        try {
            Connection conn = DBConnection.getConnection();

            String sql = "DELETE FROM user_addresses WHERE address_id = ? AND user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, addressId);
            ps.setInt(2, userId);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
