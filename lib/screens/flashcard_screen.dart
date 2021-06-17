import 'package:flutter/material.dart';
import 'package:fukusyu_card/models/app_data.dart';
import 'package:fukusyu_card/models/flashcard.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:developer';

// 画像暗記カードのメイン画面
class FlashcardScreen extends StatefulWidget {
  static String id = '/flashcard';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FlashcardScreen> {
  bool isQuestionImage = true;
  int _currentIndex = 0;
  Flashcard currentDisplayedCard = Flashcard();
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
    });
  }

  final _controller = PreloadPageController(
    initialPage: 0,
  );

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "復習カード",
            style: TextStyle(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("削除しますか？"),
                      actions: <Widget>[
                        // ボタン領域
                        FlatButton(
                          child: Text("キャンセル"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("削除"),
                          //TODO: 削除処理を入れる
                          onPressed: () {
                            // DB上のレコード削除
                            deleteFlashcard(currentDisplayedCard.id);
                            // 写真ファイルの削除
                            deleteFile(currentDisplayedCard.problemPhotoPath);
                            deleteFile(currentDisplayedCard.answerPhotoPath);
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                );
              },
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
                        isQuestionImage = true;
                        scrollToTop();
                        setState(() {
                          _currentIndex = index;
                          currentDisplayedCard = snapshot.data[index];
                          print(_currentIndex);
                        });
                      },
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                move(isQuestionImage,
                                    screenHeight - appBarHeight);
                                isQuestionImage = !isQuestionImage;
                              });
                            },
                            child: SingleChildScrollView(
                                controller: controller,
                                child: Column(
                                  children: [
                                    Container(
                                      height: screenHeight - appBarHeight,
                                      alignment: Alignment.topCenter,
                                      child: Image(
                                          image: FileImage(File(snapshot
                                              .data[index].problemPhotoPath))),
                                    ),
                                    Container(
                                      height: screenHeight - appBarHeight,
                                      alignment: Alignment.topCenter,
                                      child: Image(
                                          image: FileImage(File(snapshot
                                              .data[index].answerPhotoPath))),
                                    )
                                  ],
                                )));
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

  void move(bool isQuestionImage, double height) {
    controller.animateTo(
      isQuestionImage ? height : 0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void scrollToTop() {
    controller.animateTo(
      0,
      duration: Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }
}

Widget buildImage(String path) {
  return PhotoView(imageProvider: FileImage(File(path)));
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
