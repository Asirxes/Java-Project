import 'package:flutter/material.dart';
import 'package:java_project_front/Files/files.dart';
import 'package:java_project_front/List/list_screen.dart';
//import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => list()));
            },
          ),
          IconButton(
            icon: Icon(Icons.file_copy),
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => files()));
            },
          ),
        ],
      ),
    );
  }
}
