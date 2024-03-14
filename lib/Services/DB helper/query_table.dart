import 'package:machine_test/Model/product_list_model.dart';

class QueryTable {
  static var dbQueryTable = [
    '''
    CREATE TABLE ${ProductListImportantNames.tableName}(
       ${ProductListImportantNames.id} INTEGER,
      ${ProductListImportantNames.title} TEXT,
      ${ProductListImportantNames.price} REAL,
      ${ProductListImportantNames.description} TEXT,
      ${ProductListImportantNames.category} TEXT,
      ${ProductListImportantNames.image} TEXT,
      ${ProductListImportantNames.quantity} INTEGER,
      ${ProductListImportantNames.isCart} INTEGER
    )
''',
    '''
    CREATE TABLE ${RatingImportantNames.tableName}(
       ${RatingImportantNames.id} INTEGER,
      ${RatingImportantNames.rate} REAL,
      ${RatingImportantNames.count} INTEGER
    )
'''
  ];
}
