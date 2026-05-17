package com.project.dao;

import com.project.model.CartItem;
import com.project.model.Order;
import com.project.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================
    // CREATE ORDER
    // =========================
    public int createOrder(int userId,
                           double totalAmount,
                           List<CartItem> cartItems) {

        String orderSQL =
        "INSERT INTO orders(user_id,total_amount,order_status,order_date) "
      + "VALUES(?,?,?,NOW())";

        String itemSQL =
        "INSERT INTO order_items(order_id,product_id,quantity,price) "
      + "VALUES(?,?,?,?)";

        Connection conn = null;

        try {

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int orderId = 0;

            PreparedStatement orderPs =
                    conn.prepareStatement(
                            orderSQL,
                            Statement.RETURN_GENERATED_KEYS
                    );

            orderPs.setInt(1, userId);
            orderPs.setDouble(2, totalAmount);
            orderPs.setString(3, "Processing");

            orderPs.executeUpdate();

            ResultSet keys = orderPs.getGeneratedKeys();

            if (keys.next()) {
                orderId = keys.getInt(1);
            }

            for (CartItem item : cartItems) {

                PreparedStatement itemPs =
                        conn.prepareStatement(itemSQL);

                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getProductId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getPrice());

                itemPs.executeUpdate();

                // reduce stock
                PreparedStatement stockPs =
                        conn.prepareStatement(
                                "UPDATE products "
                              + "SET stock_quantity=stock_quantity-? "
                              + "WHERE product_id=?"
                        );

                stockPs.setInt(1,
                        item.getQuantity());

                stockPs.setInt(2,
                        item.getProductId());

                stockPs.executeUpdate();
            }

            conn.commit();

            return orderId;

        } catch (Exception e) {

            e.printStackTrace();

            try {
                if (conn != null)
                    conn.rollback();

            } catch (Exception ex) {
                ex.printStackTrace();
            }

        } finally {

            try {

                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        return 0;
    }


    // =========================
    // USER ORDERS
    // =========================
    public List<Order> getOrdersByUserId(int userId){

        List<Order> orders =
                new ArrayList<>();

        String sql =
        "SELECT * FROM orders "
      + "WHERE user_id=? "
      + "ORDER BY order_date DESC";

        try(Connection conn =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    conn.prepareStatement(sql)) {

            ps.setInt(1,userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Order order =
                        new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setTotalAmount(
                        rs.getDouble(
                                "total_amount"));

                order.setOrderStatus(
                        rs.getString(
                                "order_status"));

                order.setOrderDate(
                        rs.getTimestamp(
                                "order_date"));

                orders.add(order);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return orders;
    }


    // =========================
    // ADMIN VIEW ALL ORDERS
    // =========================
    public List<Order> getAllOrders(){

        List<Order> orders =
                new ArrayList<>();

        String sql =
        "SELECT * FROM orders "
      + "ORDER BY order_date DESC";

        try(Connection conn =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()){

            while(rs.next()){

                Order order =
                        new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setTotalAmount(
                        rs.getDouble(
                                "total_amount"));

                order.setOrderStatus(
                        rs.getString(
                                "order_status"));

                order.setOrderDate(
                        rs.getTimestamp(
                                "order_date"));

                orders.add(order);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return orders;
    }


    // =========================
    // UPDATE STATUS
    // =========================
    public boolean updateStatus(
            int orderId,
            String status){

        String sql =
        "UPDATE orders "
      + "SET order_status=? "
      + "WHERE order_id=?";

        try(Connection conn =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    conn.prepareStatement(sql)){

            ps.setString(1,status);
            ps.setInt(2,orderId);

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;
    }


    // =========================
    // ORDER ITEMS
    // =========================
    public List<OrderItem>
        getOrderItems(int orderId){

        List<OrderItem> items =
                new ArrayList<>();

        String sql =
        "SELECT oi.*, "
      + "p.product_name "
      + "FROM order_items oi "
      + "JOIN products p "
      + "ON oi.product_id=p.product_id "
      + "WHERE order_id=?";

        try(Connection conn =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    conn.prepareStatement(sql)){

            ps.setInt(1,orderId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                OrderItem item =
                        new OrderItem();

                item.setOrderItemId(
                        rs.getInt(
                                "order_item_id"));

                item.setOrderId(
                        rs.getInt(
                                "order_id"));

                item.setProductId(
                        rs.getInt(
                                "product_id"));

                item.setProductName(
                        rs.getString(
                                "product_name"));

                item.setQuantity(
                        rs.getInt(
                                "quantity"));

                item.setPrice(
                        rs.getDouble(
                                "price"));

                items.add(item);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return items;
    }

}