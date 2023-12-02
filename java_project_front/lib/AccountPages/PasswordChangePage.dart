import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:java_project_front/HomePage.dart';

class PasswordChangePage extends StatefulWidget {
  final int userId;

  PasswordChangePage({required this.userId});

  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String password = '';
  String confirmPassword = '';

  Future<void> _saveData() async {
    try {
      if (password != confirmPassword) {
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
      };

      var response = await http.post(
        Uri.parse(
            'http://localhost:8080/api/users/changePassword/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Hasło zostało pomyślnie zmienione.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(isUserLoggedIn: true, userId: widget.userId),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Wystąpił błąd: ${response.statusCode}',
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
        title: Text('Zmiana hasła'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nowe Hasło'),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Potwierdź Hasło'),
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
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
