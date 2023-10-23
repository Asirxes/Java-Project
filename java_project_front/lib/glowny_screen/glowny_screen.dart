
import 'package:flutter/material.dart';
import 'package:java_project_front/AppBar/BottomNavigationBar.dart';
import 'package:java_project_front/Rejestracja/rejestracja.dart';


class EkranGlowny extends StatefulWidget {
  const EkranGlowny({super.key});

  @override
  State<EkranGlowny> createState() => _EkranGlownyState();
}

class _EkranGlownyState extends State<EkranGlowny> {
  

  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Container(
            //   width: 200,
            //   height: 200,
            //   child: Image.asset('lib/assets/logo1.png'),
            // ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rejestracja()),
                );
              },
              child: Text('Zaloguj się'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rejestracja()),
                );
              },
              child: Text('Zarejestruj się'),
            ),

//------------------------------------------------------------------
         
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
