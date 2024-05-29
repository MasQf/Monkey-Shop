import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:shop/widget/ProductReview.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/ProductsProvider.dart';

class HatDetail extends StatefulWidget {
  const HatDetail({super.key});

  @override
  State<HatDetail> createState() => _HatDetailState();
}

class _HatDetailState extends State<HatDetail> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final hatProduct = productsProvider.products['hat'];

    return Consumer<ProductsProvider>(
      builder: ((context, ProductsProvider, child) => Stack(
            children: [
              Scaffold(
                backgroundColor: Color.fromRGBO(227, 211, 195, 1),
                appBar: PreferredSize(
                  //appBar的高度
                  preferredSize: Size.fromHeight(60.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: AppBar(
                      title: Text(
                        'Sun hat',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 2),
                            blurRadius: 5.0,
                          )
                        ]),
                      ),
                      backgroundColor: Color.fromRGBO(193, 175, 157, 1),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              hatProduct.isFavorite = !hatProduct.isFavorite;
                            });
                          },
                          icon: hatProduct!.isFavorite
                              ? Icon(Icons.star_rate_rounded)
                              : Icon(Icons.star_border_rounded),
                        )
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 商品图片
                      Container(
                        decoration: BoxDecoration(color: Color.fromARGB(255, 240, 236, 236)),
                        height: 330,
                        width: double.infinity,
                        child: Swiper(
                          itemCount: hatProduct.images.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              hatProduct.images[index],
                              fit: BoxFit.cover,
                            );
                          },
                          autoplay: false,
                          pagination: SwiperPagination(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // 商品信息
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hatProduct.name,
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  hatProduct.price.toString(),
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            Divider(color: Color.fromRGBO(0, 0, 0, 0.5)),
                            // 基本信息
                            Row(
                              children: [
                                Text(
                                  '基本信息',
                                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.line_weight_sharp,
                                  size: 26,
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '商品尺寸',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '商品重量',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '制造商',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'ASIN',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '型号',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '制造商是否已停产',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '涂饰工艺类型',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '可在洗碗机中清洗',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '需要组装',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '件数',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '需要电池',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '随附部件',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '进口',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1.5 x 1.5 x ',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '3.5 inches',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '3.84 ounces',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'DEMDACO - Home',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'B005MS8354',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '26062',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Painted',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Willow Tree Angel',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'of Comfort Figure',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Made in USA or',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Imported',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(color: Color.fromRGBO(0, 0, 0, 0.5)),
                            // 商品描述
                            Row(
                              children: [
                                Text(
                                  '商品描述',
                                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.description,
                                  size: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              hatProduct.description,
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Divider(color: Color.fromRGBO(0, 0, 0, 0.5)),

                            // 评论区
                            Row(
                              children: [
                                Text(
                                  '客户评论',
                                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.message,
                                  size: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Container(
                              child: ProductReview(
                                averageStars: 4.9,
                                reviews: hatProduct.reviews,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(237, 190, 119, 1),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          // 购物车图标
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/carttab');
                            },
                            icon: Icon(Icons.shopping_cart),
                            color: Colors.black,
                            iconSize: 30,
                          ),
                          // 点击TAKE按钮后购物车右上角显示的数字
                          if (cartProvider.items
                                  .where((item) => item.id == hatProduct.id)
                                  .isNotEmpty &&
                              cartProvider.items
                                      .firstWhere((item) => item.id == hatProduct.id)
                                      .quantity >
                                  99)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Color.fromRGBO(193, 144, 103, 0.7),
                                child: Text(
                                  '...',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                                ),
                              ),
                            )
                          else if (cartProvider.items
                                  .where((item) => item.id == hatProduct.id)
                                  .isNotEmpty &&
                              cartProvider.items
                                      .firstWhere((item) => item.id == hatProduct.id)
                                      .quantity >
                                  0 &&
                              cartProvider.items
                                      .firstWhere((item) => item.id == hatProduct.id)
                                      .quantity <=
                                  99)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Color.fromRGBO(193, 144, 103, 0.7),
                                child: Text(
                                  cartProvider.items
                                      .firstWhere((item) => item.id == hatProduct.id)
                                      .quantity
                                      .toString(),
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                ),
                              ),
                            )
                        ],
                      ),
                      Stack(
                        children: [
                          // TAKE按钮
                          ElevatedButton(
                            onPressed: () {
                              cartProvider.addItem(hatProduct);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.front_hand_rounded),
                                SizedBox(width: 5),
                                Text('TAKE'),
                              ],
                            ),
                            style: ButtonStyle(elevation: MaterialStateProperty.all(8)),
                          ),
                          SizedBox(width: 220),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // BUY按钮
              Positioned(
                  right: 20,
                  bottom: 4,
                  child: Container(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.wallet,
                              color: const Color.fromARGB(255, 49, 62, 69),
                            ),
                            SizedBox(width: 5),
                            Text('BUY')
                          ],
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(const Color.fromARGB(255, 151, 234, 153)),
                            elevation: MaterialStateProperty.all(5)),
                      )))
            ],
          )),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "    Thank You !",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
    ),
    content: Image.asset(
      "assets/images/pay.jpg",
      fit: BoxFit.contain,
    ),
    actions: [
      ElevatedButton(
        child: Icon(Icons.close_rounded),
        onPressed: () {
          Navigator.of(context).pop(); // 关闭对话框
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(254, 254, 254, 254)),
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
