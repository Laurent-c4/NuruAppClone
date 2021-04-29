import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'nuruApp.db';
  static final _dbVersion = 1;
  static final _postsTable = 'posts';
  static final _postsMedia = 'postsMedia';

  static final columnPostID = 'postID';
  static final columnTitle = 'title';
  static final columnDescription = 'description';

  static final columnMediaID = 'mediaID';
  static final columnMediaType = 'mediaType';
  static final columnMediaPath = 'mediaPath';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
    
    CREATE TABLE $_postsTable( $columnPostID INTEGER PRIMARY KEY,
    $columnTitle TEXT NOT NULL, $columnDescription TEXT NOT NULL );
    
    CREATE TABLE $_postsMedia( $columnMediaID INTEGER PRIMARY KEY,
    $columnMediaType TEXT NOT NULL, $columnMediaPath TEXT NOT NULL, $columnPostID INTEGER NOT NULL,
     FOREIGN KEY ($columnPostID)
        REFERENCES $_postsTable ($columnPostID) 
     );
    ''');
  }

  Future<int> insertPost(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_postsTable, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    Database db = await instance.database;
    return await db.query(_postsTable);
  }

  Future updatePost(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnPostID];
    return await db
        .update(_postsTable, row, where: '$columnPostID = ?', whereArgs: [id]);
  }

  Future deletePost(int id) async {
    Database db = await instance.database;
    return await db
        .delete(_postsTable, where: '$columnPostID = ?', whereArgs: [id]);
  }
}
