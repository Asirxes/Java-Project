package com.example.demo.recipe;

import com.example.demo.product.Product;
import com.example.demo.recipe.Recipe;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

@Repository
public class RecipeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void addRecipe(Recipe recipe, int userId) {
        String sqlInsertRecipe = "INSERT INTO recipe (name, text) VALUES (?, ?)";
        jdbcTemplate.update(sqlInsertRecipe, recipe.getName(), recipe.getText());

        String sqlRecipeId = "SELECT id FROM recipe WHERE name = ? AND text = ?";
        int recipeId = jdbcTemplate.queryForObject(sqlRecipeId, Integer.class, recipe.getName(), recipe.getText());

        String sqlInsertUserRecipe = "INSERT INTO recipe_user (user_id, recipe_id) VALUES (?, ?)";
        jdbcTemplate.update(sqlInsertUserRecipe, userId, recipeId);
    }

    public List<Recipe> getAllRecipesForUser(int userId) {
        String sql = "SELECT recipe.id, recipe.name, recipe.text " +
                "FROM recipe " +
                "INNER JOIN recipe_user ON recipe.id = recipe_user.recipe_id " +
                "WHERE recipe_user.user_id = ?";

        List<Recipe> recipes = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Recipe.class), userId);

        for (Recipe recipe : recipes) {
            List<Integer> productIds = getRecipeProductIds(recipe.getId());
            List<Product> products = getProductsByIds(productIds);
            recipe.setProducts(products);
        }

        return recipes;
    }

    public void deleteRecipeById(int recipeId) {
        String sqlDeleteUserRecipe = "DELETE FROM recipe_user WHERE recipe_id = ?";
        jdbcTemplate.update(sqlDeleteUserRecipe, recipeId);

        String sqlDeleteRecipeProduct = "DELETE FROM recipe_product WHERE recipe_id = ?";
        jdbcTemplate.update(sqlDeleteRecipeProduct, recipeId);

        String sqlDeleteRecipe = "DELETE FROM recipe WHERE id = ?";
        jdbcTemplate.update(sqlDeleteRecipe, recipeId);
    }

    public void updateRecipeById(int recipeId, Recipe updatedRecipe) {
        String sqlUpdateRecipe = "UPDATE recipe SET name = ?, text = ? WHERE id = ?";
        jdbcTemplate.update(sqlUpdateRecipe, updatedRecipe.getName(), updatedRecipe.getText(), recipeId);
    }

    private List<Integer> getRecipeProductIds(int recipeId) {
        String sql = "SELECT product_id FROM recipe_product WHERE recipe_id = ?";
        return jdbcTemplate.queryForList(sql, Integer.class, recipeId);
    }

    private List<Product> getProductsByIds(List<Integer> productIds) {
        if (productIds.isEmpty()) {
            return List.of();
        }

        String placeholders = String.join(",", Collections.nCopies(productIds.size(), "?"));

        String sql = "SELECT * FROM product WHERE id IN (" + placeholders + ")";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class), productIds.toArray());
    }
    public Recipe getRecipeById(int recipeId) {
        String sql = "SELECT id, name, text FROM recipe WHERE id = ?";
        Recipe recipe = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Recipe.class), recipeId);

        if (recipe != null) {
            List<Integer> productIds = getRecipeProductIds(recipeId);
            List<Product> products = getProductsByIds(productIds);
            recipe.setProducts(products);
        }

        return recipe;
    }
}
