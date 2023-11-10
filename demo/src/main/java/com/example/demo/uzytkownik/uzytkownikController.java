package com.example.demo.uzytkownik;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RequestMapping("/uzytkownik")
@RestController
public class uzytkownikController {
    @Autowired
    uzytkownikRepository uzytkownikRepository;
    @GetMapping("/{id}")
    public uzytkownik getById(@PathVariable int id) {
        return uzytkownikRepository.getById(id);
    }

    @PostMapping("/add")
    public void addUzytkownik(@RequestBody uzytkownik uzytkownik) {
        uzytkownikRepository.addUzytkownik(uzytkownik);
    }
}

