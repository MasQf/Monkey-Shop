import 'package:shop/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // 保存用户数据
  Future<int> saveUser(Map<String, dynamic> user) async {
    Database db = await _databaseHelper.database;
    return await db.insert('users', user);
  }

  // 获取用户数据
  Future<Map<String, dynamic>?> getUser(String username) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    return result.isNotEmpty ? result.first : null;
  }

  // 验证用户信息
  Future<bool> validateUser(String username, String password) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db
        .query('users', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    return result.isNotEmpty;
  }

  // 更新用户信息
  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await _databaseHelper.database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [user['id']]);
  }

  // 删除用户
  Future<int> deleteUser(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
