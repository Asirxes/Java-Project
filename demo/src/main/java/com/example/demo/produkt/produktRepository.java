package com.example.demo.produkt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class produktRepository {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public void addProdukt(produkt produkt, int userId) {
        String sqlProdukt = "INSERT INTO produkt (name, quantity, unit) VALUES (?, ?, ?)";
        jdbcTemplate.update(sqlProdukt, produkt.getName(), produkt.getQuantity(), produkt.getUnit());

        String sqlGetProductId = "SELECT MAX(id) FROM produkt";
        int productId = jdbcTemplate.queryForObject(sqlGetProductId, Integer.class);

        String sqlUserProdukt = "INSERT INTO uzytkownik_produkt (uzytkownik_id, produkt_id) VALUES (?, ?)";
        jdbcTemplate.update(sqlUserProdukt, userId, productId);
    }

    public List<produkt> getAll(int userId) {
        String sql = "SELECT p.id, p.name, p.quantity, p.unit " +
                "FROM produkt p " +
                "JOIN uzytkownik_produkt up ON p.id = up.produkt_id " +
                "WHERE up.uzytkownik_id = ?";
        return jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(produkt.class), userId);
    }

    public void deleteProdukt(int id) {
        String sqlDeleteUserProdukt = "DELETE FROM uzytkownik_produkt WHERE produkt_id = ?";
        jdbcTemplate.update(sqlDeleteUserProdukt, id);

        String sqlDeleteProdukt = "DELETE FROM produkt WHERE id = ?";
        jdbcTemplate.update(sqlDeleteProdukt, id);
    }
}
