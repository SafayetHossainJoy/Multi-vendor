
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// class DBProvider {
//   // Create a singleton
//   DBProvider._();
//
//   static final DBProvider db = DBProvider._();
//   Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//
//     _database = await initDB();
//     return _database;
//   }
//
//   initDB() async {
//     // Get the location of our app directory. This is where files for our app,
//     // and only our app, are stored. Files in this directory are deleted
//     // when the app is deleted.
//     Directory documentsDir = await getApplicationDocumentsDirectory();
//     String path = join(documentsDir.path, 'odoo.db');
//
//
//     return await openDatabase(path, version: 1, onOpen: (db) async {
//     }, onCreate: (Database db, int version) async {
//       // Create the note table
//       await db.execute('''
//                 CREATE TABLE category(
//                     id TEXT PRIMARY KEY,
//                     contents TEXT DEFAULT ''
//                 )
//             ''');
//     });
//   }
// }
