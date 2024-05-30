import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/ProductModel.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/widget/showNonBlockingDialog.dart';

class itemCard extends StatefulWidget {
  final Product product;

  const itemCard({Key? key, required this.product}) : super(key: key);

  @override
  State<itemCard> createState() => _itemCardState();
}

class _itemCardState extends State<itemCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
        Navigator.pushNamed(context, '/${widget.product.id}');
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(1.0, _pressed ? 0.98 : 1.0, 1.0), // 只在 Z 轴上缩放
        child: Container(
          height: 295,
          width: 180,
          decoration: BoxDecoration(
            color: Color.fromARGB(175, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(60, 0, 0, 0),
                offset: Offset(0, 1),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    widget.product.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 0.95,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.green[600],
                          ),
                        ),

                        //添加到购物车按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartProvider.addItem(widget.product);
                                showNonBlockingDialog(context, "Added");
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 127, 167, 84),
                                  shape: BoxShape.circle,
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
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
