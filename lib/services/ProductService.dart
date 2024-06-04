import 'package:shop/models/ProductModel.dart';
import 'package:sqflite/sqflite.dart';
import 'DatabaseHelper.dart';

class ProductService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //插入商品
  Future<void> insertProduct(Product product) async {
    final db = await _dbHelper.database;
    await db.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    for (var review in product.reviews) {
      await db.insert('reviews', {
        'productId': product.id,
        ...review.toMap(),
      });
    }
  }

  //更新商品
  Future<void> updateProduct(Product product) async {
    final db = await _dbHelper.database;
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
    await db.delete('reviews', where: 'productId = ?', whereArgs: [product.id]);
    for (var review in product.reviews) {
      await db.insert('reviews', {
        'productId': product.id,
        ...review.toMap(),
      });
    }
  }

  //删除商品
  Future<void> deleteProduct(String productId) async {
    final db = await _dbHelper.database;
    await db.delete('products', where: 'id = ?', whereArgs: [productId]);
    await db.delete('reviews', where: 'productId = ?', whereArgs: [productId]);
  }

  //通过id获取商品
  Future<Product?> getProductById(String productId) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> productMaps =
        await db.query('products', where: 'id = ?', whereArgs: [productId]);
    if (productMaps.isNotEmpty) {
      List<Map<String, dynamic>> reviewMaps =
          await db.query('reviews', where: 'productId = ?', whereArgs: [productId]);
      List<Review> reviews = reviewMaps.map((map) => Review.fromMap(map)).toList();
      return Product.fromMap({...productMaps.first, 'reviews': reviews});
    }
    return null;
  }

  //获取所有商品的列表
  Future<List<Product>> getAllProducts() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> productMaps = await db.query('products');
    List<Product> products = [];
    for (var productMap in productMaps) {
      List<Map<String, dynamic>> reviewMaps =
          await db.query('reviews', where: 'productId = ?', whereArgs: [productMap['id']]);
      List<Review> reviews = reviewMaps.map((map) => Review.fromMap(map)).toList();
      products.add(Product.fromMap({...productMap, 'reviews': reviews}));
    }
    return products;
  }
}
