import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'package:fukusyu_card/models/app_data.dart';
import 'package:fukusyu_card/models/flashcard.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:photo_view/photo_view.dart';

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
  bool isQuestionImage = true;
  int _currentIndex = 0;
  final picker = ImagePicker();

  Future getImage() async {
    //　問題の撮影
    final questionImageFile = await picker.getImage(source: ImageSource.camera);

    //　回答の撮影
    final answerImageFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      insertFlashcard(Flashcard(
          id: 1,
          folderID: AppData().selectedFolderID,
          problemPhotoPath: questionImageFile.path,
          answerPhotoPath: answerImageFile.path,
          deleteFlag: 0,
          priority: 1));
      print("registered!!");
      // if (pickedFile2 != null) {
      //   _image_answer = File(pickedFile2.path);
      // }
    });
  }

  final _controller = PreloadPageController(
    initialPage: 0,
  );

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
                  return PreloadPageView.builder(
                      preloadPagesCount: 2,
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final flashcard = snapshot.data[index];
                        return Column(children: <Widget>[
                          PhotoView(
                            onTapUp: (context, details, controllerValue) {
                              setState(() {
                                // 5. 画面タップで答え画像への切り替えができる??
                                isQuestionImage = !isQuestionImage;
                                print("flip!!");
                                print(snapshot.data[index].problemPhotoPath);
                                print(snapshot.data[index].answerPhotoPath);
                              });
                            },
                            imageProvider: isQuestionImage
                                ? FileImage(
                                    File(snapshot.data[index].problemPhotoPath))
                                : FileImage(
                                    File(snapshot.data[index].answerPhotoPath)),
                          ),
                          PhotoView(
                            onTapUp: (context, details, controllerValue) {
                              setState(() {
                                // 5. 画面タップで答え画像への切り替えができる??
                                isQuestionImage = !isQuestionImage;
                                print("flip!!");
                                print(snapshot.data[index].problemPhotoPath);
                                print(snapshot.data[index].answerPhotoPath);
                              });
                            },
                            imageProvider: isQuestionImage
                                ? FileImage(
                                    File(snapshot.data[index].problemPhotoPath))
                                : FileImage(
                                    File(snapshot.data[index].answerPhotoPath)),
                          ),
                        ]);
                      });
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
