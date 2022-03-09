import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user.dart';

class SqliteService {
  // Future<Database> initializeDB() async {
  // String path = await getDatabasesPath();

  //   return openDatabase(join(path, 'database.db'),
  //       onCreate: (database, version) async {
  //     await database.execute(
  //       "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)",
  //     );
  //   }, version: 1);
  // }

  // Future<void> addUser(User user) async {
  //   int result = 0;
  //   final Database db = await initializeDB();
  //   final id = await db.insert('User', user.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  final database = openDatabase(
    join(getDatabasesPath().toString(), 'user.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)',
      );
    },
    version: 1,
  );

  Future<User?> insertUser(User user) async {
    final db = await database;
    var queryResult =
        await db.rawQuery('SELECT * FROM user WHERE username="${user.username}" or email="${user.email}"');
    if (queryResult.isEmpty) {
      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      queryResult =
        await db.rawQuery('SELECT * FROM user WHERE username="${user.username}" or email="${user.email}"');
      return new User.fromMap(queryResult.first);
    }
    return null;
  }


  Future<User?> login(String? email, String? password)async{
    var db = await database;
    var res = await db.rawQuery("SELECT * FROM user WHERE email = '$email' and password = '$password'");
    
    if (res.isNotEmpty) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  // Future<List<User>> listUser() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> json = await db.query('user');
  //   return List.generate(json.length, (i) {
  //     return User(
  //       userName: json[i]['username'],
  //       email: json[i]['emai;'],
  //       password: json[i]['password'],
  //     );
  //   });
  // }
}
