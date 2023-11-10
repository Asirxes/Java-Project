import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';

class add_list extends StatefulWidget {
  @override
  _add_listState createState() => _add_listState();
}

class _add_listState extends State<add_list> {
  String itemName = '';
  double itemQuantity = 0.0;
  String selectedUnit = 'kg';

  Future<void> _saveData() async {
    try {
      // Przygotuj dane do wysłania
      Map<String, dynamic> data = {
        'name': itemName,
        'quantity': itemQuantity,
        'unit': selectedUnit,
      };

      // Wyślij dane na serwer
      var response = await http.post(
        Uri.parse('http://localhost:8080/produkt/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // Sprawdź, czy zapis się udał
      if (response.statusCode == 200) {
        print('Dane zostały pomyślnie zapisane na serwerze.');
      } else {
        print('Błąd podczas zapisywania danych na serwerze.');
      }
    } catch (error) {
      print('Wystąpił błąd: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doddaj do listy"),
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
                  itemQuantity = double.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Waga lub pojemność: '),
                Radio(
                  value: 'kg',
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                ),
                Text('kg'),
                Radio(
                  value: 'l',
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                ),
                Text('l'),
                Radio(
                  value: 'gr',
                  groupValue: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                ),
                Text('gr'),
              ],
            ),

//          ElevatedButton(
//               onPressed: () {
//                 // Tutaj dodać kod obsługujący zapis danych, np. wysyłanie ich do serwera.
//                 // Możesz również dodatkowo dodać walidację wprowadzonych danych przed zapisem.
//                 // Przykład zapisu danych do konsoli:
//                  print('Nazwa przedmiotu: $itemName');
//                  print('Ilość przedmiotu: $itemQuantity');
//                  print('Waga: $selectedUnit');
//               },
//               child: Text('Zapisz'),
//             )


            ElevatedButton(
              onPressed: _saveData,
              child: Text('Zapisz'),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
