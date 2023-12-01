package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    @PostMapping("/add/{userId}")
    public void addProduct(@RequestBody Product product, @PathVariable int userId) {
        productRepository.addProduct(product, userId);
    }

    @DeleteMapping("/delete/{productId}")
    public void deleteProduct(@PathVariable int productId) {
        productRepository.deleteProduct(productId);
    }

    @GetMapping("/getAll/{userId}")
    public List<Product> getAllProductsByUserId(@PathVariable int userId) {
        return productRepository.getAllProductsByUserId(userId);
    }
}
