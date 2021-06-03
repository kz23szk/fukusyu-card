import 'package:flutter/material.dart';
import 'package:fukusyu_card/screens/menu_screen.dart';
import 'package:fukusyu_card/screens/camera_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debugラベルはずす
      title: "復習カード",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'notosans-medium',
      ),
      //home: MyHomePage(),
      initialRoute: MenuScreen.id,
      routes: {
        MenuScreen.id: (context) => MenuScreen(),
        CameraScreen.id: (context) => CameraScreen(),
      },
    );
  }
}
