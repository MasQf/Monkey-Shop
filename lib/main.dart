import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/pages/LoginPage/Login.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';
import "package:provider/provider.dart";
import 'package:shop/widget/Layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUser();
  }

  Future<void> _loadUser() async {
    await Provider.of<UserProvider>(context, listen: false).loadUserFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Monkey',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 242, 194, 64)),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: RoutePath.Layout,
        // 使用 FutureBuilder 加载用户信息
        home: FutureBuilder(
          future: _loadUserFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Login();
            } else {
              // 加载完成后，导航到 Layout 页面
              return Layout();
            }
          },
        ),
      ),
    );
  }
}
