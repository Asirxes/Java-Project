//edytowanie przepisu z możliwością pobrania pliku

import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'dart:io';

import 'package:java_project_front/Files/files.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Item {
  String name;

  Item({required this.name});
}

class EditItemsScreen extends StatefulWidget {
  @override
  _EditItemsScreenState createState() => _EditItemsScreenState();
}

class _EditItemsScreenState extends State<EditItemsScreen> {
  late List<String> itemList;
  late File? pickedFile;
  late TextEditingController nameController;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    itemList = []; 
    pickedFile = null; 
    nameController = TextEditingController();
    controllers = [];
    // Call function to fetch data for each item from the database
    fetchDataForItems();//zrób funkcje
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edytuj przepis"),
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nazwa',
            ),
          ),
          SizedBox(height: 16.0),

          
          for (int i = 0; i < itemList.length; i++)
            ListTile(
              title: TextFormField(
                controller: controllers[i],
                decoration: InputDecoration(
                  labelText: 'Item ${i + 1}',
                ),
                onChanged: (value) {
                  itemList[i] = value;
                },
              ),
            ),

          ElevatedButton(
            onPressed: () {
              _addItemField();
            },
            child: Text('dodaj'),
          ),

          // Button to pick a file
          ElevatedButton(
            onPressed: () async {
              // Implement file picking logic
            },
            child: Text('Dodaj plik'),
          ),

          // Button to save all items and the picked file
          ElevatedButton(
            onPressed: () {
              _saveToDatabase();
            },
            child: Text('Zapisz zmiany'),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  void _addItemField() {
    setState(() {
      itemList.add('');
      controllers.add(TextEditingController());
    });
  }

  void _saveToDatabase() {
    String name = nameController.text;
    print('Name: $name');

    for (int i = 0; i < itemList.length; i++) {
      print('Item ${i + 1}: ${itemList[i]}');
    }

    if (pickedFile != null) {
      print('Picked file: ${pickedFile!.path}');
    }

    // Perform database operations or save changes here
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    nameController.dispose();
    super.dispose();
  }

  void fetchDataForItems() async {
    // Example: Fetch item names from the database
    List<String> itemNames = await fetchItemNamesFromDatabase();

    // Use the fetched item names to populate the text fields
    for (var itemName in itemNames) {
      itemList.add(itemName);
      controllers.add(TextEditingController(text: itemName));
    }

    // Fetch additional data for each item, like files or other details
    // Example: List<File?> files = await fetchFilesForItemsFromDatabase();

    // Set the fetched files to the pickedFile variable
    // Example: pickedFile = files.isNotEmpty ? files[0] : null;

    // Set the fetched name for the whole set of items
    // Example: String name = await fetchNameForItemsFromDatabase();
    // Example: nameController.text = name;
  }

  Future<List<String>> fetchItemNamesFromDatabase() async {
    // Simulated data fetching from a database
    await Future.delayed(Duration(seconds: 2)); // Simulate delay
    return ['Item 1', 'Item 2', 'Item 3']; // Replace with your database logic
  }

  // Other database fetching functions go here...
}
