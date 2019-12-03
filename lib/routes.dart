import 'package:agora_flutter_webrtc_quickstart/pages/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'pages/home.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    var name = settings.name;
    var args = settings.arguments;

    switch (name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/index':
        return MaterialPageRoute(builder: (_) => IndexPage());
        break;
      default:
    }
  }
}
