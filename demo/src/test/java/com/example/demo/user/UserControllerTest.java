package com.example.demo.user;

import com.example.demo.user.User;
import com.example.demo.user.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.Collections;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class UserControllerTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserController userController;

    private MockMvc mockMvc;

    @Test
    void testAddUser() throws Exception {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();

        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("password");

        when(userRepository.addUser(any(User.class))).thenReturn(1);

        mockMvc.perform(post("/api/users/add")
                        .content(asJsonString(user))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string("1"));

        verify(userRepository, times(1)).addUser(any(User.class));
    }

    @Test
    void testChangePassword() throws Exception {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();

        int userId = 1;
        String newPassword = "newPassword";
        User user = new User();
        user.setPassword(newPassword);

        mockMvc.perform(post("/api/users/changePassword/{userId}", userId)
                        .content(asJsonString(user))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());

        verify(userRepository, times(1)).changePassword(userId, newPassword);
    }

    @Test
    void testGetAllUsers() throws Exception {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();

        when(userRepository.getAllUsers()).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/api/users/getAll"))
                .andExpect(status().isOk())
                .andExpect(content().json("[]"));

        verify(userRepository, times(1)).getAllUsers();
    }

    private static String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
