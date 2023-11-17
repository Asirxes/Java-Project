import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/password.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/home_screen/home_screen.dart';

class accont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('konto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EkranGlowny()),//dodaj funkcje wylogowania oprucz przeniesienia
                );
              },
              child: Text('Wyloguj'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZmianaHasla()),
                );
              },
              child: Text('Zmień hasło'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
