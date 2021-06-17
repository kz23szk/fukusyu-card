import 'package:flutter/material.dart';
import 'package:fukusyu_card/screens/menu_screen.dart';
import 'package:fukusyu_card/screens/camera_screen.dart';
import 'package:fukusyu_card/screens/flashcard_screen.dart';
import 'models/app_data.dart';
import 'package:provider/provider.dart';

final String dbName = 'fukusyu_card.db';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (_) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "復習カード",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'notosans-medium',
        ),
        //home: MyHomePage(),
        initialRoute: MenuScreen.id,
        routes: {
          MenuScreen.id: (context) => MenuScreen(),
          FlashcardScreen.id: (context) => FlashcardScreen(),
        },
      ),
    );
  }
}
