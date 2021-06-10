import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Folder {
  final int id;
  final String text;
  final int priority;

  Folder({this.id, this.text, this.priority});

  Map<String, dynamic> toFolder() {
    return {
      'id': id,
      'text': text,
      'priority': priority,
    };
  }
}

final String dbName = 'flashcard2.db';

Future<List<Folder>> getFolders() async {
  int folderCount = await getFoldersCount();
  print(folderCount.toString());
  // folderテーブルにデータが無いときはデフォルトデータ（グループ1）を挿入
  if (folderCount == 0) {
    insertFolder(Folder(id: 1, text: "グループ1", priority: 1));
    int folderCount = await getFoldersCount();
    print(folderCount.toString());
  }

  final Database database = await connectDB();
  final List<Map<String, dynamic>> maps = await database.query('folder');

  return List.generate(maps.length, (i) {
    return Folder(
      id: maps[i]['id'],
      text: maps[i]['text'],
      priority: maps[i]['priority'],
    );
  });
}

Future<Database> connectDB() async {
  return openDatabase(
    join(await getDatabasesPath(), dbName),
    onCreate: (db, version) {
      print("AA");
      db.execute(
          "CREATE TABLE folder(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, priority INTEGER)");
      print("BB");
      return db.execute(
          "CREATE TABLE card (id INTEGER PRIMARY KEY AUTOINCREMENT, folderID INTEGER, problemPhotoPath TEXT, answerPhotoPath TEXT, deleteFlag INTEGER, priority INTEGER)");
    },
    version: 1,
  );
}

Future<int> getFoldersCount() async {
  // データベース接続
  final Future<Database> database = connectDB();

  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('folder');
  return maps.length;
}

Future<void> insertFolder(Folder folder) async {
  final Database db = await openDatabase(
    join(await getDatabasesPath(), dbName),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE folder(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, priority INTEGER)",
      );
    },
    version: 1,
  );
  await db.insert(
    'folder',
    folder.toFolder(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
