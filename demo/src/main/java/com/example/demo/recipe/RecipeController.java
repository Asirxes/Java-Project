package com.example.demo.recipe;

import com.example.demo.recipe.Recipe;
import com.example.demo.recipe.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recipes")
public class RecipeController {

    @Autowired
    private RecipeRepository recipeRepository;

    @PostMapping("/add/{userId}")
    public void addRecipe(@RequestBody Recipe recipe, @PathVariable int userId) {
        recipeRepository.addRecipe(recipe, userId);
    }

    @GetMapping("/getAll/{userId}")
    public List<Recipe> getAllRecipesForUser(@PathVariable int userId) {
        return recipeRepository.getAllRecipesForUser(userId);
    }
}
