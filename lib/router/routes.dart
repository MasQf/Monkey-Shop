import 'package:flutter/material.dart';
import 'package:shop/models/OrderModel.dart';
import 'package:shop/pages/BottomTab/DeclarationForm.dart';
import 'package:shop/pages/DetailPage/DumbbellDetail.dart';
import 'package:shop/pages/DetailPage/TreeDetail.dart';
import 'package:shop/widget/Layout.dart';
import 'package:shop/pages/DetailPage/ToyDetail.dart';
import 'package:shop/pages/LoginPage/Login.dart';
import 'package:shop/pages/LoginPage/RegisterFirst.dart';
import '../pages/LoginPage/RegisterSecond.dart';
import '../pages/LoginPage/RegisterThird.dart';
import '../pages/BottomTab/CartTab.dart';
import '../pages/DetailPage/HatDetail.dart';
import '../pages/DetailPage/AngelDetail.dart';
import '../pages/DetailPage/ToolDetail.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.Layout:
        return pageRoute(Layout());
      case RoutePath.CartTab:
        return pageRoute(CartTab(showBackButton: true)); //显示返回按钮
      case RoutePath.CartTabFromBottomNav:
        return pageRoute(CartTab(showBackButton: false)); // 不显示返回按钮
      case RoutePath.Login:
        return pageRoute(Login());

      case RoutePath.RegisterFirst:
        return pageRoute(RegisterFirst());
      case RoutePath.RegisterSecond:
        // 在导航到 RegisterSecond 页面时传递参数
        final arguments = settings.arguments as String; // 获取传入的参数
        return pageRoute(RegisterSecond(username: arguments)); // 将参数传递给 RegisterSecond 页面
      case RoutePath.RegisterThird:
        // 在导航到 RegisterThird 页面时传递参数
        final arguments = settings.arguments as List<String>; // 获取传入的参数
        return pageRoute(
            RegisterThird(username: arguments[0], email: arguments[1])); // 将参数传递给 RegisterThird 页面
      case RoutePath.HatDetail:
        return pageRoute(HatDetail());
      case RoutePath.AngelDetail:
        return pageRoute(AngelDetail());
      case RoutePath.ToyDetail:
        return pageRoute(ToyDetail());
      case RoutePath.ToolDetail:
        return pageRoute(ToolDetail());
      case RoutePath.TreeDetail:
        return pageRoute(TreeDetail());
      case RoutePath.DumbbellDetail:
        return pageRoute(DumbbellDetail());
      case RoutePath.DeclarationForm:
        final Order order = settings.arguments as Order;
        return MaterialPageRoute(
          builder: (context) => DeclarationForm(order: order),
        );
    }
    // 错误情况，跳到 Error 页
    return pageRoute(SafeArea(
      child: Center(
        child: Text('route path ${settings.name} not found !'),
      ),
    ));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? maintainState,
    bool? fullscreenDialog,
    bool? allowSnapshotting = true,
    bool? barrierDismissible = false,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? true,
      allowSnapshotting: allowSnapshotting ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );
  }
}

//路由地址
class RoutePath {
  //首页
  static const String Layout = '/';
  //登录页
  static const String Login = '/login';
  //注册页一
  static const String RegisterFirst = '/registerfirst';
  //注册页二
  static const String RegisterSecond = '/registersecond';
  //注册页三
  static const String RegisterThird = '/registerthird';
  //购物车页
  static const String CartTab = '/carttab';
  // 从底部导航栏进入购物车页
  static const String CartTabFromBottomNav = '/carttabfrombottomnav';
  //hat详情页
  static const String HatDetail = '/hat';
  //angel详情页
  static const String AngelDetail = '/angel';
  //toy详情页
  static const String ToyDetail = '/toy';
  //tool详情页
  static const String ToolDetail = '/tool';
  //tree详情页
  static const String TreeDetail = '/tree';
  //tree详情页
  static const String DumbbellDetail = '/dumbbell';
  //海关申报页面
  static const String DeclarationForm = '/declarationform';
}
