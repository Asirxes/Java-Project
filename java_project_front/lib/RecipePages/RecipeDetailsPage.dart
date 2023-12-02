import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:universal_html/html.dart' as html;

import '../ProductPages/Product.dart';

class RecipeDetailsPage extends StatefulWidget {
  final int userId;
  final int recipeId;
  final Function()? onRecipeChange;

  RecipeDetailsPage({
    required this.userId,
    required this.recipeId,
    required this.onRecipeChange,
  });

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late TextEditingController titleController;
  late TextEditingController textController;
  List<Product> products = [];

  String title = "Tytuł przepisu";
  String text = "Tekst przepisu";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: title);
    textController = TextEditingController(text: text);
    _fetchRecipeDetails();
    _fetchProducts();
  }

  Future<void> _fetchRecipeDetails() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8080/api/recipes/get/${widget.recipeId}'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          title = data['name'];
          text = data['text'];
          titleController.text = title;
          textController.text = text;
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Wystąpił błąd: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: ${error}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _fetchProducts() async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://localhost:8080/api/recipes/getProducts/${widget.recipeId}'),
      );

      if (response.statusCode == 200) {
        List<dynamic> productsData = jsonDecode(response.body);
        setState(() {
          products =
              productsData.map((data) => Product.fromJson(data)).toList();
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Wystąpił błąd: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: ${error}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _deleteRecipe() async {
    try {
      var response = await http.delete(
        Uri.parse(
            'http://localhost:8080/api/recipes/delete/${widget.recipeId}'),
      );

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
          msg: "Wystąpił błąd: ${response.statusCode}",
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
      var response = await http.put(
        Uri.parse(
            'http://localhost:8080/api/recipes/update/${widget.recipeId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': titleController.text,
          'text': textController.text,
        }),
      );

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
        _fetchProducts();
      } else {
        Fluttertoast.showToast(
          msg: "Wystąpił błąd: ${response.statusCode}",
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

  Future<void> _importJson() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.isNotEmpty) {
      try {
        String jsonString = String.fromCharCodes(result.files.first.bytes!);
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);

        String productName = jsonMap['name'];
        double productQuantity = jsonMap['quantity'];
        int productUnit = jsonMap['unit'];

        await _addProductToRecipe(productName, productQuantity, productUnit);

        Fluttertoast.showToast(
          msg: "Produkt został dodany do przepisu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        _fetchProducts();
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Wystąpił błąd: ${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  Future<void> _addProductToRecipe(
    String productName,
    double productQuantity,
    int productUnit,
  ) async {
    try {
      await http.post(
        Uri.parse(
          'http://localhost:8080/api/recipes/addProduct/${widget.recipeId}',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': productName,
          'quantity': productQuantity,
          'unit': productUnit,
        }),
      );
    } catch (error) {
      throw Exception('Błąd podczas dodawania produktu do przepisu');
    }
  }

  Future<void> _downloadProductJson(Product product) async {
    try {
      Map<String, dynamic> productMap = {
        'name': product.name,
        'quantity': product.quantity,
        'unit': product.unit,
      };

      String productJson = jsonEncode(productMap);

      final blob = html.Blob([productJson]);

      final anchor =
          html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
            ..target = 'download'
            ..download = 'test.json'
            ..click();

      html.Url.revokeObjectUrl(html.Url.createObjectUrlFromBlob(blob));

      Fluttertoast.showToast(
        msg: "Plik JSON z danymi o produkcie został zapisany",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: ${error}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _removeProductFromRecipe(Product product) async {
    try {
      var response = await http.delete(
        Uri.parse(
          'http://localhost:8080/api/recipes/removeProduct/${widget.recipeId}/${product.id}',
        ),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Produkt został pomyślnie usunięty z przepisu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        _fetchProducts();
      } else {
        Fluttertoast.showToast(
          msg: "Wystąpił błąd: ${response.statusCode}",
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
            Text(
              'Produkty:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              children: products.map((product) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${product.name} - ${product.quantity} ${product.unit}'),
                      ElevatedButton(
                        onPressed: () {
                          _removeProductFromRecipe(product);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        child: Text('Usuń'),
                      ),
                    ],
                  ),
                  onTap: () {
                    _downloadProductJson(product);
                  },
                );
              }).toList(),
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
                ElevatedButton(
                  onPressed: () {
                    _importJson();
                  },
                  child: Text('Dodaj przepis JSON'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
