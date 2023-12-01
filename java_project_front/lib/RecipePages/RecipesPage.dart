import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Recipe.dart';
import 'RecipeAddPage.dart';

class RecipesPage extends StatefulWidget {
  final int userId;

  RecipesPage({required this.userId});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      var response = await http.get(Uri.parse('http://localhost:8080/api/recipes/getAll/${widget.userId}'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Recipe> fetchedRecipes = data.map((item) => Recipe.fromJson(item)).toList();

        setState(() {
          recipes = fetchedRecipes;
        });
      } else {
        print('Błąd podczas pobierania danych z serwera.');
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  void _openRecipeAddPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeAddPage(
          userId: widget.userId,
          onRecipeAdded: _fetchRecipes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przepisy'),
      ),
      body: recipes.isEmpty
          ? Center(
              child: Text('Nie posiadasz żadnych przepisów.'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text(recipes[index].name),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRecipeAddPage,
        tooltip: 'Dodaj przepis',
        child: Icon(Icons.add),
      ),
    );
  }
}


