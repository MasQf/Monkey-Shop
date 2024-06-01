import 'package:shop/models/UserModel.dart';
import 'package:shop/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // 注册保存用户数据
  Future<User?> saveUser(User user) async {
    Database db = await _databaseHelper.database;
    int id = await db.insert('users', user.toMap()..remove('id')); // 移除 id 字段
    if (id != 0) {
      return User(
        id: id,
        username: user.username,
        email: user.email,
        password: user.password,
        isLoggedIn: user.isLoggedIn,
      );
    }
    return null;
  }

  // 登录用户
  Future<void> loginUser(String username, String password) async {
    User? user = await getUser(username);
    if (user != null && user.password == password) {
      await _databaseHelper.logoutAllUsers();
      User loggedInUser = User(
          id: user.id,
          username: user.username,
          email: user.email,
          password: user.password,
          isLoggedIn: 1);
      await updateUser(loggedInUser);
    }
  }

  // 获取用户数据
  Future<User?> getUser(String username) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  // 验证用户信息
  Future<bool> validateUser(String username, String password) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db
        .query('users', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    return result.isNotEmpty;
  }

  // 删除用户
  Future<int> deleteUser(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // 登出用户
  Future<void> logoutUser(int id) async {
    await _databaseHelper.logoutUser(id);
  }

  // 登出所有用户
  Future<void> logoutAllUsers() async {
    await _databaseHelper.logoutAllUsers();
  }

  // 获取已登录用户
  Future<User?> getLoggedInUser() async {
    return await _databaseHelper.getLoggedInUser();
  }

  // 更新用户信息
  Future<int> updateUser(User user) async {
    Database db = await _databaseHelper.database;
    return await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}
