import 'package:shop/models/CartItemModel.dart';

class Order {
  final String o_order_no; // 订单号
  final String o_pay_no; // 收款单号
  final String o_waybill_no; // 运单号
  final double o_charge; // 实收金额
  final double o_goods_value; // 商品总额
  final String o_currency; // 订单成交金额币种
  final DateTime o_accounting_date; // 支付时间
  final String o_traf_mode; // 运输方式
  final String o_country; // 收货地国家
  final String o_order_note; // 订单备注
  final List<CartItem> items; // 订单包含的购物车项

  Order({
    required this.o_order_no,
    required this.o_pay_no,
    required this.o_waybill_no,
    required this.o_charge,
    required this.o_goods_value,
    required this.o_currency,
    required this.o_accounting_date,
    required this.o_traf_mode,
    required this.o_country,
    required this.o_order_note,
    required this.items,
  });

  // toMap 和 fromJson 方法
  Map<String, dynamic> toMap() {
    return {
      'o_order_no': o_order_no,
      'o_pay_no': o_pay_no,
      'o_waybill_no': o_waybill_no,
      'o_charge': o_charge,
      'o_goods_value': o_goods_value,
      'o_currency': o_currency,
      'o_accounting_date': o_accounting_date.toIso8601String(),
      'o_traf_mode': o_traf_mode,
      'o_country': o_country,
      'o_order_note': o_order_note,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      o_order_no: json['o_order_no'],
      o_pay_no: json['o_pay_no'],
      o_waybill_no: json['o_waybill_no'],
      o_charge: json['o_charge'],
      o_goods_value: json['o_goods_value'],
      o_currency: json['o_currency'],
      o_accounting_date: DateTime.parse(json['o_accounting_date']),
      o_traf_mode: json['o_traf_mode'],
      o_country: json['o_country'],
      o_order_note: json['o_order_note'],
      items: (json['items'] as List).map((item) => CartItem.fromJson(item)).toList(),
    );
  }
}
