import 'package:agora_flutter_webrtc_quickstart/pages/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/login.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'pages/home.dart';
import 'pages/settings.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    var name = settings.name;
    var args = settings.arguments;

    switch (name) {
      case '/splashscreen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/index':
        return MaterialPageRoute(
          builder: (_) => IndexPage(
            channelName: args,
          ),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
        break;
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
