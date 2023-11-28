package com.example.demo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

@Repository
public class UserRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void addUser(User user) {
        String sqlInsertUser = "INSERT INTO User (email, password) VALUES (?, ?)";
        jdbcTemplate.update(sqlInsertUser, user.getEmail(), user.getPassword());
    }

    public void changePassword(int userId, String newPassword) {
        String sqlUpdatePassword = "UPDATE User SET password = ? WHERE id = ?";
        jdbcTemplate.update(sqlUpdatePassword, newPassword, userId);
    }

    public boolean login(String email, String password) {
        String sqlLogin = "SELECT COUNT(*) FROM User WHERE email = ? AND password = ?";
        int count = Objects.requireNonNull(jdbcTemplate.queryForObject(sqlLogin, Integer.class, email, password));
        return count > 0;
    }

    public void deleteUser(int userId) {
        String sqlDeleteRecipeUser = "DELETE FROM Recipe_User WHERE user_id = ?";
        jdbcTemplate.update(sqlDeleteRecipeUser, userId);

        String sqlDeleteProductUser = "DELETE FROM Product_User WHERE user_id = ?";
        jdbcTemplate.update(sqlDeleteProductUser, userId);

        String sqlDeleteUser = "DELETE FROM User WHERE id = ?";
        jdbcTemplate.update(sqlDeleteUser, userId);
    }
}
