import 'package:financial_tracker/data/local/database_helper.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';

class WishlistRepository {
  final DatabaseHelper _databaseHelper;

  WishlistRepository(this._databaseHelper);

  Future<int> addWishItem(Wishlist wish) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      _databaseHelper.wishlistTableName,
      wish.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Wishlist>> getAllWishes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> result =
        await db.query(_databaseHelper.wishlistTableName);
    return List.generate(
      result.length,
      (index) => Wishlist.fromJson(result[index]),
    );
  }

  Future<int> updateWishItem(Wishlist wishItem) async {
    final db = await _databaseHelper.database;
    return await db.update(
      _databaseHelper.wishlistTableName,
      wishItem.toMap(),
      where: 'id = ?',
      whereArgs: [wishItem.id],
    );
  }

  Future<int> deleteWishItem(Wishlist wishItem) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      _databaseHelper.wishlistTableName,
      where: 'id = ?',
      whereArgs: [wishItem.id],
    );
  }
}
