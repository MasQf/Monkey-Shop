import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterSecond extends StatefulWidget {
  final String username;
  const RegisterSecond({Key? key, required this.username}) : super(key: key);

  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  bool _isEmail = false;
  final _emailController = TextEditingController();

  onEmailChanged(String email) {
    setState(() {
      _isEmail = false;
      if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) _isEmail = true;
    });
  }

  nextToThird() {
    if (_isEmail)
      Navigator.pushNamed(context, '/registerthird',
          arguments: [widget.username, _emailController.text]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 禁用物理返回键和滑动返回手势
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 237, 195, 189),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 237, 195, 189), Color.fromARGB(255, 235, 91, 91)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What's Your Email?",
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
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "Don't let your wallet bleed.",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          BoxShadow(color: Color.fromARGB(134, 255, 255, 255), offset: Offset(0, 2))
                        ],
                        height: 1.5,
                        color: Color.fromARGB(255, 234, 113, 113)),
                  ),
                  SizedBox(height: 50),
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
                      controller: _emailController,
                      onChanged: (email) => onEmailChanged(email),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_circle_sharp),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 62),
                  Stack(
                    children: [
                      Transform.scale(
                        scale: 1.68,
                        child: Image.asset('assets/images/wallet.png'),
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
                                      color: _isEmail ? Colors.green : Colors.transparent,
                                      border: _isEmail
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
                                  Text("Email",
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
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
                      Text(
                        '2/3',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      MaterialButton(
                        height: 130,
                        minWidth: 80,
                        elevation: 8,
                        onPressed: () {
                          nextToThird();
                        },
                        color: _isEmail ? Colors.grey[200] : Color.fromARGB(131, 150, 24, 24),
                        child: Icon(
                          Icons.navigate_next_rounded,
                          size: 50,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
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
