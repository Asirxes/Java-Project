import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_project_front/ProductPages/ProductAddPage.dart';
import 'Product.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Produkt> productList = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      var response =
          await http.get(Uri.parse('http://localhost:8080/produkt/'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Produkt> products =
            data.map((item) => Produkt.fromJson(item)).toList();

        setState(() {
          productList = products;
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
        title: const Text("Lista zakupów"),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productList[index].name),
            subtitle: Text(
                '${productList[index].quantity} ${productList[index].unit}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductAddPage()));
        },
        tooltip: 'Dodaj produkt',
        child: const Icon(Icons.add),
      ),
      
    );
  }
}
