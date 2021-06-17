import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  static String id = '/register';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CameraScreen> {
  File _image_question;
  File _image_answer;
  File _image_display;
  final picker = ImagePicker();

  Future getImage() async {
    //　問題の撮影
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    //　回答の撮影
    final pickedFile2 = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image_question = File(pickedFile.path);
        _image_display = _image_question;
      }
      if (pickedFile2 != null) {
        _image_answer = File(pickedFile2.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('復習カード'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => Navigator.pushNamed(context, CameraScreen.id),
        ),
      ]),
      body: Column(
        children: <Widget>[
          Center(
            child: _image_display == null
                ? Text('No image selected.')
                : Image.file(_image_display),
          ),
          ElevatedButton(
            onPressed: () {
              if (_image_display == _image_question) {
                _image_display = _image_answer;
              } else {
                _image_display = _image_question;
              }
              setState(() {});
            },
            child:
                _image_display == _image_question ? Text('回答写真') : Text('問題写真'),
          ),
          ElevatedButton(
            child: const Text('登録'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.black,
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
