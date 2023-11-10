package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/produkt")
@RestController
public class produktController {
    @Autowired
    private produktRepository produktRepository;

    @GetMapping("/{id}")
    public produkt getById(@PathVariable int id) {
        return produktRepository.getById(id);
    }

    @GetMapping("/")
    public List<produkt> getAll() {
        return produktRepository.getAll();
    }

    @PostMapping("/add")
    public void addProdukt(@RequestBody produkt produkt) {
        produktRepository.addProdukt(produkt);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteProdukt(@PathVariable int id) {
        produktRepository.deleteProdukt(id);
    }
}
