import 'dart:async';

import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState

    loadTimer();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Container(
        color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/dsc.jpeg'),
            ),
          ),
      ),
    );
  }

  void loadTimer() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Login())));
  }

}
