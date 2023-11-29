import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/logowanie.dart';
import '../Accont/rejestracja.dart';

class EkranGlowny extends StatefulWidget {
  const EkranGlowny({Key? key}) : super(key: key);

  @override
  State<EkranGlowny> createState() => _EkranGlownyState();
}

class _EkranGlownyState extends State<EkranGlowny> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/Assets/logo.png'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Logowanie()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(300, 0),
              ),
              child: Text('Zaloguj się'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rejestracja()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(300, 0),
              ),
              child: Text('Zarejestruj się'),
            ),
          ],
        ),
      ),
    );
  }
}
