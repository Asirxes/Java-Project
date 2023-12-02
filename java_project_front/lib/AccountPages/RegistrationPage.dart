import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:java_project_front/HomePage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String password = '';
  String repeatedPassword = '';
  String email = '';

  Future<void> _saveData() async {
    try {
      if (password != repeatedPassword) {
        Fluttertoast.showToast(
          msg: 'Hasła nie pasują do siebie.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return;
      }

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
        int userId = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(isUserLoggedIn: true, userId: userId)),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Coś poszło nie tak. Spróbuj ponownie.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (error) {}
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
                  password = value;
                });
              },
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Powtórz hasło'),
              onChanged: (value) {
                setState(() {
                  repeatedPassword = value;
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
