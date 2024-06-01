import 'dart:ui';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/UserModel.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      bool isValid =
          await Provider.of<UserProvider>(context, listen: false).loginUser(username, password);

      if (isValid) {
        DelightToastBar(
          builder: (BuildContext context) {
            return ToastCard(
                leading: Icon(
                  Icons.gite_rounded,
                  size: 32,
                ),
                title: Text(
                  'Successfully login!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ));
          },
          position: DelightSnackbarPosition.top,
          autoDismiss: true,
          snackbarDuration: Duration(seconds: 2),
        ).show(context);
        User? userData = await Provider.of<UserProvider>(context, listen: false).getUser(username);
        if (userData != null) {
          String email = userData.email;
          await Provider.of<UserProvider>(context, listen: false)
              .saveUserToPreferences(username, email, true);
        }
        Navigator.pushReplacementNamed(context, RoutePath.Layout); //登录成功去首页
      } else {
        DelightToastBar(
                builder: (BuildContext context) {
                  return ToastCard(
                      leading: Icon(
                        Icons.notifications,
                        size: 32,
                      ),
                      title: Text(
                        'Please enter the correct username or password.',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ));
                },
                position: DelightSnackbarPosition.top,
                autoDismiss: true,
                snackbarDuration: Duration(seconds: 1))
            .show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(222, 206, 194, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginMonkey.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w900, letterSpacing: 1.8),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(87, 0, 0, 0),
                                          blurRadius: 6.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    prefixIcon: Icon(Icons.person_pin_circle_sharp),
                                    border: InputBorder.none,
                                    hintText: 'Username',
                                    hintStyle:
                                        TextStyle(color: const Color.fromARGB(255, 98, 98, 98)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 33),
                              Container(
                                width: 300,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(87, 0, 0, 0),
                                          blurRadius: 6.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isVisible,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    prefixIcon: Icon(Icons.key_rounded),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                      icon: _isVisible
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.black,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 160),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginBanana.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Login button
            Positioned(
              bottom: 230,
              left: 100,
              right: 100,
              child: ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 236, 218, 23),
                  shadowColor: Color.fromARGB(255, 252, 194, 49),
                  elevation: 10,
                  minimumSize: Size(180, 80),
                ),
              ),
            ),
            Positioned(
              bottom: 140,
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(color: Color.fromARGB(82, 0, 0, 0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('  No account? Click ',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(231, 225, 199, 1))),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePath.RegisterFirst);
                      },
                      child: Text(
                        'here',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(236, 218, 23, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(' to register',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(231, 225, 199, 1))),
                  ],
                ),
              ),
            ),
            Positioned.fill(
                top: 640,
                left: 130,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset('assets/images/finger.png'),
                ))
          ],
        ),
      ),
    );
  }
}
