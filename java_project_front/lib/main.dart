import 'package:flutter/material.dart';
import 'package:java_project_front/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 125, 136)),
        useMaterial3: true,
      ),
      home: const HomePage(
        isUserLoggedIn: false,
        userId: 0,
      ),
    );
  }
}