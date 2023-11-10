import 'package:flutter/material.dart';
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
            ElevatedButton(
              onPressed: () {
                // Tutaj dodać kod obsługujący zapis danych, np. wysyłanie ich do serwera.
                // Możesz również dodatkowo dodać walidację wprowadzonych danych przed zapisem.
                // Przykład zapisu danych do konsoli:
                 print('Nazwa przedmiotu: $itemName');
                 print('Ilość przedmiotu: $itemQuantity');
                 print('Waga: $selectedUnit');
              },
              child: Text('Zapisz'),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
