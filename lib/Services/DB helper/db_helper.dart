import 'dart:developer';

import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Services/DB%20helper/query_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final _databaseName = 'MachineTest';
  final _databaseVersion = 0;
  final _newVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _newVersion,
      onCreate: (db, version) => _onCreate(db),
    );
  }

  _onCreate(Database db) async {
    for (int i = 0; i < QueryTable.dbQueryTable.length; i++) {
      try {
        await db.execute(QueryTable.dbQueryTable[i]);
      } catch (e) {
        continue;
      }
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductList() async {
    Database? db = await DBHelper._database;
    await Future.delayed(Duration(milliseconds: 100));
    return await db!.rawQuery('''
SELECT *
FROM
    ${ProductListImportantNames.tableName} p
    JOIN ${RatingImportantNames.tableName} r 
     ON r.${RatingImportantNames.id} = p.${ProductListImportantNames.id}
''');
  }

  Future<int> insertProduct({required ProductListModel product}) async {
    Database? db = await DBHelper._database;
    return await db!.insert(ProductListImportantNames.tableName, {
      ProductListImportantNames.id: product.id,
      ProductListImportantNames.title: product.title,
      ProductListImportantNames.price: product.price,
      ProductListImportantNames.description: product.description,
      ProductListImportantNames.category: product.category,
      ProductListImportantNames.image: product.image,
      ProductListImportantNames.quantity: product.quantity,
      ProductListImportantNames.isCart: product.isCart,
    });
  }

  Future<int> insertRateing({required RatingModel rateing}) async {
    Database? db = await DBHelper._database;
    return await db!.insert(RatingImportantNames.tableName, {
      RatingImportantNames.id: rateing.id,
      RatingImportantNames.rate: rateing.rate,
      RatingImportantNames.count: rateing.count,
    });
  }

  Future<int> updateProduct(int id, int quantity) async {
    return await _database!.rawUpdate('''
    UPDATE ${ProductListImportantNames.tableName}
    SET ${ProductListImportantNames.quantity} = ?
    WHERE ${ProductListImportantNames.id} = ?
    ''', [quantity, id]);
  }

  Future<int> deleteProduct({required int id}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(ProductListImportantNames.tableName,
        where: '${ProductListImportantNames.id} = ?', whereArgs: [id]);
  }

  Future<int> deleteRating({required int id}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(RatingImportantNames.tableName,
        where: '${RatingImportantNames.id} = ?', whereArgs: [id]);
  }
}
