package com.example.demo.przepis;

import com.example.demo.produkt.produkt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Repository
public class przepisRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional
    public void addPrzepis(przepis przepis, int userId) {
        String sqlPrzepis = "INSERT INTO przepis (name, text) VALUES (?, ?)";
        jdbcTemplate.update(sqlPrzepis, przepis.getName(), przepis.getText());

        String sqlGetPrzepisId = "SELECT MAX(id) FROM przepis";
        int przepisId = jdbcTemplate.queryForObject(sqlGetPrzepisId, Integer.class);

        String sqlPrzepisUzytkownik = "INSERT INTO przepis_uzytkownik (id_przepisu, id_uzytkownika) VALUES (?, ?)";
        jdbcTemplate.update(sqlPrzepisUzytkownik, przepisId, userId);

        for (produkt p : przepis.getProdukty()) {
            String sqlPrzepisProdukt = "INSERT INTO przepis_produkt (id_przepisu, id_produktu) VALUES (?, ?)";
            jdbcTemplate.update(sqlPrzepisProdukt, przepisId, p.getId());
        }
    }

    @Transactional
    public void addFileToPrzepis(int przepisId, MultipartFile file) throws IOException {
        String sqlInsertFile = "INSERT INTO przepis_files (przepis_id, file_name, file_data) VALUES (?, ?, ?)";
        jdbcTemplate.update(sqlInsertFile, przepisId, file.getOriginalFilename(), file.getBytes());
    }

    @Transactional
    public void deleteFileFromPrzepis(int przepisId, int fileId) {
        String sqlDeleteFile = "DELETE FROM przepis_files WHERE przepis_id = ? AND id = ?";
        jdbcTemplate.update(sqlDeleteFile, przepisId, fileId);
    }

    public List<przepis> getAllPrzepisyForUser(int userId) {
        String sql = "SELECT p.id, p.name, p.text " +
                "FROM przepis p " +
                "JOIN przepis_uzytkownik pu ON p.id = pu.id_przepisu " +
                "WHERE pu.id_uzytkownika = ?";
        return jdbcTemplate.query(sql, new przepisRowMapper(), userId);
    }
}
