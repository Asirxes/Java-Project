import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Logowanie extends StatefulWidget {
  @override
  _LogowanieState createState() => _LogowanieState();
}

class _LogowanieState extends State<Logowanie> {
//class Rejestracja extends StatelessWidget {
  String password = '';
  String email = '';

  Future<void> _saveData() async {
    try {
      // Przygotuj dane do wysłania
      Map<String, dynamic> data = {
        'haslo': password,
        'email': email,
      };

// Wyślij dane na serwer
      var response = await http.post(
        Uri.parse('http://localhost:8080/uzytkownik/add/1'),//zmienić!
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // Sprawdź, czy zapis się udał
      if (response.statusCode == 200) {
        print('Dane zostały pomyślnie zapisane na serwerze.');
      } else {
        print('Błąd podczas zapisywania danych na serwerze.');
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logowanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hasło'),
              //keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  password = (value);
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Potwierdź'),
            )
          ],
        ),
      ),
    );
  }
}
