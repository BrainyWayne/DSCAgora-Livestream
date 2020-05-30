import 'dart:async';

import 'package:flutter/material.dart';

class Ads extends StatefulWidget {
  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {

  PageController _adController = new PageController();


  @override
  void initState() {
    new Timer.periodic(Duration(seconds: 3), (Timer t){
      if(_adController.page == 2){
        _adController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      } else {
        _adController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: _adController,
        children: <Widget>[
          Image.asset("assets/images/adslide.jpg", fit: BoxFit.cover,),
          Image.asset("assets/images/adslide3.jpg", fit: BoxFit.cover,),
          Image.asset("assets/images/adslide2.jpg", fit: BoxFit.cover,),
        ],

      ),
    );
  }
}
