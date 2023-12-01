import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeDetailsPage extends StatefulWidget {
  final int userId;
  final int recipeId;

  RecipeDetailsPage({required this.userId, required this.recipeId});

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late TextEditingController titleController;
  late TextEditingController textController;

  String title = "Tytuł przepisu";
  String text = "Tekst przepisu";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: title);
    textController = TextEditingController(text: text);
    _fetchRecipeDetails();
  }

  Future<void> _fetchRecipeDetails() async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:8080/api/recipes/get/${widget.recipeId}'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          title = data['name'];
          text = data['text'];
          titleController.text = title;
          textController.text = text;
        });
      } else {
        print('Błąd podczas pobierania danych z serwera.');
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szczegóły przepisu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tytuł:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 16.0),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Tekst:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: textController,
              style: TextStyle(fontSize: 16.0),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Usuń przepis
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Usuń'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Zapisz zmiany
                  },
                  child: Text('Zapisz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
