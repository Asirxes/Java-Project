package com.example.demo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/add")
    public int addUser(@RequestBody User user) {
        return userRepository.addUser(user);
    }

    @PostMapping("/changePassword/{userId}")
    public void changePassword(@PathVariable int userId, @RequestBody User user) {
        userRepository.changePassword(userId, user.getPassword());
    }

    @PostMapping("/login")
    public int login(@RequestBody User user) {
        String email = user.getEmail();
        String password = user.getPassword();
        return userRepository.login(email, password);
    }

    @DeleteMapping("/delete/{userId}")
    public void deleteUser(@PathVariable int userId) {
        userRepository.deleteUser(userId);
    }
}
