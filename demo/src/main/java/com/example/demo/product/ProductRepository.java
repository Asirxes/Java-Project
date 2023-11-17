package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void addProduct(Product product, int userId) {
        String sqlProduct = "INSERT INTO product (name, quantity, unit) VALUES (?, ?, ?)";
        jdbcTemplate.update(sqlProduct, product.getName(), product.getQuantity(), product.getUnit());

        String sqlGetProductId = "SELECT MAX(id) FROM product";
        int productId = jdbcTemplate.queryForObject(sqlGetProductId, Integer.class);

        String sqlUserProduct = "INSERT INTO user_product (user_id, product_id) VALUES (?, ?)";
        jdbcTemplate.update(sqlUserProduct, userId, productId);
    }

    public List<Product> getAll(int userId) {
        String sql = "SELECT p.id, p.name, p.quantity, p.unit " +
                "FROM product p " +
                "JOIN user_product up ON p.id = up.product_id " +
                "WHERE up.user_id = ?";
        return jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(Product.class), userId);
    }

    public void deleteProduct(int id) {
        String sqlDeleteUserProduct = "DELETE FROM user_product WHERE product_id = ?";
        jdbcTemplate.update(sqlDeleteUserProduct, id);

        String sqlDeleteProduct = "DELETE FROM product WHERE id = ?";
        jdbcTemplate.update(sqlDeleteProduct, id);
    }
}
