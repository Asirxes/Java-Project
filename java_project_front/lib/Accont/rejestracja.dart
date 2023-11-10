import 'package:flutter/material.dart';


class Rejestracja extends StatefulWidget {
  @override
  _RejestracjaState createState() => _RejestracjaState();
}

class _RejestracjaState extends State<Rejestracja> {
//class Rejestracja extends StatelessWidget {
  String password = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejestracja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hasło'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  password = (value);
                });
              },
            ),
            SizedBox(height: 16.0),
            ],
      ),
    ),
    );
  }
}