import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/CartItemModel.dart';
import 'package:shop/models/OrderModel.dart';
import 'package:shop/models/ProductModel.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  List<Order> _orders = []; // 订单列表

  List<CartItem> get items => _items;
  List<Order> get orders => _orders;

  bool get hasSelectedItems {
    return _items.any((item) => item.isSelected);
  }

  // 创建订单
  void createOrder({
    required String o_order_no,
    required String o_pay_no,
    required String o_waybill_no,
    required double o_charge,
    required double o_goods_value,
    required String o_currency,
    required DateTime o_accounting_date,
    required String o_traf_mode,
    required String o_country,
    required String o_order_note,
  }) {
    if (!hasSelectedItems) {
      // Handle case where no items are selected
      return;
    }

    final order = Order(
      o_order_no: o_order_no,
      o_pay_no: o_pay_no,
      o_waybill_no: o_waybill_no,
      o_charge: o_charge,
      o_goods_value: o_goods_value,
      o_currency: o_currency,
      o_accounting_date: o_accounting_date,
      o_traf_mode: o_traf_mode,
      o_country: o_country,
      o_order_note: o_order_note,
      items: _items.where((item) => item.isSelected).toList(),
    );

    _orders.add(order);
    _items.removeWhere((item) => item.isSelected); // 清除选中的购物车商品
    notifyListeners();
  }

  // 从SharedPreferences中加载购物车内容
  Future<void> loadCartFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartData = prefs.getStringList('cart');

    if (cartData != null) {
      _items = cartData.map((json) => CartItem.fromJson(jsonDecode(json))).toList();
    }
    notifyListeners();
  }

  // 将购物车内容保存到SharedPreferences中
  Future<void> saveCartToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartData = _items.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('cart', cartData);
  }

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(
        id: product.id,
        productName: product.name,
        productPrice: product.price,
        productImage: product.images[0],
      ));
    }
    notifyListeners();
  }

  void addItemQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity -= 1;
      notifyListeners();
    }
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

  double get totalPrice {
    return _items
        .where((item) => item.isSelected)
        .fold(0.00, (sum, item) => sum + item.productPrice * item.quantity);
  }

  bool get isAllSelected {
    return _items.isNotEmpty && _items.every((item) => item.isSelected);
  }

  void updateItemSelection(String id, bool isSelected) {
    _items = _items.map((item) {
      if (item.id == id) {
        item.isSelected = isSelected;
      }
      return item;
    }).toList();
    notifyListeners();
  }

  void toggleSelectAll(bool isSelected) {
    _items = _items.map((item) {
      item.isSelected = isSelected;
      return item;
    }).toList();

    notifyListeners();
  }
}
