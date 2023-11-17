package com.example.demo.przepis;

import com.example.demo.produkt.produkt;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class przepis {
    public int id;
    public String name;
    public String text;
    public List<produkt> produkty;
    public List<MultipartFile> files;
}
