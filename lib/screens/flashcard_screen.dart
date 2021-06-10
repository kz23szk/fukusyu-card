import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'package:fukusyu_card/models/app_data.dart';
import 'package:fukusyu_card/models/flashcard.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// 画像暗記カードのメイン画面
class FlashcardScreen extends StatefulWidget {
  static String id = '/flashcard';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FlashcardScreen> {
  File _image_question;
  File _image_answer;
  File _image_display;
  final picker = ImagePicker();

  Future getImage() async {
    //　問題の撮影
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    //　回答の撮影
    //final pickedFile2 = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image_question = File(pickedFile.path);
        _image_display = _image_question;
      }
      insertFlashcard(Flashcard(
          id: 1,
          folderID: AppData().selectedFolderID,
          problemPhotoPath: pickedFile.path,
          answerPhotoPath: pickedFile.path,
          deleteFlag: 0,
          priority: 1));
      print("registered!!");
      // if (pickedFile2 != null) {
      //   _image_answer = File(pickedFile2.path);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "復習カード",
            style: TextStyle(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () => Navigator.pushNamed(context, CameraScreen.id),
            ),
          ]),
      body: SafeArea(
          child: FutureBuilder(
              future: getFlashcards(AppData().selectedFolderID),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Flashcard>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return Column(
                    children: <Widget>[
                      Center(
                        child:
                            Image.file(File(snapshot.data[0].problemPhotoPath)),
                      ),
                    ],
                  );
                } else {
                  return ListTile(
                    leading: Icon(Icons.map),
                    title: Text("No Cards"),
                    onTap: () {
                      print('go');
                    },
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

ListTile buildCardTile(Flashcard card) {
  return ListTile(
    leading: Icon(Icons.map),
    title: Text(card.problemPhotoPath),
    onTap: () {
      print('go');
    },
  );
}
