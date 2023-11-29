import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:java_project_front/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = '';
  String email = '';

  Future<void> _saveData() async {
    try {
      Map<String, dynamic> data = {
        'password': password,
        'email': email,
      };

      var response = await http.post(
        Uri.parse('http://localhost:8080/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        int userId = jsonDecode(response.body);
        if (userId > 0) {
          Fluttertoast.showToast(
            msg: 'Zalogowano pomyślnie.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      isUserLoggedIn: true,
                      userId: userId,
                    )),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Błąd logowania. Spróbuj ponownie.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Błąd komunikacji z serwerem. Spróbuj ponownie.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
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
              onChanged: (value) {
                setState(() {
                  password = value;
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
