import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/OrderModel.dart';
import 'package:shop/services/DioService.dart';
import 'package:shop/widget/showNonBlockingDialog.dart';

class DeclarationForm extends StatefulWidget {
  final Order order;

  DeclarationForm({required this.order});

  @override
  _DeclarationFormState createState() => _DeclarationFormState();
}

class _DeclarationFormState extends State<DeclarationForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> jsonData = {};
  Response? submitResponse;
  Response? inquireResponse;

  @override
  void initState() {
    super.initState();
    jsonData = {
      "service_info": {
        "o_business_no": "",
        "type": 1,
        "o_business_type": "9610",
        "o_business_name": "2024052802批次零售出口",
        "o_ebc_name": "广州市好掂电子商务有限公司",
        "o_trading_mall_link": "https://cbec-mall.gzport.net/",
        "o_ebp_name": "CHEEHON CO.,LTD",
        "o_platform_buyer": "CHEEHON CO.,LTD",
        "o_supply_name": "东莞好掂二手厂",
        "o_declare_name": "广州好掂电子商务有限公司",
        "o_logistics_name": "广州好掂运输有限公司",
        "o_transport_name": "深圳市货拉拉运输有限公司",
        "o_transport_abroad_name": "好掂国际货运代理有限公司",
        "o_pay_name": "招商银行股份有限公司"
      },
      "service_base_info": {
        "o_export_contract": "ECK202405280002",
        "o_deal_curr": "美元",
        "o_price_term": "FOB",
        "o_freight_fee": "0",
        "o_insurance_fee": "0",
        "o_settle_date": "2024-05-31",
        "o_ebc_name": "广州好掂电子商务有限公司",
        "o_ebc_ename": "WEIXIN",
        "o_ebc_contact": "Weixing Zhang",
        "o_ebc_contact_tell": "+86-18620202525",
        "o_ebc_address": "广州市海珠区仑头路21号",
        "o_ebc_eaddress": "21 Luntou Road, Haizhu District, Guangzhou City",
        "o_plat_name": "CHEEHON CO.,LTD",
        "o_plat_ename": "CHEEHON CO.,LTD",
        "o_plat_contact": "SUSAN",
        "o_plat_contact_tell": "001-202-495-2266",
        "o_plat_address": "",
        "o_plat_eaddress": "3505 International Place,N.W. Washington,D.C.20008 U.S.A.",
        "o_special": "0",
        "o_ship_date": "2024-05-27",
        "o_pack_way": "4",
        "o_ship_way": "4",
        "o_ship_port": "广州",
        "o_country": "美国",
        "o_country_port": "华盛顿",
        "o_export_note": ""
      },
      "order_info": [
        {
          "o_order_no": "20240528000002",
          "o_pay_no": "P20240528000002",
          "o_waybill_no": "SF20240528000002",
          "o_charge": "100",
          "o_goods_value": "100",
          "o_currency": "502",
          "o_accounting_date": "20240528121312",
          "o_traf_mode": 5,
          "o_country": "502",
          "o_order_note": "",
          "order_goods_info": [
            {
              "o_classification": "二手货",
              "o_goods_ename": "dress",
              "o_goods_cname": "二手货",
              "o_goods_sku": "SP00001",
              "o_goods_num": "1",
              "o_goods_price": "100",
              "o_goods_total": 100,
              "o_goods_link": "https://github.com/MasQf/Monkey-Shop",
              "o_goods_enterprice": "广州市好掂电子商务有限公司",
              "o_goods_ingrediant": "二手100%",
              "o_goods_note": ""
            }
          ]
        }
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Customs Declaration',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            shadows: [
              BoxShadow(
                color: Color.fromARGB(255, 255, 255, 255),
                offset: Offset(2, 0),
                blurRadius: 2,
              )
            ],
          ),
        ),
        backgroundColor: Colors.amber[50],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber[100], borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 218, 98),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(64, 0, 0, 0),
                                      offset: Offset(1, 3),
                                      blurRadius: 8,
                                    )
                                  ]),
                              child: Center(
                                child: Text(
                                  'Export Subject Information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    shadows: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        offset: Offset(2, 0),
                                        blurRadius: 2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        for (var key in [
                          'o_business_no',
                          'type',
                          'o_business_type',
                          'o_business_name',
                          'o_ebc_name',
                          'o_trading_mall_link',
                          'o_ebp_name',
                          'o_platform_buyer',
                          'o_supply_name',
                          'o_declare_name',
                          'o_logistics_name',
                          'o_transport_name',
                          'o_transport_abroad_name',
                          'o_pay_name',
                        ])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 229, 150),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 2, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${key.toString()}: ',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        jsonData['service_info'][key].toString(),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber[100], borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 218, 98),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(64, 0, 0, 0),
                                      offset: Offset(1, 3),
                                      blurRadius: 8,
                                    )
                                  ]),
                              child: Center(
                                child: Text(
                                  'Export Basic Information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    shadows: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        offset: Offset(2, 0),
                                        blurRadius: 2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        for (var key in [
                          'o_export_contract',
                          'o_deal_curr',
                          'o_price_term',
                          'o_freight_fee',
                          'o_insurance_fee',
                          'o_settle_date',
                          'o_ebc_name',
                          'o_ebc_ename',
                          'o_ebc_contact',
                          'o_ebc_contact_tell',
                          'o_ebc_address',
                          'o_ebc_eaddress',
                          'o_plat_name',
                          'o_plat_ename',
                          'o_plat_contact',
                          'o_plat_contact_tell',
                          'o_plat_address',
                          'o_plat_eaddress',
                          'o_special',
                          'o_ship_date',
                          'o_pack_way',
                          'o_ship_way',
                          'o_ship_port',
                          'o_country',
                          'o_country_port',
                          'o_export_note',
                        ])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 229, 150),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 2, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${key.toString()}: ',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        jsonData['service_base_info'][key].toString(),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  for (var order in jsonData['order_info'])
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber[100], borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 218, 98),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(64, 0, 0, 0),
                                        offset: Offset(1, 3),
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Order Information',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      shadows: [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          offset: Offset(2, 0),
                                          blurRadius: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          for (var key in [
                            'o_order_no',
                            'o_pay_no',
                            'o_waybill_no',
                            'o_charge',
                            'o_goods_value',
                            'o_currency',
                            'o_accounting_date',
                            'o_traf_mode',
                            'o_country',
                            'o_order_note'
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 229, 150),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 2, 2, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          '${key.toString()}: ',
                                          style:
                                              TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          order[key].toString(),
                                          style:
                                              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 16),
                          Center(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 196, 0),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(64, 0, 0, 0),
                                        offset: Offset(1, 3),
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Order Items Details',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        shadows: [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            offset: Offset(2, 0),
                                            blurRadius: 2,
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Display order_goods_info
                          for (var goodsInfo in order['order_goods_info'])
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.amber[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var key in [
                                    'o_classification',
                                    'o_goods_ename',
                                    'o_goods_cname',
                                    'o_goods_sku',
                                    'o_goods_num',
                                    'o_goods_price',
                                    'o_goods_total',
                                    'o_goods_link',
                                    'o_goods_enterprice',
                                    'o_goods_ingrediant',
                                    'o_goods_note'
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 255, 215, 97),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 2, 2, 0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 140,
                                                child: Text(
                                                  '${key.toString()}: ',
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w900),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  goodsInfo[key].toString(),
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: Container(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  submitDeclaration();
                  showAlertDialog(context);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.summarize,
                    color: Color.fromARGB(255, 41, 41, 41),
                  ),
                  SizedBox(width: 5),
                  Text('SUBMIT')
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 252, 57)),
                  elevation: MaterialStateProperty.all(5)),
            ),
          ),
        )
      ]),
    );
  }

  void submitDeclaration() async {
    DioService dioService = DioService();
    Map<String, dynamic> requestData = dioService.addCommonParams(jsonData);
    requestData = requestData.map((key, value) => MapEntry(key, _convertToJson(value)));

    try {
      this.submitResponse = await dioService.dio.post(
        '/api/access_service/apply_service', //提交接口
        data: requestData,
      );
      if (submitResponse?.statusCode == 200) {
        print('提交成功: ${submitResponse?.data}');
      } else {
        print('提交失败: ${submitResponse?.statusMessage}');
      }
    } catch (e) {
      print('请求错误: $e');
    }
  }

  void inquire(String businessNo) async {
    DioService dioService = DioService();
    Map<String, dynamic> inquireData = dioService.addCommonParams({});
    inquireData['data']['o_business_no'] = businessNo;

    try {
      this.inquireResponse = await dioService.dio.post(
        '/api/access_service/get_apply_service', //查询接口
        data: inquireData,
      );
      if (inquireResponse?.statusCode == 200) {
        print('查询成功: ${inquireResponse?.data}');
        showNonBlockingDialog(context, '数据接入' + inquireResponse?.data['message']);
      } else {
        print('查询失败: ${inquireResponse?.statusMessage}');
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

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "   Submit Sucessfully !",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: const Color.fromARGB(255, 147, 110, 0),
        ),
      ),
      content: Container(
        height: 500,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/stamps.jpg",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      '订单号',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      submitResponse?.data['data']['business_no'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: Icon(Icons.info_outlined),
          onPressed: () {
            inquire(submitResponse?.data['data']['business_no']);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(254, 254, 254, 254)),
              elevation: MaterialStateProperty.all(3)),
        ),
        ElevatedButton(
          child: Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.of(context).pop(); // 关闭对话框
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(253, 255, 147, 147)),
              elevation: MaterialStateProperty.all(3)),
        ),
      ],
    );

    // 显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
