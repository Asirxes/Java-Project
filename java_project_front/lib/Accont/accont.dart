import 'package:flutter/material.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/Rejestracja/rejestracja.dart';

class accont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold( 
  appBar: AppBar(
        title: Text('konto'),
      ),  
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rejestracja()),
                );
              },
              child: Text('Wyloguj'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rejestracja()),
                );
              },
              child: Text('Zmień hasło'),
            ),      
          ],
        ),
      ),
    );
  }
}


