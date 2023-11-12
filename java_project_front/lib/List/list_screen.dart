import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/List/add_to_list.dart';
import 'produkt.dart';

class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => accont()),
            );
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
              context, MaterialPageRoute(builder: (context) => add_list()));
        },
        tooltip: 'Dodaj produkt',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
