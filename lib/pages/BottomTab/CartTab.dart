import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/CartItemModel.dart';
import 'package:shop/pages/DetailPage/AngelDetail.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/widget/showNonBlockingDialog.dart';

class CartTab extends StatefulWidget {
  final bool showBackButton;
  const CartTab({Key? key, required this.showBackButton}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        List<Widget> cartItems = cartProvider.items.map((item) => _buildCartItem(item)).toList();
        double totalPrice = cartProvider.totalPrice;

        return Scaffold(
          appBar: widget.showBackButton
              ? AppBar(
                  backgroundColor: Color.fromARGB(255, 249, 226, 124),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              : null,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 226, 124),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(cartItems.isEmpty ? 0 : 10,
                      cartItems.isEmpty ? 170 : 30, 0, 80), // 根据 cartItems 是否为空设置顶部边距
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cartItems.isEmpty)
                        Center(
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/cart.png',
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                top: -80,
                                left: -150,
                                child: Transform.rotate(
                                  angle: 40,
                                  child: Container(
                                    width: 400,
                                    child: Image.asset(
                                      'assets/images/finger.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 80,
                                  child: Row(
                                    children: [
                                      Text(
                                        ' No trading,No ',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'killing',
                                        style: TextStyle(
                                            fontSize: 31,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      else
                        ...cartItems,
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              //底部结算栏
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  color: Color.fromARGB(255, 249, 226, 124),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              value: cartProvider.isAllSelected,
                              onChanged: (bool? value) {
                                cartProvider.toggleSelectAll(value ?? false);
                              },
                              shape: CircleBorder(),
                              activeColor: Color.fromARGB(255, 255, 175, 3),
                            ),
                          ),
                          Text(
                            'All',
                            style: TextStyle(
                              color: cartItems.isEmpty
                                  ? const Color.fromARGB(255, 138, 135, 135)
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$ ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 49, 62, 69),
                            ),
                          ),
                          SizedBox(width: 130),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 10,
                child: Container(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.handshake_rounded,
                          color: Color.fromARGB(255, 49, 62, 69),
                        ),
                        SizedBox(width: 5),
                        Text('DEAL')
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color.fromARGB(255, 151, 234, 153)),
                      elevation: MaterialStateProperty.all(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 构建每个商品信息的widget
  Widget _buildCartItem(CartItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/${item.id}');
      },
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                IconTheme(
                  data: IconThemeData(size: 40),
                  child: SlidableAction(
                    onPressed: (context) {},
                    icon: Icons.share,
                    backgroundColor: Colors.blue,
                  ),
                ),
                IconTheme(
                    data: IconThemeData(size: 40),
                    child: SlidableAction(
                      onPressed: (context) async {
                        showNonBlockingDialog(context, "Removed");
                        Provider.of<CartProvider>(context, listen: false).removeItem(item.id);
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                    )),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(126, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(146, 212, 210, 210),
                      offset: Offset(-5, 1),
                      blurRadius: 5,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  children: [
                    // 商品选择按钮
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: item.isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            item.isSelected = value ?? false;
                            Provider.of<CartProvider>(context, listen: false)
                                .updateItemSelection(item.id, value ?? false);
                          });
                        },
                        shape: CircleBorder(),
                        activeColor: Color.fromARGB(255, 255, 175, 3),
                      ),
                    ),

                    // 商品图片
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          image: DecorationImage(
                            image: AssetImage(item.productImage),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(105, 0, 0, 0),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            )
                          ]),
                    ),
                    SizedBox(width: 20),
                    // 商品名称和数量
                    Container(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                            maxLines: 2, // Allow unlimited lines
                            overflow: TextOverflow.ellipsis, // Ensure it wraps to the next line
                          ),
                          //加减数量框
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 208, 98),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(108, 0, 0, 0),
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<CartProvider>(context, listen: false)
                                              .decreaseItemQuantity(item.id);
                                        },
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: item.quantity == 1
                                                ? Color.fromARGB(255, 240, 167, 167)
                                                : Color.fromARGB(255, 235, 112, 112),
                                            shape: BoxShape.circle, // 圆形按钮
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${item.quantity}',
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<CartProvider>(context, listen: false)
                                              .addItemQuantity(item.id);
                                        },
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 127, 167, 84),
                                            shape: BoxShape.circle, // 圆形按钮
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //价格
                          Text(
                            '\$ ' + item.productPrice.toString(),
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w700, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromARGB(62, 151, 149, 146),
          )
        ],
      ),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      // 设定自动关闭时间
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop(false);
      });

      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove,
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'remove',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    },
  ).then((value) => value ?? false); // 防止返回null
}
