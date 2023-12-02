package com.example.demo.user;

import com.example.demo.user.User;
import com.example.demo.user.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class UserControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private UserRepository userRepository;

    @Test
    void testAddUserIntegration() throws Exception {
        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("password");

        String result = mockMvc.perform(MockMvcRequestBuilders.post("/api/users/add")
                        .content(asJsonString(user))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();

        assertNotNull(result);
        assertTrue(result.length() > 0);

        int userId = userRepository.login("test@example.com", "password");
        assertTrue(userId > 0);
    }

    @Test
    void testChangePasswordIntegration() throws Exception {
        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("password");
        int userId = userRepository.addUser(user);

        String newPassword = "newPassword";
        user.setPassword(newPassword);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/users/changePassword/{userId}", userId)
                        .content(asJsonString(user))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());

        User updatedUser = userRepository.findById(userId);
        assertEquals(newPassword, updatedUser.getPassword());
    }

    @Test
    void testGetAllUsersIntegration() throws Exception {
        User user1 = new User();
        user1.setEmail("user1@example.com");
        user1.setPassword("password1");
        userRepository.addUser(user1);

        User user2 = new User();
        user2.setEmail("user2@example.com");
        user2.setPassword("password2");
        userRepository.addUser(user2);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/users/getAll"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].email").value("user1@example.com"))
                .andExpect(jsonPath("$[1].email").value("user2@example.com"));
    }

    private static String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
