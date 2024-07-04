import 'package:flutter/material.dart';
import 'package:shop/pages/LoginPage/Login.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:shop/widget/Layout.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadInitialData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveCartData();
    }
  }

  Future<void> _loadInitialData() async {
    try {
      await context.read<UserProvider>().loadUserFromPreferences();
      await context.read<CartProvider>().loadCartFromPreferences();
    } catch (e) {
      print("Error loading initial data: $e");
    }
  }

  Future<void> _saveCartData() async {
    try {
      await context.read<CartProvider>().saveCartToPreferences();
    } catch (e) {
      print("Error saving cart data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monkey Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 242, 194, 64)),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (!userProvider.hasLoadedUser) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return userProvider.isLoggedIn ? Layout() : Login();
        },
      ),
    );
  }
}
