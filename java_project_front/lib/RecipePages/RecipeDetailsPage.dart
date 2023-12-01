import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class RecipeDetailsPage extends StatefulWidget {
  final int userId;
  final int recipeId;
  final Function()? onRecipeChange;

  RecipeDetailsPage(
      {required this.userId,
      required this.recipeId,
      required this.onRecipeChange});

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
      var response = await http.get(Uri.parse(
          'http://localhost:8080/api/recipes/get/${widget.recipeId}'));

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

  Future<void> _deleteRecipe() async {
    try {
      var response = await http.delete(Uri.parse(
          'http://localhost:8080/api/recipes/delete/${widget.recipeId}'));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Przepis został pomyślnie usunięty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        widget.onRecipeChange!();

        Navigator.pop(context); 
      } else {
        Fluttertoast.showToast(
          msg: "Błąd podczas usuwania przepisu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Wystąpił błąd: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _updateRecipe() async {
    try {
      var response = await http.put(Uri.parse(
          'http://localhost:8080/api/recipes/update/${widget.recipeId}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': titleController.text,
            'text': textController.text,
          }));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Przepis został pomyślnie zaktualizowany",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        widget.onRecipeChange!();
      } else {
        Fluttertoast.showToast(
          msg: "Błąd podczas aktualizacji przepisu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Wystąpił błąd: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
                    _deleteRecipe();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Usuń'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateRecipe();
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
