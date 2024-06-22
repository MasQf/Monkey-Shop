class CartItem {
  final String id; // 商品的唯一标识符
  final String productImage; // 商品图片
  bool isSelected; // 添加 isSelected 属性
  // ===================
  final String o_classification = "二手商品";
  final String productName; // 商品名称
  final String o_goods_cname = "二手货";
  final String o_goods_sku = "SP00001";
  int quantity;
  final double productPrice;
  final double o_goods_total;
  final String o_goods_link = "https://github.com/MasQf/Monkey-Shop/tree/master";
  final String o_goods_enterprice = "广州市好掂有限公司";
  final String o_goods_ingrediant = "二手 100%";
  final String o_goods_note = "Null";

  CartItem({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
    this.isSelected = true, // 默认选中
  }) : o_goods_total = productPrice * quantity;

  // 从 JSON 数据创建 CartItem 对象
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productName: json['productName'],
      productPrice: double.parse(json['productPrice'].toString()), // 解析为 double
      productImage: json['productImage'],
      quantity: int.parse(json['quantity'].toString()), // 解析为 int
      isSelected: json['isSelected'] ?? true,
    );
  }

  // 将 CartItem 转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
      'quantity': quantity,
      'isSelected': isSelected,
      'o_classification': o_classification,
      'o_goods_cname': o_goods_cname,
      'o_goods_sku': o_goods_sku,
      'o_goods_total': o_goods_total,
      'o_goods_link': o_goods_link,
      'o_goods_enterprice': o_goods_enterprice,
      'o_goods_ingrediant': o_goods_ingrediant,
      'o_goods_note': o_goods_note,
    };
  }

  // 从 Map 创建 CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productName: map['productName'],
      productPrice: double.parse(map['productPrice'].toString()),
      productImage: map['productImage'],
      quantity: int.parse(map['quantity'].toString()),
      isSelected: map['isSelected'] ?? true,
    );
  }
}
