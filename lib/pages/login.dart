import 'dart:async';

import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/homescreen.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/signup.dart';
import 'package:agora_flutter_webrtc_quickstart/services/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

double bottomLoaderHeight = 0;
bool topSnackVisible = false;
String topBannerText = "";
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 120),
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/radio.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(120),
                      child: Image.asset("assets/images/radio.png",
                          fit: BoxFit.cover)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                          ),
                          child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none)),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.keyboard),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            color: Colors.green,
                            onPressed: () {
                              if (emailController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              }
                              if (!emailController.text.contains("@")) {
                                setState(() {
                                  topBannerText = "Enter a valid email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else if (passwordController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your password";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else {
                                setState(() {
                                  bottomLoaderHeight = 70;
                                });
                                Auth _auth = Auth();

                                _auth
                                    .signIn(emailController.text,
                                        passwordController.text)
                                    .then((onValue) {
                                  if (onValue != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomeScreen()));
                                  }
                                });
                              }
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Don't have an account?",
                            ),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Signup()));
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Forgot Password?",
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: topSnackVisible,
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  topBannerText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: bottomLoaderHeight,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Signing in...",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _hideTopBanner() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        topSnackVisible = false;
      });
    });
  }
}
