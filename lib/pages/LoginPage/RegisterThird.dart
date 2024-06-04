import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/UserProvider.dart';
import 'package:shop/router/routes.dart';

class RegisterThird extends StatefulWidget {
  final String username;
  final String email;
  const RegisterThird({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
  bool _isVisible = false;
  bool _isPasswordSixCharacters = false;
  bool _hasPasswordOneNumber = false;
  final _passwordController = TextEditingController();

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordSixCharacters = password.length >= 6;
      _hasPasswordOneNumber = numericRegex.hasMatch(password);
    });
  }

  onRegister() async {
    if (_isPasswordSixCharacters && _hasPasswordOneNumber) {
      bool success = await Provider.of<UserProvider>(context, listen: false)
          .registerUser(widget.username, widget.email, _passwordController.text);
      if (success) {
        Navigator.pushNamed(context, RoutePath.Login);
        DelightToastBar(
          builder: (BuildContext context) {
            return ToastCard(
                leading: Icon(
                  Icons.sentiment_satisfied_alt,
                  size: 32,
                ),
                title: Text(
                  'Successfully register!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ));
          },
          position: DelightSnackbarPosition.top,
          autoDismiss: true,
          snackbarDuration: Duration(seconds: 2),
        ).show(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Please try again.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      DelightToastBar(
              builder: (BuildContext context) {
                return ToastCard(
                    leading: Icon(
                      Icons.notifications,
                      size: 32,
                    ),
                    title: Text(
                      'Password does not meet requirements.',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ));
              },
              position: DelightSnackbarPosition.top,
              autoDismiss: true,
              snackbarDuration: Duration(seconds: 1))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 禁用物理返回键和滑动返回手势
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 243, 210, 174),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 243, 210, 174), Color.fromARGB(255, 229, 114, 6)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What's Your Password?",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        BoxShadow(
                            color: const Color.fromARGB(119, 0, 0, 0),
                            offset: Offset(1.2, 1.2),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    textAlign: TextAlign.center,
                    "Enjoy the journey!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          BoxShadow(color: Color.fromARGB(134, 255, 255, 255), offset: Offset(0, 2))
                        ],
                        height: 1.5,
                        color: Color.fromARGB(255, 244, 101, 19)),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(87, 0, 0, 0),
                              blurRadius: 6.0,
                              offset: Offset(0, 3))
                        ]),
                    child: TextField(
                      controller: _passwordController,
                      onChanged: (password) => onPasswordChanged(password),
                      obscureText: !_isVisible,
                      decoration: InputDecoration(
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
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Password",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 55),
                  Stack(
                    children: [
                      Transform.scale(
                        scale: 1.38,
                        child: Image.asset('assets/images/food.png'),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              color: const Color.fromARGB(139, 255, 255, 255),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _isPasswordSixCharacters
                                          ? Colors.green
                                          : Colors.transparent,
                                      border: _isPasswordSixCharacters
                                          ? Border.all(color: Colors.green)
                                          : Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
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
                                  SizedBox(width: 20),
                                  Text("Contains at least 6 characters",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          shadows: [
                                            BoxShadow(
                                                color: Color.fromARGB(132, 255, 255, 255),
                                                offset: Offset(0, 2))
                                          ],
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 50,
                              color: const Color.fromARGB(139, 255, 255, 255),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color:
                                          _hasPasswordOneNumber ? Colors.green : Colors.transparent,
                                      border: _hasPasswordOneNumber
                                          ? Border.all(color: Colors.green)
                                          : Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
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
                                  SizedBox(width: 20),
                                  Text("Contain at least 1 number",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          shadows: [
                                            BoxShadow(
                                                color: Color.fromARGB(132, 255, 255, 255),
                                                offset: Offset(0, 2))
                                          ],
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 250,
                        child: MaterialButton(
                          height: 130,
                          minWidth: 80,
                          elevation: 8,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.navigate_before_rounded,
                            size: 50,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height - 730,
                        left: MediaQuery.of(context).size.width * 0.43,
                        child: Text(
                          '3/3',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        right: 0,
                        child: MaterialButton(
                          height: 130,
                          minWidth: 80,
                          elevation: 8,
                          onPressed: () {
                            onRegister();
                          },
                          color: _isPasswordSixCharacters && _hasPasswordOneNumber
                              ? Colors.grey[200]
                              : Color.fromARGB(131, 150, 24, 24),
                          child: Icon(
                            Icons.handshake_rounded,
                            size: 50,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
