package com.project.dao;

import com.project.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User getUserById(int userId) {
        User user = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setMemberSince(rs.getString("member_since"));
                user.setTotalSpent(rs.getDouble("total_spent"));
                user.setMembershipTier(rs.getString("membership_tier"));
                user.setDiscount(rs.getInt("discount"));
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public void updateMembership(int userId, double totalSpent) {
        String tier = "Bronze";
        int discount = 0;

        if (totalSpent >= 5000) {
            tier = "Platinum";
            discount = 15;
        } else if (totalSpent >= 2000) {
            tier = "Gold";
            discount = 10;
        } else if (totalSpent >= 500) {
            tier = "Silver";
            discount = 5;
        }

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "UPDATE users SET total_spent = ?, membership_tier = ?, discount = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setDouble(1, totalSpent);
            ps.setString(2, tier);
            ps.setInt(3, discount);
            ps.setInt(4, userId);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean updateProfile(int userId, String fullName, String email, String phone) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setInt(4, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
