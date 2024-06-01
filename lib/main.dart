import 'package:flutter/material.dart';
import 'package:shop/pages/LoginPage/Login.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:shop/widget/Layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserProvider? userProvider;
  @override
  void initState() {
    super.initState();
  }

  load() {
    return userProvider?.loadUserFromPreferences();
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
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            // Only load user from preferences if it hasn't been loaded yet
            if (!userProvider.hasLoadedUser) {
              userProvider.loadUserFromPreferences();
            }
            return FutureBuilder(
              future: load(),
              builder: (context, snapshot) {
                return userProvider.isLoggedIn ? Layout() : Login();
              },
            );
          },
        ),
      ),
    );
  }
}
