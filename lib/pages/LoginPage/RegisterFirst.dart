import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterFirst extends StatefulWidget {
  const RegisterFirst({Key? key}) : super(key: key);

  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> with SingleTickerProviderStateMixin {
  bool _isUsernameOneCharacters = false;
  final _usernameController = TextEditingController();

  onUsernameChanged(String username) {
    setState(() {
      _isUsernameOneCharacters = username.length >= 1;
    });
  }

  nextToSecond() {
    if (_isUsernameOneCharacters) {
      Navigator.pushNamed(context, '/registersecond', arguments: _usernameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 禁用物理返回键和滑动返回手势
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 194, 212, 237),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 194, 212, 237), Color.fromARGB(255, 48, 125, 233)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        BoxShadow(
                            color: const Color.fromARGB(119, 0, 0, 0),
                            offset: Offset(1.2, 1.2),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    textAlign: TextAlign.center,
                    "You will experience the joy of global shopping!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          BoxShadow(color: Color.fromARGB(134, 255, 255, 255), offset: Offset(0, 2))
                        ],
                        height: 1.5,
                        color: Color.fromARGB(255, 18, 63, 169)),
                  ),
                  SizedBox(height: 30),
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
                      controller: _usernameController,
                      onChanged: (username) => onUsernameChanged(username),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_circle_sharp),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Username",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Stack(
                    children: [
                      Transform.scale(
                        scale: 1.68,
                        child: Image.asset('assets/images/earth.png'),
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
                                      color: _isUsernameOneCharacters
                                          ? Colors.green
                                          : Colors.transparent,
                                      border: _isUsernameOneCharacters
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
                                  Text("Contains at least 1 characters",
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
                            Icons.sign_language_outlined,
                            size: 40,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
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
                            nextToSecond();
                          },
                          color: _isUsernameOneCharacters
                              ? Colors.grey[200]
                              : Color.fromARGB(131, 150, 24, 24),
                          child: Icon(
                            Icons.navigate_next_rounded,
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
