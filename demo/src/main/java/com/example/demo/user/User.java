package com.example.demo.user;

import com.example.demo.product.Product;
import com.example.demo.recipe.Recipe;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int id;
    private String email;
    private String password;
    private List<Recipe> recipes;
    private List<Product> products;
}