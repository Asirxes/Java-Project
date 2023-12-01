import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_project_front/Color.dart';
import 'dart:convert';

import 'Recipe.dart';
import 'RecipeAddPage.dart';
import 'RecipeDetailsPage.dart';

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
      var response = await http.get(Uri.parse(
          'http://localhost:8080/api/recipes/getAll/${widget.userId}'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Recipe> fetchedRecipes =
            data.map((item) => Recipe.fromJson(item)).toList();

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

  void _openRecipeDetailsPage(int recipeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(
          userId: widget.userId,
          recipeId: recipeId,
          onRecipeChange: _fetchRecipes,
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
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _openRecipeDetailsPage(recipes[index].id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        recipes[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
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
