import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RecipeAddPage extends StatefulWidget {
  final int userId;
  final Function()? onRecipeAdded;

  RecipeAddPage({required this.userId, this.onRecipeAdded});

  @override
  _RecipeAddPageState createState() => _RecipeAddPageState();
}

class _RecipeAddPageState extends State<RecipeAddPage> {
  String title = '';
  String text = '';

  bool isSaveButtonEnabled() {
    return title.isNotEmpty && text.isNotEmpty;
  }

  Future<void> _saveRecipe() async {
    try {
      if (!isSaveButtonEnabled()) {
        return;
      }

      Map<String, dynamic> data = {
        'name': title,
        'text': text,
      };

      var response = await http.post(
        Uri.parse('http://localhost:8080/api/recipes/add/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Dodawanie przepisu powiodło się",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        widget.onRecipeAdded?.call();

        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: "Wystąpił błąd: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Wystąpił błąd: ${error}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodawanie przepisu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Tytuł'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Tekst'),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveRecipe,
              child: Text('Zapisz'),
            ),
          ],
        ),
      ),
    );
  }
}
