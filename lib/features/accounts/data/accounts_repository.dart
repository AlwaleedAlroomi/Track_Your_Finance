import 'package:financial_tracker/data/local/database_helper.dart';
import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:sqflite/sqflite.dart';

class AccountsRepository {
  final DatabaseHelper _databaseHelper;
  AccountsRepository(this._databaseHelper);

  // Create
  Future<int> addAccount(Account account) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      _databaseHelper.accountsTableName,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Account>> getAllAccounts() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> result =
        await db.query(_databaseHelper.accountsTableName);
    return List.generate(
      result.length,
      (index) => Account.fromMap(
        result[index],
      ),
    );
  }

  // Update
  Future<int> updateAccount(Account account) async {
    final db = await _databaseHelper.database;
    return await db.update(
      _databaseHelper.accountsTableName,
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  // Delete
  Future<int> deleteAccount(Account account) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      _databaseHelper.accountsTableName,
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }
}
