import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/router/routes.dart';
import 'package:shop/widget/itemCard.dart';
import 'package:swipe_deck/swipe_deck.dart';

const IMAGES = ['painting', 'jacket', 'wink', 'toy'];

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 226, 124),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity, //最大宽度
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 185, 206, 45),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi ,',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 1,
                        ),
                        Text('Products',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 243, 243, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          //输入框
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black87,
                                ),
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*
                      ============内容===========
                  */
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Popular ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                            Icon(
                              Icons.emoji_emotions,
                              size: 30,
                              color: Color.fromARGB(255, 233, 117, 117),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        /*
                              ========Popular商品滑动栏=========
                           */
                        Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutePath.HatDetail);
                                },
                                child: promoCard('assets/images/hat03.jpg'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutePath.AngelDetail);
                                },
                                child: promoCard('assets/images/Angel02.jpg'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutePath.ToyDetail);
                                },
                                child: promoCard('assets/images/toy.jpg'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutePath.ToolDetail);
                                },
                                child: promoCard('assets/images/tool.jpg'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /*
                          ============特惠商品===========
                         */
                        SizedBox(
                          height: 20,
                        ),
                        /*
                              ========Discount商品=========
                           */

                        Row(
                          children: [
                            Text('Discount  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                            Icon(
                              Icons.discount_rounded,
                              size: 30,
                              color: Color.fromARGB(255, 195, 104, 240),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        /*
                          =========翻卡片========
                         */
                        Container(
                          child: SwipeDeck(
                            emptyIndicator: Container(
                              child: Center(
                                child: Text(
                                  "Nothing Here...",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            widgets: IMAGES
                                .map(
                                  (e) => ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assets/images/$e.jpg",
                                        fit: BoxFit.cover,
                                      )),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text('Rec  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          Icons.local_activity_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 214, 130, 13),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(11, 20, 11, 20),
                    child: Wrap(
                      direction: Axis.horizontal, // 设置水平方向排列
                      alignment: WrapAlignment.start, // 从左开始排列
                      spacing: 10.0, // 设置子组件之间的水平间距
                      runSpacing: 10.0, // 设置行之间的垂直间距
                      children: [
                        itemCard(product: ProductsProvider.tree),
                        itemCard(product: ProductsProvider.dumbbell),
                        itemCard(product: ProductsProvider.basket),
                        itemCard(product: ProductsProvider.planter),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget promoCard(String image) {
    return AspectRatio(
      aspectRatio: 2.5 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(21, 0, 0, 0),
                offset: Offset(15, 20),
                blurRadius: 3,
              )
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            )),
      ),
    );
  }
}
