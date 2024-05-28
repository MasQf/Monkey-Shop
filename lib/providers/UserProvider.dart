import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/UserService.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  String _username = '你没有';
  String _email = '登录/注册';

  String get username => _username;
  String get email => _email;

  Future<bool> registerUser(String username, String email, String password) async {
    try {
      Map<String, dynamic> user = {
        'username': username,
        'email': email,
        'password': password,
      };
      await _userService.saveUser(user);
      return true; // Registration successful
    } catch (e) {
      print('Registration failed: $e');
      return false; // Registration failed
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      bool isValid = await _userService.validateUser(username, password);
      if (isValid) {
        Map<String, dynamic>? userData = await _userService.getUser(username);
        if (userData != null) {
          _username = userData['username'];
          _email = userData['email'];
          await saveUserToPreferences(_username, _email);
          notifyListeners();
        }
      }
      return isValid; // Return true if login is successful, false otherwise
    } catch (e) {
      print('Login failed: $e');
      return false; // Login failed
    }
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    try {
      await _userService.updateUser(user);
      notifyListeners();
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _userService.deleteUser(id);
      notifyListeners();
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    try {
      return await _userService.getUser(username);
    } catch (e) {
      print('Failed to get user: $e');
      return null;
    }
  }

  Future<void> saveUserToPreferences(String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> loadUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      _username = prefs.getString('username') ?? '你没有';
      _email = prefs.getString('email') ?? '登录/注册';
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _username = '你没有';
    _email = '登录/注册';
    print(_username + _email);
    notifyListeners();
  }
}
