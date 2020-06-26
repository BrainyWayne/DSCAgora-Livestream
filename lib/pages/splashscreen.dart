import 'dart:async';

import 'package:agora_flutter_webrtc_quickstart/pages/homescreen.dart';
import 'package:agora_flutter_webrtc_quickstart/services/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState

    Timer(
        Duration(seconds: 3),
            () =>  checkUser());



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
              image: AssetImage('assets/images/technology1.png'),
            ),
          ),
      ),
    );
  }


  void checkUser() {
    Auth _auth = new Auth();
    _auth.getCurrentUser().then((onValue) {
      if (onValue != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
        );
      }
    });
  }

}
