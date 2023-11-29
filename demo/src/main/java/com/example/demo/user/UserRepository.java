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

    public int addUser(User user) {
        String sqlInsertUser = "INSERT INTO User (email, password) VALUES (?, ?)";
        jdbcTemplate.update(sqlInsertUser, user.getEmail(), user.getPassword());

        String sqlSelectUserId = "SELECT id FROM User WHERE email = ? AND password = ?";
        return jdbcTemplate.queryForObject(sqlSelectUserId, new Object[]{user.getEmail(), user.getPassword()}, Integer.class);
    }

    public void changePassword(int userId, String newPassword) {
        String sqlUpdatePassword = "UPDATE User SET password = ? WHERE id = ?";
        jdbcTemplate.update(sqlUpdatePassword, newPassword, userId);
    }

    public int login(String email, String password) {
        String sqlLogin = "SELECT id FROM User WHERE email = ? AND password = ?";

        try {
            return Objects.requireNonNull(jdbcTemplate.queryForObject(sqlLogin, Integer.class, email, password));
        } catch (NullPointerException e) {
            return 0;
        }
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
