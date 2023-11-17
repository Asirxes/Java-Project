package com.example.demo.recipe;

import com.example.demo.product.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Repository
public class RecipeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional
    public void addRecipe(Recipe recipe, int userId) {
        String sqlRecipe = "INSERT INTO recipe (name, text) VALUES (?, ?)";
        jdbcTemplate.update(sqlRecipe, recipe.getName(), recipe.getText());

        String sqlGetRecipeId = "SELECT MAX(id) FROM recipe";
        int recipeId = jdbcTemplate.queryForObject(sqlGetRecipeId, Integer.class);

        String sqlRecipeUser = "INSERT INTO recipe_user (recipe_id, user_id) VALUES (?, ?)";
        jdbcTemplate.update(sqlRecipeUser, recipeId, userId);

        for (Product p : recipe.getProducts()) {
            String sqlRecipeProduct = "INSERT INTO recipe_product (recipe_id, product_id) VALUES (?, ?)";
            jdbcTemplate.update(sqlRecipeProduct, recipeId, p.getId());
        }
    }

    @Transactional
    public void addFileToRecipe(int recipeId, MultipartFile file) throws IOException {
        String sqlInsertFile = "INSERT INTO recipe_files (recipe_id, file_name, file_data) VALUES (?, ?, ?)";
        jdbcTemplate.update(sqlInsertFile, recipeId, file.getOriginalFilename(), file.getBytes());
    }

    @Transactional
    public void deleteFileFromRecipe(int recipeId, int fileId) {
        String sqlDeleteFile = "DELETE FROM recipe_files WHERE recipe_id = ? AND id = ?";
        jdbcTemplate.update(sqlDeleteFile, recipeId, fileId);
    }

    public List<Recipe> getAllRecipesForUser(int userId) {
        String sql = "SELECT r.id, r.name, r.text " +
                "FROM recipe r " +
                "JOIN recipe_user ru ON r.id = ru.recipe_id " +
                "WHERE ru.user_id = ?";
        return jdbcTemplate.query(sql, new RecipeRowMapper(), userId);
    }
}
