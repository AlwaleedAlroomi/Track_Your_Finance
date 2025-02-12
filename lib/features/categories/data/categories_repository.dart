import 'package:financial_tracker/data/local/database_helper.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesRepository {
  final DatabaseHelper _databaseHelper;
  CategoriesRepository(this._databaseHelper);

  // Create
  Future<int> addCategory(Category category) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      _databaseHelper.categoriesTableName,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Category>> getAllCategories() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(_databaseHelper.categoriesTableName);
    return List.generate(
      maps.length,
      (index) => Category.fromMap(
        maps[index],
      ),
    );
  }

  // Update
  Future<int> updateCategory(Category category) async {
    final db = await _databaseHelper.database;
    return await db.update(
      _databaseHelper.categoriesTableName,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // Delete
  Future<int> deleteCategory(Category category) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      _databaseHelper.categoriesTableName,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
