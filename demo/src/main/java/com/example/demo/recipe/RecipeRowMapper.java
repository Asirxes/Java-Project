package com.example.demo.recipe;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RecipeRowMapper implements RowMapper<Recipe> {

    @Override
    public Recipe mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        Recipe recipe = new Recipe();
        recipe.setId(resultSet.getInt("id"));
        recipe.setName(resultSet.getString("name"));
        recipe.setText(resultSet.getString("text"));

        // File mapping
        Blob blob = resultSet.getBlob("file_data");
        if (blob != null) {
            byte[] fileData = blob.getBytes(1, (int) blob.length());
            MultipartFile file = new ByteArrayMultipartFile(fileData, resultSet.getString("file_name"));
            recipe.getFiles().add(file);
        }

        return recipe;
    }
}
