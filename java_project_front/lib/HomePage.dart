import 'package:flutter/material.dart';
import 'AccountPages/LoginPage.dart';
import 'AccountPages/RegistrationPage.dart';
import 'AccountPages/PasswordChangePage.dart';
import 'ProductPages/ProductsPage.dart';
import 'RecipePages/RecipesPage.dart';

class HomePage extends StatefulWidget {
  final bool isUserLoggedIn;
  final int userId;

  const HomePage({Key? key, required this.isUserLoggedIn,required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/Assets/logo.png'),
            ),
            SizedBox(height: 20),
            if (!widget.isUserLoggedIn)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('Zaloguj się'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('Zarejestruj się'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipesPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('Przepisy'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('Produkty'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordChangePage(userId: widget.userId,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                    ),
                    child: Text('Zmiana hasła'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(isUserLoggedIn: false,userId: 0,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(300, 0),
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Wyloguj'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
