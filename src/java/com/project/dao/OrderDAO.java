package com.project.dao;

import com.project.model.Order;
import com.project.model.OrderItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
                + "WHERE userId = ? "
                + "ORDER BY createdAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Order order = new Order();

                    order.setOrderId(rs.getInt("orderId"));
                    order.setUserId(rs.getInt("userId"));
                    order.setOrderRef(rs.getString("orderRef"));
                    order.setTotalAmount(rs.getDouble("totalAmount"));
                    order.setPaymentStatus(rs.getString("paymentStatus"));
                    order.setBillCode(rs.getString("billCode"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setCreatedAt(rs.getTimestamp("createdAt"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT o.*, u.full_name, u.email "
                + "FROM orders o "
                + "LEFT JOIN users u ON o.userId = u.user_id "
                + "ORDER BY o.createdAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();

                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderRef(rs.getString("orderRef"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setBillCode(rs.getString("billCode"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setCreatedAt(rs.getTimestamp("createdAt"));

                order.setFullName(rs.getString("full_name"));
                order.setEmail(rs.getString("email"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public boolean updateStatus(int orderId, String status) {

        String sql =
                "UPDATE orders "
                + "SET orderStatus = ? "
                + "WHERE orderId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<OrderItem> getOrderItems(int orderId) {

        List<OrderItem> items = new ArrayList<>();

        String sql =
                "SELECT oi.*, p.product_name "
                + "FROM order_items oi "
                + "JOIN products p ON oi.product_id = p.product_id "
                + "WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    OrderItem item = new OrderItem();

                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));

                    items.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }
}