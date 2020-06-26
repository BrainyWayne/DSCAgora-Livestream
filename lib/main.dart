import 'package:agora_flutter_webrtc_quickstart/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './theme.dart';
import 'package:flutter/material.dart';
import 'pages/VideoCalling/entry.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
          catchError: (context, object) => null,
          initialData: null,
        )
      ],
      child: new MaterialApp(
        title: 'DSC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // additional settings go here
        ),
        onGenerateRoute: Router.generateRoutes,
        initialRoute: '/splashscreen',
      ),
    );
  }
}
