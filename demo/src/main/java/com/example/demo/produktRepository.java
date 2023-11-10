package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class produktRepository {
    @Autowired
    JdbcTemplate jdbcTemplate;


    public produkt getById(int id) {
        String sql = "SELECT id, name, quantity, unit FROM uzytkownik WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, BeanPropertyRowMapper.newInstance(produkt.class));
    }

    public void addProdukt(produkt produkt) {
        String sql = "INSERT INTO produkt (name, quantity, unit) VALUES (?, ?,?)";
        jdbcTemplate.update(sql, produkt.getName(), produkt.getQuantity(),produkt.getUnit());
    }

    public List<produkt> getAll() {
        String sql = "SELECT id, name, quantity, unit FROM produkt";
        return jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(produkt.class));
    }

    public void deleteProdukt(int id) {
        String sql = "DELETE FROM produkt WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
