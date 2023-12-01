import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'RecipeAddPage.dart';

class RecipesPage extends StatefulWidget {
  final int userId;

  RecipesPage({required this.userId});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<String> recipeNames = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      var response =
          await http.get(Uri.parse('http://localhost:8080/api/recipes/getAll/${widget.userId}'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<String> names = data.map((item) => item['name'].toString()).toList();

        setState(() {
          recipeNames = names;
        });
      } else {
        print('Błąd podczas pobierania przepisów.');
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przepisy'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: recipeNames.isEmpty
          ? Center(
              child: Text('Nie posiadasz żadnych przepisów.'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              itemCount: recipeNames.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    print('Przycisk został naciśnięty!');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(150, 150),
                  ),
                  child: Text(recipeNames[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeAddPage(userId: widget.userId),
            ),
          );
        },
        tooltip: 'Dodaj przepis',
        child: Icon(Icons.add),
      ),
    );
  }
}
