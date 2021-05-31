import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Sample'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fukusyu_card/screens/menu_screen.dart';
// import 'package:fukusyu_card/screens/camera_screen.dart';
// import 'package:camera/camera.dart';
//
// List<CameraDescription> cameras;
//
// void main() async {
//   cameras = await availableCameras();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '復習カード',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: MenuScreen.id,
//       routes: {
//         MenuScreen.id: (context) => MenuScreen(),
//         CameraScreen.id: (context) => CameraScreen(),
//         //PurchaseScreen.id: (context) => PurchaseScreen(),
//       },
//     );
//   }
// }
