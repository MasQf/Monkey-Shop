class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
