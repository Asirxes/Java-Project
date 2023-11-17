package com.example.demo.przepis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/przepisy/{userId}")
public class PrzepisController {

    @Autowired
    private przepisRepository przepisRepository;

    @PostMapping("/dodaj")
    public ResponseEntity<String> dodajPrzepis(@PathVariable int userId, @RequestBody przepis przepis) {
        try {
            przepisRepository.addPrzepis(przepis, userId);
            return ResponseEntity.ok("Przepis dodany pomyślnie dla użytkownika o ID: " + userId);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Błąd podczas dodawania przepisu.");
        }
    }

    @PostMapping("/dodajPlik/{przepisId}")
    public ResponseEntity<String> dodajPlikDoPrzepisu(@PathVariable int userId, @PathVariable int przepisId, @RequestParam("file") MultipartFile file) {
        try {
            przepisRepository.addFileToPrzepis(przepisId, file);
            return ResponseEntity.ok("Plik dodany pomyślnie dla użytkownika o ID: " + userId);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Błąd podczas dodawania pliku.");
        }
    }

    @DeleteMapping("/usunPlik/{przepisId}/{fileId}")
    public ResponseEntity<String> usunPlikZPrzepisu(@PathVariable int userId, @PathVariable int przepisId, @PathVariable int fileId) {
        try {
            przepisRepository.deleteFileFromPrzepis(przepisId, fileId);
            return ResponseEntity.ok("Plik usunięty pomyślnie dla użytkownika o ID: " + userId);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Błąd podczas usuwania pliku.");
        }
    }

    @GetMapping("/wszystkie")
    public ResponseEntity<List<przepis>> wszystkiePrzepisyDlaUzytkownika(@PathVariable int userId) {
        List<przepis> przepisy = przepisRepository.getAllPrzepisyForUser(userId);
        return ResponseEntity.ok(przepisy);
    }
}
