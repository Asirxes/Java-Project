package com.example.demo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class produkt {
    public int id;
    public String name;
    public double quantity;
    public int unit;
}

