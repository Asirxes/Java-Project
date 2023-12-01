import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:java_project_front/ProductPages/ProductAddPage.dart';
import '../HomePage.dart';
import 'Product.dart';

class ProductsPage extends StatefulWidget {
  final int userId;

  const ProductsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      var response = await http.get(Uri.parse('http://localhost:8080/api/products/getAll/${widget.userId}'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data.map((item) => Product.fromJson(item)).toList();

        setState(() {
          productList = products;
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Błąd podczas pobierania danych z serwera.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> _deleteProduct(int productId) async {
    try {
      var response = await http.delete(
        Uri.parse('http://localhost:8080/api/products/delete/$productId'),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Produkt został pomyślnie usunięty.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        _fetchProducts(); 
      } else {
        Fluttertoast.showToast(
          msg: 'Coś poszło nie tak. Spróbuj ponownie.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Wystąpił błąd: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista zakupów"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(isUserLoggedIn: true, userId: widget.userId),
              ),
            );
          },
        ),
      ),
      body: productList.isEmpty
          ? Center(
              child: Text('Brak produktów.'),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _deleteProduct(productList[index].id);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('${productList[index].name} - ${productList[index].quantity} ${productList[index].unit}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductAddPage(userId: widget.userId),
            ),
          );
        },
        tooltip: 'Dodaj produkt',
        child: const Icon(Icons.add),
      ),
    );
  }
}
