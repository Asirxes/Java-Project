import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../List/list_screen.dart';

class Rejestracja extends StatefulWidget {

  @override
  _RejestracjaState createState() => _RejestracjaState();
}

class _RejestracjaState extends State<Rejestracja> {
  String password = '';
  String email = '';

  Future<void> _saveData() async {
    try {
      Map<String, dynamic> data = {
        'password': password,
        'email': email,
      };

      var response = await http.post(
        Uri.parse('http://localhost:8080/api/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Dane zostały pomyślnie zapisane na serwerze.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => list()),
        );
      } else {
        print('Błąd podczas zapisywania danych na serwerze.');
        Fluttertoast.showToast(
          msg: 'Coś poszło nie tak. Spróbuj ponownie.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejestracja'),
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
              onChanged: (value) {
                setState(() {
                  password = (value);
                });
              },
              obscureText: true, 
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: Text('Potwierdź'),
            )
          ],
        ),
      ),
    );
  }
}
