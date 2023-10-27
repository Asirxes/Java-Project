import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/List/add_to_list.dart';

class list extends StatelessWidget {
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
      body: const Center(
        child: Text('dodane listy zakupów'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => add_list()));
              },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
