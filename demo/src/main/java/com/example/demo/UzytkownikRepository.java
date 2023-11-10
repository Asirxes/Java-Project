package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public class uzytkownikRepository {
    @Autowired
    JdbcTemplate jdbcTemplate;
    public List<uzytkownik> getAll(){
        return jdbcTemplate.query("SELECT id, email, password", BeanPropertyRowMapper.newInstance(uzytkownik.class));
    }
}
