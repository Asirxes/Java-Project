package com.example.demo.recipe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/recipes/{userId}")
public class RecipeController {

    @Autowired
    private RecipeRepository recipeRepository;

    @PostMapping("/add")
    public ResponseEntity<String> addRecipe(@PathVariable int userId, @RequestBody Recipe recipe) {
        try {
            recipeRepository.addRecipe(recipe, userId);
            return ResponseEntity.ok("Recipe added successfully for user with ID: " + userId);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error adding recipe.");
        }
    }

    @PostMapping("/addFile/{recipeId}")
    public ResponseEntity<String> addFileToRecipe(@PathVariable int userId, @PathVariable int recipeId, @RequestParam("file") MultipartFile file) {
        try {
            recipeRepository.addFileToRecipe(recipeId, file);
            return ResponseEntity.ok("File added successfully for user with ID: " + userId);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error adding file.");
        }
    }

    @DeleteMapping("/deleteFile/{recipeId}/{fileId}")
    public ResponseEntity<String> deleteFileFromRecipe(@PathVariable int userId, @PathVariable int recipeId, @PathVariable int fileId) {
        try {
            recipeRepository.deleteFileFromRecipe(recipeId, fileId);
            return ResponseEntity.ok("File deleted successfully for user with ID: " + userId);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting file.");
        }
    }

    @GetMapping("/all")
    public ResponseEntity<List<Recipe>> getAllRecipesForUser(@PathVariable int userId) {
        List<Recipe> recipes = recipeRepository.getAllRecipesForUser(userId);
        return ResponseEntity.ok(recipes);
    }
}
