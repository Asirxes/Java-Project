import 'package:flutter/material.dart';
import 'package:java_project_front/Accont/accont.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/Files/add_files.dart';

class files extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twoje przepisy"),
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
      body: Center(
        child: Text('lista przepisów'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => add_file()));
              },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
    
  }
}
