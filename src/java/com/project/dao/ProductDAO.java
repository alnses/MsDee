package com.project.dao;

import com.project.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE is_active = 1 ORDER BY product_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE category = ? AND is_active = 1 ORDER BY product_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductById(int productId) {
        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products "
                + "(product_name, category, description, price, stock_quantity, image_url, is_active) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStockQuantity());
            ps.setString(6, product.getImageUrl());
            ps.setBoolean(7, product.isActive());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET product_name = ?, category = ?, description = ?, "
                + "price = ?, stock_quantity = ?, image_url = ?, is_active = ? "
                + "WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStockQuantity());
            ps.setString(6, product.getImageUrl());
            ps.setBoolean(7, product.isActive());
            ps.setInt(8, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteProduct(int productId) {
        String sql = "UPDATE products SET is_active = 0 WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean reduceStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock_quantity = stock_quantity - ? "
                + "WHERE product_id = ? AND stock_quantity >= ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();

        product.setProductId(rs.getInt("product_id"));
        product.setProductName(rs.getString("product_name"));
        product.setCategory(rs.getString("category"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setImageUrl(rs.getString("image_url"));
        product.setActive(rs.getBoolean("is_active"));

        return product;
    }
    
    public boolean updateStock(int productId, int stockQuantity) {
    String sql = "UPDATE products SET stock_quantity = ? WHERE product_id = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, stockQuantity);
        ps.setInt(2, productId);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
}

