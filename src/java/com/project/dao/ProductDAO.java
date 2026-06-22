package com.project.dao;

import com.project.model.Product;
import com.project.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ProductDAO {
    public void addProduct(Product p) {
    String sql = "INSERT INTO products (product_name, category, description, price, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, p.getProductName());
        pstmt.setString(2, p.getCategory());
        pstmt.setString(3, p.getDescription());
        pstmt.setDouble(4, p.getPrice());
        pstmt.setInt(5, p.getStockQuantity());
        pstmt.setString(6, p.getImageUrl());
        pstmt.executeUpdate();
    } catch (SQLException e) { e.printStackTrace(); }
}

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                list.add(p);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    public List<Product> getProductsByCategory(String category) {
    List<Product> list = new ArrayList<>();
    String sql = "SELECT * FROM products WHERE category = ?";
    try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, category);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setProductId(rs.getInt("product_id"));
            p.setProductName(rs.getString("product_name"));
            p.setCategory(rs.getString("category"));
            p.setPrice(rs.getDouble("price"));
            p.setStockQuantity(rs.getInt("stock_quantity"));
            list.add(p);
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return list;
}
  
    public void updateStock(int productId, int stock) {
    String sql = "UPDATE products SET stock_quantity = ? WHERE product_id = ?";
    try (Connection conn = DBConnection.getConnection(); 
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setInt(1, stock);
        pstmt.setInt(2, productId);
        pstmt.executeUpdate();
    } catch (SQLException e) { 
        e.printStackTrace(); 
    }

}
    
    public int getTotalProductCount() {
    String sql = "SELECT COUNT(*) FROM products";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

public int getLowStockCount() {
    // Assuming low stock means less than 10 units
    String sql = "SELECT COUNT(*) FROM products WHERE stock_quantity < 10";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

}
    
