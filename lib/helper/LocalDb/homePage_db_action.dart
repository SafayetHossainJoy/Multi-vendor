
// import 'db_provider.dart';
// import 'homepage_db_model.dart';
//
// class HomePageDBAction{
//
//   static newProduct(HomePageDbModel note) async {
//     final db = await DBProvider.db.database;
//     HomePageDbModel? data = await HomePageDBAction.getProduct(note.id.toString());
//     if(data?.id  != null) {
//       return;
//     }
//
//     var res = await db?.insert('homepage', note.toJson());
//     return res;
//   }
//
//   static getProducts() async {
//     final db = await DBProvider.db.database;
//     var res = await db?.query('homepage');
//     List<HomePageDbModel>? notes = (res?.isNotEmpty ?? false) ? res?.map((note) => HomePageDbModel.fromJson(note)).toList() : [];
//     return notes;
//   }
//
//   static getProduct(String id) async {
//     final db = await DBProvider.db.database;
//     var res = await db?.query('homepage', where: 'id = ?', whereArgs: [id]);
//     return (res?.isNotEmpty ?? false) ? HomePageDbModel.fromJson(res!.first) : null;
//   }
//
//   static updateProduct(HomePageDbModel note) async {
//     final db = await DBProvider.db.database;
//     var res = await db?.update('homepage', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
//     return res;
//   }
//
//   static deleteProduct(String id) async {
//     final db = await DBProvider.db.database;
//     db?.delete('category', where: 'id = ?', whereArgs: [id]);
//   }
// }
