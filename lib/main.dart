import 'package:flutter/material.dart';
import 'package:fukusyu_card/screens/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '復習カード',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MenuScreen.id,
      routes: {
        MenuScreen.id: (context) => MenuScreen(),
        //BoardScreen.id: (context) => BoardScreen(),
        //PurchaseScreen.id: (context) => PurchaseScreen(),
      },
    );
  }
}
