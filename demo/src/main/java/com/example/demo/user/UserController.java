package com.example.demo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/add")
    public void addUser(@RequestBody User user) {
        userRepository.addUser(user);
    }

    @PostMapping("/changePassword/{userId}")
    public void changePassword(@PathVariable int userId, @RequestParam String newPassword) {
        userRepository.changePassword(userId, newPassword);
    }

    @PostMapping("/login")
    public boolean login(@RequestParam String email, @RequestParam String password) {
        return userRepository.login(email, password);
    }

    @DeleteMapping("/delete/{userId}")
    public void deleteUser(@PathVariable int userId) {
        userRepository.deleteUser(userId);
    }
}
