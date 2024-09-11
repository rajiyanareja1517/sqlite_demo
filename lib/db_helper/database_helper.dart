import 'package:lab_work_9_3/models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  Database? db;
  static DatabaseHelper dbHelper = DatabaseHelper._();

  initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, "rv.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS category(category_id INTEGER PRIMARY KEY AUTOINCREMENT, category_name TEXT NOT NULL, category_image BLOB);";
        await db.execute(query);
      },
    );
  }

  //TODO: insert a category
  Future<int> insertCategory({required CategoryModel model}) async {
    if (db == null) {
      await initDB();
    }
    String query =
        "INSERT INTO category(category_name,category_image) VALUES(?,?);";
    List args = [model.cat_name, model.cat_img];
    int? id = await db?.rawInsert(query, args);
    return id!;
  } //TODO: insert a category

  Future<List<CategoryModel>> fetchAllCategories() async {
    if (db == null) {
      await initDB();
    }
    String query = "SELECT * FROM category";

    List<Map<String, dynamic>> responseList = await db!.rawQuery(query);
    print("List:::"+responseList.toString());
    List<CategoryModel> allCategories =
        responseList.map((e) => CategoryModel.fromMap(data: e)).toList();

    return allCategories;
  }
}
