class CartItem {
  final String id; // 商品的唯一标识符
  final String productName; // 商品名称
  final double productPrice; // 商品价格
  final String productImage; // 商品图片
  int quantity; // 商品数量
  bool isSelected; // 添加 isSelected 属性

  CartItem({
    required this.id, // 修改为id
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
    this.isSelected = true, // 默认选中
  });

  // 将 CartItem 转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // 修改为id
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
      'quantity': quantity,
    };
  }

  // 从 Map 创建 CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'], // 修改为id
      productName: map['productName'],
      productPrice: map['productPrice'],
      productImage: map['productImage'],
      quantity: map['quantity'],
    );
  }
}
