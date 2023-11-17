package com.example.demo.przepis;

import com.example.demo.przepis.przepis;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

public class przepisRowMapper implements RowMapper<przepis> {

    @Override
    public przepis mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        przepis przepis = new przepis();
        przepis.setId(resultSet.getInt("id"));
        przepis.setName(resultSet.getString("name"));
        przepis.setText(resultSet.getString("text"));

        // Mapowanie plików
        Blob blob = resultSet.getBlob("file_data");
        if (blob != null) {
            byte[] fileData = blob.getBytes(1, (int) blob.length());
            MultipartFile file = new ByteArrayMultipartFile(fileData, resultSet.getString("file_name"));
            przepis.getFiles().add(file);
        }

        // Dodaj mapowanie innych pól, jeśli istnieją

        return przepis;
    }
}
