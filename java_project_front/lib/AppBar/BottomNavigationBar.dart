

import 'package:flutter/material.dart';
import 'package:java_project_front/Rejestracja/rejestracja.dart';
//import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Rejestracja()));
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
              },
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Rejestracja()));
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Pliki()));
              },
            ),
            
          ],
        ),    
      ); 
  }
}


// import 'package:dyplom/glowny_screen/glowny_screen.dart';
// import 'package:dyplom/ranking_screen/ranking_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:dyplom/theme/theme.dart';
// import 'package:provider/provider.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:dyplom/tresc_screen/CategoryRepository.dart';



// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //theme: themeNotifier.currentTheme,
//     //final themeNotifier = ThemeProvider.of(context);
//     return BottomAppBar(child:
//         Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
//               // Navigate to the 'Konto' screen
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => EkranGlowny()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.message),
//             onPressed: () {
//               // Navigate to the 'Wiadomości' screen
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => EkranGlowny()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.align_vertical_bottom),
//             onPressed: () {
//               // Navigate to the 'Rankingi' screen
//               Navigator.push(context,
//                   MaterialPageRoute(
//                     //builder: (context) => RankingScreen(repository: null,)
//                     builder: (context) => RankingScreen(repository: repository),
//                   ));
//             },
//           ),
//         ],
//       );
//     }));
//   }
// }
