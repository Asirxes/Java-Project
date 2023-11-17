import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:java_project_front/Files/files.dart';

// class add_file extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dodaj przepis"),
//         leading: IconButton(
//           icon: const Icon(Icons.person),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => accont()),
//             );
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => Rejestracja()),

//                 // );
//               },
//               child: Text('dodaj przepis'),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(),
//     );
//   }
// }

class add_file extends StatefulWidget {
  @override
  _add_fileState createState() => _add_fileState();
}

class _add_fileState extends State<add_file> {
  List<String> itemList = [];
  File? pickedFile;
  TextEditingController nameController = TextEditingController();
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _addItemField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodaj przepis"),
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
          // Display the existing text fields
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

          // Button to add a new text field
          ElevatedButton(
            onPressed: () {
              _addItemField();
            },
            child: Text('dodaj'),
          ),

          // Button to pick a file
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  pickedFile = File(result.files.single.path!);
                });
              }
            },
            child: Text('Dodaj plik'),
          ),

          // Button to save all items and the picked file

          ElevatedButton(
            onPressed: () {
              _saveToDatabase();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => files()),
              );
            },
            child: Text('Zapisz'),
          )
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
    // Save itemList and pickedFile to the database
    for (int i = 0; i < itemList.length; i++) {
      print('Saving Item ${i + 1}: ${itemList[i]} to the database');
      // Perform database operations here with itemList[i]
    }

    if (pickedFile != null) {
      print('Saving file ${pickedFile!.path} to the database');
      // Perform database operations here with the picked file
    }

    setState(() {
      itemList.clear();
      controllers.clear();
      pickedFile = null;
      nameController.clear();
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    nameController.dispose();
    super.dispose();
  }
}
