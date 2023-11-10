package com.example.demo.produkt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/produkt")
@CrossOrigin(origins = "*")
@RestController
public class produktController {
    @Autowired
    private produktRepository produktRepository;

    @GetMapping("/{userId}")
    public List<produkt> getAll(@PathVariable int userId) {
        return produktRepository.getAll(userId);
    }

    @PostMapping("/add/{userId}")
    public void addProdukt(@RequestBody produkt produkt, @PathVariable int userId) {
        produktRepository.addProdukt(produkt, userId);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteProdukt(@PathVariable int id) {
        produktRepository.deleteProdukt(id);
    }
}
