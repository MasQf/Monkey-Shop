import 'package:shop/models/CartItemModel.dart';
import 'package:shop/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class CartService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertCartItem(CartItem item) async {
    final db = await _databaseHelper.database;
    await db.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query('cart');

    return maps.map((map) => CartItem.fromMap(map)).toList();
  }

  Future<void> clearCart() async {
    final db = await _databaseHelper.database;
    await db.delete('cart');
  }

  Future<void> removeCartItem(String productId) async {
    final db = await _databaseHelper.database;
    await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    final db = await _databaseHelper.database;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }
}
