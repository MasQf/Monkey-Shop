class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final int isLoggedIn; // 使用 int 类型表示登录状态

  User({
    this.id, // id 是可选的
    required this.username,
    required this.email,
    required this.password,
    required this.isLoggedIn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'isLoggedIn': isLoggedIn,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      isLoggedIn: map['isLoggedIn'],
    );
  }
}
