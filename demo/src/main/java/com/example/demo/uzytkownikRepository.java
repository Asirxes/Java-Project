package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class uzytkownikRepository {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public uzytkownik getById(int id) {
        String sql = "SELECT id, email, haslo FROM uzytkownik WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, BeanPropertyRowMapper.newInstance(uzytkownik.class));
    }

    public void addUzytkownik(uzytkownik uzytkownik) {
        String sql = "INSERT INTO uzytkownik (email, haslo) VALUES (?, ?)";
        jdbcTemplate.update(sql, uzytkownik.getEmail(), uzytkownik.getHaslo());
    }

}