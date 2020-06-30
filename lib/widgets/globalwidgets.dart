import 'package:flutter/material.dart';

Widget navigateTo(Widget widget, BuildContext context){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext ctx) => widget));
}

Widget navigateReplace(Widget widget, BuildContext context){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext ctx) => widget));
}

