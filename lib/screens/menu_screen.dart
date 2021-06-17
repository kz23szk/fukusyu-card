import 'package:flutter/material.dart';
import 'package:fukusyu_card/models/app_data.dart';
import 'package:fukusyu_card/models/folder.dart';
import 'flashcard_screen.dart';

class MenuScreen extends StatelessWidget {
  static String id = '/menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "復習カード" + AppData().count.toString(),
              style: TextStyle(),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {}, // TODO: 設定画面へ遷移
              ),
            ]),
        body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: FutureBuilder(
                  future: getFolders(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Folder>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: Colors.black38,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return buildFolderTile(context, snapshot.data[index]);
                        },
                      );
                    } else {
                      // エラーケース（更新処理入れる？）
                      return ListTile(
                        leading: Icon(Icons.map),
                        title: Text("No folders"),
                        onTap: () {
                          print('go');
                        },
                      );
                    }
                  })),
        ));
  }
}

ListTile buildFolderTile(BuildContext context, Folder folder) {
  return ListTile(
    leading: Icon(Icons.map),
    title: Text(folder.text),
    onTap: () {
      print('go');
      AppData().setFolderID(folder.id);
      Navigator.pushNamed(context, FlashcardScreen.id);
    },
  );
}
