package com.example.demo.recipe;

import com.example.demo.product.Product;
import com.example.demo.recipe.Recipe;
import com.example.demo.recipe.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @GetMapping("/get/{recipeId}")
    public ResponseEntity<Recipe> getRecipeById(@PathVariable int recipeId) {
        try {
            Recipe recipe = recipeRepository.getRecipeById(recipeId);
            return new ResponseEntity<>(recipe, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/delete/{recipeId}")
    public ResponseEntity<String> deleteRecipeById(@PathVariable int recipeId) {
        try {
            recipeRepository.deleteRecipeById(recipeId);
            return new ResponseEntity<>("Przepis został pomyślnie usunięty", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Błąd podczas usuwania przepisu", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/update/{recipeId}")
    public ResponseEntity<String> updateRecipeById(@PathVariable int recipeId, @RequestBody Recipe updatedRecipe) {
        try {
            recipeRepository.updateRecipeById(recipeId, updatedRecipe);
            return new ResponseEntity<>("Przepis został pomyślnie zaktualizowany", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Błąd podczas aktualizacji przepisu", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/addProduct/{recipeId}")
    public ResponseEntity<String> addProductToRecipe(
            @PathVariable int recipeId,
            @RequestBody Product product) {
        try {
            recipeRepository.addProductToRecipe(recipeId, product);
            return new ResponseEntity<>("Produkt został pomyślnie dodany do przepisu", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Błąd podczas dodawania produktu do przepisu", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/getProducts/{recipeId}")
    public ResponseEntity<List<Product>> getProductsForRecipe(@PathVariable int recipeId) {
        try {
            List<Product> products = recipeRepository.getAllProductsForRecipe(recipeId);
            return new ResponseEntity<>(products, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
