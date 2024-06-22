import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/router/routes.dart';
import 'package:shop/services/DioService.dart';
import 'package:shop/widget/showNonBlockingDialog.dart';

class OrdersTab extends StatefulWidget {
  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  Response? uploadResponse;
  Map<String, dynamic> jsonData = {};
  Response? submitResponse;

  @override
  void initState() {
    super.initState();
    jsonData = {
      "type": "purchase_contract",
      "business_no": "DZYW2024062100082",
      "message_list": [
        {"url": "", "name": ""}
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 226, 124),
            ),
            child: ListView.builder(
              itemCount: cartProvider.orders.length,
              itemBuilder: (context, index) {
                final order = cartProvider.orders[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(238, 244, 244, 244),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(108, 0, 0, 0),
                            offset: Offset(0.3, 1),
                            blurRadius: 5,
                          )
                        ]),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '#${order.o_order_no}#',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text('Pay No.: ${order.o_pay_no}'),
                              Text('Waybill No.: ${order.o_waybill_no}'),
                              Text('Charge: ${order.o_charge}'),
                              Text('Goods Value: ${order.o_goods_value}'),
                              Text('Currency: ${order.o_currency}'),
                              Text('Accounting Date: ${order.o_accounting_date}'),
                              Text('Traf Mode: ${order.o_traf_mode}'),
                              Text('Country: ${order.o_country}'),
                              Text('Note: ${order.o_order_note}'),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        ...order.items.map((item) => Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(112, 255, 255, 255),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        item.productImage,
                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.productName}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'X ${item.quantity}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showNonBlockingDialog(context, '(800) 442‑4000');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Color.fromARGB(255, 24, 24, 24),
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(120, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    transmit();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.upload_file_rounded,
                                        color: Color.fromARGB(255, 205, 133, 63),
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RoutePath.DeclarationForm,
                                        arguments: order);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.checklist_rtl_sharp,
                                        color: Color.fromARGB(255, 41, 41, 41),
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Color.fromARGB(255, 255, 252, 57)),
                                      elevation: MaterialStateProperty.all(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void inquire(String businessNo) async {
    DioService dioService = DioService();
    Map<String, dynamic> inquireData = dioService.addCommonParams({});
    inquireData['data']['o_business_no'] = businessNo;

    try {
      this.uploadResponse = await dioService.dio.post(
        '/api/access_service/save_apply_service',
        data: inquireData,
      );
      if (uploadResponse?.statusCode == 200) {
        print('查询成功: ${uploadResponse?.data}');
      } else {
        print('查询失败: ${uploadResponse?.statusMessage}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }

  dynamic _convertToJson(dynamic value) {
    if (value is DateTime) {
      return value.toIso8601String();
    } else if (value is List) {
      return value.map((v) => _convertToJson(v)).toList();
    } else if (value is Map) {
      return value.map((k, v) => MapEntry(k, _convertToJson(v)));
    } else {
      return value;
    }
  }

  void transmit() async {
    DioService dioService = DioService();
    Map<String, dynamic> requestData = dioService.addCommonParams(jsonData);

    requestData = requestData.map((key, value) => MapEntry(key, _convertToJson(value)));

    try {
      this.submitResponse = await dioService.dio.post(
        '/api/access_service/save_apply_service', // 单证传输
        data: requestData,
      );
      if (submitResponse?.statusCode == 200) {
        print('提交成功: ${submitResponse?.data}');
        showNonBlockingDialog(context, '单证传输' + submitResponse?.data['message']);
      } else {
        print('提交失败: ${submitResponse?.statusMessage}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }
}
