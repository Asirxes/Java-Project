package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/product")
@CrossOrigin(origins = "*")
@RestController
public class ProductController {
    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/{userId}")
    public List<Product> getAll(@PathVariable int userId) {
        return productRepository.getAll(userId);
    }

    @PostMapping("/add/{userId}")
    public void addProduct(@RequestBody Product product, @PathVariable int userId) {
        productRepository.addProduct(product, userId);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteProduct(@PathVariable int id) {
        productRepository.deleteProduct(id);
    }
}
