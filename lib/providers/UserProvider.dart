import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/UserModel.dart';
import '../services/UserService.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  String _username = '你没有';
  String _email = '登录/注册';
  bool _isLoggedIn = false;
  bool _hasLoadedUser = false; // New property

  String get username => _username;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasLoadedUser => _hasLoadedUser; // Getter for hasLoadedUser

  // 注册用户
  Future<bool> registerUser(String username, String email, String password) async {
    try {
      User user = User(username: username, email: email, password: password, isLoggedIn: 0);
      User? savedUser = await _userService.saveUser(user);
      return savedUser != null;
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }

  // 登录用户
  Future<bool> loginUser(String username, String password) async {
    try {
      bool isValid = await _userService.validateUser(username, password);
      if (isValid) {
        await _userService.loginUser(username, password);
        User? user = await _userService.getUser(username);
        if (user != null) {
          _username = user.username;
          _email = user.email;
          _isLoggedIn = true; // Set isLoggedIn to true
          await saveUserToPreferences(_username, _email, _isLoggedIn);
          notifyListeners();
        }
        return true; // 登录成功
      }
      return false; // 登录失败
    } catch (e) {
      print('Login failed: $e');
      return false; // 登录失败
    }
  }

  // 将用户信息保存到 SharedPreferences
  Future<void> saveUserToPreferences(String username, String email, bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // 从 SharedPreferences 加载用户信息
  Future<void> loadUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      _username = prefs.getString('username') ?? '你没有';
      _email = prefs.getString('email') ?? '登录/注册';
      _hasLoadedUser = true; // Set hasLoadedUser to true
      print('===============loadUserFromPreferences===============');
      notifyListeners();
    }
  }

  // 获取当前用户登录状态
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return _isLoggedIn;
  }

  // 更新用户信息
  Future<void> updateUser(User user) async {
    try {
      await _userService.updateUser(user);
      notifyListeners();
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  // 删除用户
  Future<void> deleteUser(int id) async {
    try {
      await _userService.deleteUser(id);
      notifyListeners();
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  // 获取用户信息
  Future<User?> getUser(String username) async {
    try {
      return await _userService.getUser(username);
    } catch (e) {
      print('Failed to get user: $e');
      return null;
    }
  }

  // 用户登出
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    await prefs.remove('email');
    _username = '你没有';
    _email = '登录/注册';
    _isLoggedIn = false;
    notifyListeners();
  }
}
