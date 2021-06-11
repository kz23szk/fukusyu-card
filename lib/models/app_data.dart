import 'package:flutter/foundation.dart';

class AppData extends ChangeNotifier {
  int count = 55;
  int selectedFolderID = 0;

  AppData();

  void setFolderID(int id) {
    selectedFolderID = id;
  }
}
