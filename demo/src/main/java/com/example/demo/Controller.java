package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RequestMapping("/uzytkownik")
@RestController
public class Controller {
    @Autowired
    uzytkownikRepository uzytkownikRepository;
    @GetMapping("/")
    public List<uzytkownik> getAll(){
        return uzytkownikRepository.getAll();
    }

}

