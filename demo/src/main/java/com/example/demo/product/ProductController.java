package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    @PostMapping("/add")
    public void addProduct(@RequestBody Product product, @RequestParam int userId) {
        productRepository.addProduct(product, userId);
    }

    @DeleteMapping("/delete/{productId}")
    public void deleteProduct(@PathVariable int productId) {
        productRepository.deleteProduct(productId);
    }
}
