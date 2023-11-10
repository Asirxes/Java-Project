package com.example.demo.uzytkownik;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class uzytkownik {
    private int id;
    private String email;
    private String haslo;
    private List<Integer> listaProduktow;
}

