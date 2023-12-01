package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

@Repository
public class ProductRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void addProduct(Product product, int userId) {
        String sqlInsertProduct = "INSERT INTO Product (name, quantity, unit) VALUES (?, ?, ?)";
        jdbcTemplate.update(sqlInsertProduct, product.getName(), product.getQuantity(), product.getUnit());

        String sqlProductId = "SELECT id FROM Product WHERE name = ? AND quantity = ? AND unit = ?";
        int productId = Objects.requireNonNull(jdbcTemplate.queryForObject(sqlProductId, Integer.class,
                product.getName(), product.getQuantity(), product.getUnit()));

        String sqlInsertProductUser = "INSERT INTO Product_User (product_id, user_id) VALUES (?, ?)";
        jdbcTemplate.update(sqlInsertProductUser, productId, userId);
    }

    public List<Product> getAllProductsByUserId(int userId) {
        String sqlSelectProducts = "SELECT p.id, p.name, p.quantity, p.unit " +
                "FROM Product p " +
                "JOIN Product_User pu ON p.id = pu.product_id " +
                "WHERE pu.user_id = ?";
        return jdbcTemplate.query(sqlSelectProducts, new BeanPropertyRowMapper<>(Product.class), userId);
    }

    public void deleteProduct(int productId) {
        String sqlDeleteProductUser = "DELETE FROM Product_User WHERE product_id = ?";
        jdbcTemplate.update(sqlDeleteProductUser, productId);

        String sqlDeleteProduct = "DELETE FROM Product WHERE id = ?";
        jdbcTemplate.update(sqlDeleteProduct, productId);
    }
}
