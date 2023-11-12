import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_project_front/List/list_screen.dart';

class ZmianaHasla extends StatefulWidget {
  @override
  _ZmianaHaslaState createState() => _ZmianaHaslaState();
}

class _ZmianaHaslaState extends State<ZmianaHasla> {
//class ZmianaHasla extends StatelessWidget {
  String password = '';
  String email = '';

  Future<void> _saveData() async {
    try {
      // Przygotuj dane do wysłania
      Map<String, dynamic> data = {
        'haslo': password,
      };

// Wyślij dane na serwer
      var response = await http.post(
        Uri.parse('http://localhost:8080/uzytkownik/add/1'),
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
        title: Text('Zmiana hasła'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nowe Hasło'),
              //keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  password = (value);
                });
              },
            ),
             SizedBox(height: 16.0),
            // TextFormField(
            //   decoration: InputDecoration(labelText: 'Powtóż Hasło'),
            //   //keyboardType: TextInputType.number,
            //   onChanged: (value) {
            //     setState(() {
            //       password = (value);
            //     });
            //   },
            // ),
            //SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveData;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => list()),
                );
              },
              child: Text('Potwierdź'),
            )
          ],
        ),
      ),
    );
  }
}
