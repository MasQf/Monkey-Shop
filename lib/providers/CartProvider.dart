import 'package:flutter/cupertino.dart';
import 'package:shop/models/CartItemModel.dart';
import 'package:shop/models/ProductModel.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(
        id: product.id, // 修改为id
        productName: product.name,
        productPrice: product.price,
        productImage: product.images[0], // Assuming the first image is the main one
      ));
    }
    notifyListeners();
  }

  void addItemQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);

    _items[index].quantity += 1;

    notifyListeners();
  }

  void decreaseItemQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity -= 1;
    } else if (index >= 0 && _items[index].quantity == 1) {
      _items[index].quantity = 1;
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    for (var item in _items) {
      if (item.id == product.id) {
        item.quantity = quantity;
        notifyListeners();
        return;
      }
    }
  }

  // 获取所有商品的总价
  double get totalPrice {
    return _items
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + item.productPrice * item.quantity);
  }

  // 检查是否所有商品都被选中
  bool get isAllSelected {
    return _items.isNotEmpty && _items.every((item) => item.isSelected);
  }

  // 更新商品的选择状态
  void updateItemSelection(String id, bool isSelected) {
    _items = _items.map((item) {
      if (item.id == id) {
        item.isSelected = isSelected;
      }
      return item;
    }).toList();
    notifyListeners();
  }

  // 切换所有商品的选择状态
  void toggleSelectAll(bool isSelected) {
    _items = _items.map((item) {
      item.isSelected = isSelected;
      return item;
    }).toList();
    notifyListeners();
  }
}
