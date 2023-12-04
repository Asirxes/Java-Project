import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ProductAddPage extends StatefulWidget {
  final int userId;
  final Function()? onProductAdd;

  ProductAddPage({required this.userId, required this.onProductAdd});

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  String itemName = '';
  double itemQuantity = 0.0;
  int selectedUnit = 0;

  bool isSaveButtonEnabled() {
    return itemName.isNotEmpty && itemQuantity > 0 && selectedUnit > 0;
  }

  Future<void> _saveData() async {
    try {
      if (!isSaveButtonEnabled()) {
        return;
      }

      Map<String, dynamic> data = {
        'name': itemName,
        'quantity': itemQuantity,
        'unit': selectedUnit,
      };

      var response = await http.post(
        Uri.parse('http://localhost:8080/api/products/add/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Dodawanie produktu powiodło się",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        widget.onProductAdd!();

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
        title: const Text("Dodaj do listy"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              decoration: InputDecoration(labelText: 'Nazwa'),
              onChanged: (value) {
                setState(() {
                  itemName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ilość'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  itemQuantity = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Waga lub pojemność: '),
                Radio(
                  value: 1,
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value as int;
                    });
                  },
                ),
                Text('kg'),
                Radio(
                  value: 2,
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value as int;
                    });
                  },
                ),
                Text('l'),
                Radio(
                  value: 3,
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value as int;
                    });
                  },
                ),
                Text('g'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isSaveButtonEnabled() ? _saveData : null,
              child: Text('Zapisz'),
            )
          ],
        ),
      ),
    );
  }
}
