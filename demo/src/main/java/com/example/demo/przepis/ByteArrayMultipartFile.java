package com.example.demo.przepis;

import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public class ByteArrayMultipartFile implements MultipartFile {

    private final byte[] content;
    private final String name;

    public ByteArrayMultipartFile(byte[] content, String name) {
        this.content = content;
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getOriginalFilename() {
        return name;
    }

    @Override
    public String getContentType() {
        // Określ odpowiedni Content-Type w zależności od rozszerzenia pliku, jeśli to konieczne
        return "application/octet-stream";
    }

    @Override
    public boolean isEmpty() {
        return content.length == 0;
    }

    @Override
    public long getSize() {
        return content.length;
    }

    @Override
    public byte[] getBytes() throws IOException {
        return content;
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new ByteArrayInputStream(content);
    }

    @Override
    public void transferTo(File dest) throws IOException, IllegalStateException {

    }

    @Override
    public void transferTo(java.nio.file.Path dest) throws IOException, IllegalStateException {
        // Implementuj, jeśli to konieczne
    }
}
