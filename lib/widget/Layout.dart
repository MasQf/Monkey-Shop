import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/BottomTab/CartTab.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';
import 'package:shop/pages/BottomTab/HomeTab.dart';

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return DefaultTabController(
            length: 3,
            child: PopScope(
              canPop: false,
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 255, 227, 103),
                  //顶部导航栏
                  appBar: PreferredSize(
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
                        title: Image.asset(
                          'assets/images/bananaIcon.png',
                          fit: BoxFit.fill,
                          height: 50,
                          width: 70,
                        ),
                        backgroundColor: Color.fromARGB(255, 242, 194, 64),
                        centerTitle: true,
                        actions: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline))
                        ],
                      ),
                    ),
                  ),

                  //侧边导航栏
                  drawer: Drawer(
                      backgroundColor: Color.fromARGB(255, 238, 183, 34),
                      child: ListView(padding: EdgeInsets.all(0), children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, RoutePath.Login);
                          },
                          child: Container(
                            height: 250,
                            child: UserAccountsDrawerHeader(
                              //用户头像
                              currentAccountPicture: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  'assets/images/monkey.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //用户名
                              accountName: Text(
                                  Provider.of<UserProvider>(context, listen: false).username,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 44, 1),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35)),
                              //用户邮箱
                              accountEmail: Text(
                                  Provider.of<UserProvider>(context, listen: false).email,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 244, 255, 202),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 25)),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0, 5),
                                      blurRadius: 10.0,
                                    )
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/banana.jpg'),
                                      opacity: 0.7)),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Message',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black54),
                          ),
                          trailing: Icon(Icons.message),
                        ),
                        ListTile(
                          title: Text('Like',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54)),
                          trailing: Icon(Icons.favorite),
                        ),
                        ListTile(
                          title: Text('Feedback',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54)),
                          trailing: Icon(Icons.feedback),
                        ),
                        Divider(color: Colors.amber),
                        GestureDetector(
                          onTap: () async {
                            bool confirm = await showLogoutDialog(context);
                            if (confirm) {
                              await Provider.of<UserProvider>(context, listen: false).logout();
                            }
                          },
                          child: ListTile(
                            title: Text('Logout',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54)),
                            trailing: Icon(
                              Icons.login_outlined,
                              size: 26,
                            ),
                          ),
                        ),
                      ])),

                  //底部导航栏
                  bottomNavigationBar: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 242, 188, 39),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5), // 阴影的颜色
                            offset: Offset(10, 20), // 阴影与容器的距离
                            blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积
                            spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量
                          ),
                        ],
                      ),
                      child: TabBar(
                        isScrollable: false,
                        tabs: [
                          Tab(icon: Icon(Icons.home)),
                          Tab(icon: Icon(Icons.shopping_cart)),
                          Tab(icon: Icon(Icons.edit_document)),
                        ],
                      ),
                    ),
                  ),

                  //body
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HomeTab(),
                      CartTab(showBackButton: false),
                      Text('333'),
                    ],
                  )),
            ));
      },
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  // 设定自动关闭时间
  // Future.delayed(Duration(seconds: 3), () {
  //   Navigator.of(context).pop(false);
  // });

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure logout?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 112, 112),
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
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: Container(
              width: 26,
              height: 26,
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
      );
    },
  ).then((value) => value ?? false); // 防止返回null
}
