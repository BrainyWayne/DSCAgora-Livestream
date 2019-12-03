import 'package:agora_flutter_webrtc_quickstart/routes.dart';
import './theme.dart';
import 'package:flutter/material.dart';
import 'pages/entry.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'DSC',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      onGenerateRoute: Router.generateRoutes,
    );
  }
}
