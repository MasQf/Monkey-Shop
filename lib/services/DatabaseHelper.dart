import 'package:shop/models/CartItemModel.dart';
import 'package:shop/models/ProductModel.dart';
import 'package:shop/models/UserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'shop.db');
    return await openDatabase(
      path,
      version: 4, // Update version number as needed
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        isLoggedIn INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        productId TEXT,
        quantity INTEGER,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        orderDetails TEXT,
        orderDate TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        images TEXT,
        reviews TEXT,
        isFavorite INTEGER DEFAULT 0
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE products (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          description TEXT,
          price REAL NOT NULL,
          images TEXT,
          reviews TEXT,
          isFavorite INTEGER DEFAULT 0
        )
      ''');
    }
  }

  // 用户相关操作
  Future<void> logoutAllUsers() async {
    Database db = await database;
    await db.update('users', {'isLoggedIn': 0});
  }

  Future<void> logoutUser(int id) async {
    Database db = await database;
    await db.update('users', {'isLoggedIn': 0}, where: 'id = ?', whereArgs: [id]);
  }

  Future<User?> getLoggedInUser() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('users', where: 'isLoggedIn = ?', whereArgs: [1]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  // 商品相关操作
  Future<void> insertProduct(Product product) async {
    Database db = await database;
    await db.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Product?> getProductById(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('products', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : null;
  }

  Future<List<Product>> getAllProducts() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> updateProduct(Product product) async {
    Database db = await database;
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<void> deleteProduct(String id) async {
    Database db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // 购物车相关操作
  Future<void> insertCartItem(CartItem item) async {
    Database db = await database;
    await db.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItemsByUserId(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('cart', where: 'userId = ?', whereArgs: [userId]);
    return result.map((map) => CartItem.fromMap(map)).toList();
  }

  Future<void> clearCartByUserId(int userId) async {
    Database db = await database;
    await db.delete('cart', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> removeCartItem(int userId, String productId) async {
    Database db = await database;
    await db.delete('cart', where: 'userId = ? AND productId = ?', whereArgs: [userId, productId]);
  }

  Future<void> updateCartItemQuantity(int userId, String productId, int quantity) async {
    Database db = await database;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'userId = ? AND productId = ?',
      whereArgs: [userId, productId],
    );
  }
}
