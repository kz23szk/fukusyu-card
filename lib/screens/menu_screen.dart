import 'package:flutter/material.dart';
import 'camera_screen.dart';

class MenuScreen extends StatelessWidget {
  static String id = '/menu';

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
                icon: Icon(Icons.settings),
                //onPressed: () => Navigator.pushNamed(context, CameraScreen.id),
              ),
            ]),
        body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListView.separated(
                itemCount: listTiles.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black38,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return listTiles[index];
                },
              )),
        ));
  }
}

List<Widget> listTiles = <Widget>[
  ListTile(
    leading: Icon(Icons.map),
    title: Text('3手詰'),
    onTap: () {
      print('go');
    },
  ),
  ListTile(
    leading: Icon(Icons.photo_album),
    title: Text('手筋'),
  ),
  ListTile(
    leading: Icon(Icons.phone),
    title: Text('次の一手'),
  ),
  Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Colors.black38),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.photo_album),
        title: Text('Album'),
      )),
];
