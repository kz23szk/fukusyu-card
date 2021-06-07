import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Folder {
  final int id;
  final String text;
  final int priority;

  Folder(this.id, this.text, this.priority);
}

final String dbName = 'fukusyu_card.db';

Future<List<Folder>> getFolders() async {
  return [
    Folder(1, "1手詰", 1),
    Folder(2, "手筋", 2),
    Folder(3, "次の一手", 3),
  ];
  // データベース接続
  // final Future<Database> database = openDatabase(
  //   join(await getDatabasesPath(), dbName),
  // );
  //
  // final Database db = await database;
  // final List<Map<String, dynamic>> maps = await db.query('memo');
  // return List.generate(maps.length, (i) {
  //   return Folder(
  //     id: maps[i]['id'],
  //     text: maps[i]['text'],
  //     priority: maps[i]['priority'],
  //   );
  // });
}

Future<int> getFoldersCount() async {
  // データベース接続
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), dbName),
  );

  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('memo');
  return maps.length;
}
