package com.example.demo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/user")
@CrossOrigin(origins = "*")
@RestController
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/{id}")
    public User getById(@PathVariable int id) {
        return userRepository.getById(id);
    }

    @PostMapping("/add")
    public void addUser(@RequestBody User user) {
        userRepository.addUser(user);
    }

    @PutMapping("/changePassword/{id}")
    public void changePassword(@PathVariable int id, @RequestBody String newPassword) {
        userRepository.changePassword(id, newPassword);
    }
}