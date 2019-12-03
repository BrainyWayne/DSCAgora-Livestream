import 'package:agora_flutter_webrtc_quickstart/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    FirebaseUser _user = Provider.of<FirebaseUser>(context);
    bool _loggedIn = _user != null;

    return !_loggedIn
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 250,
                          width: double.infinity,
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/dsc.jpeg'),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: fadedBlack,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(text: 'Live'),
                              TextSpan(
                                text: 'Stream',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Powered by Agora.IO',
                          style: TextStyle(color: greyText),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (loading)
                        Container(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).accentColor,
                            strokeWidth: 30,
                          ),
                        ),
                      if (!loading)
                        Container(
                          width: 200,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'continue'.toUpperCase(),
                              style: TextStyle(
                                  color: textWhite,
                                  fontSize: 15,
                                  letterSpacing: 1),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/home');
                            },
                          ),
                        ),
                      SizedBox(height: 10),
                      if (!loading)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                'or',
                                style: TextStyle(),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey[300],
                              ),
                            )
                          ],
                        ),
                      SizedBox(height: 20),
                      if (!loading)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 60,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.all(6),
                                color: Color.fromRGBO(66, 103, 178, 1),
                                onPressed: () {},
                                child: Image(
                                  image: AssetImage('assets/images/facebook.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 30,
                              width: 60,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.all(6),
                                color: Colors.white30,
                                child: Image(
                                  image: AssetImage('assets/images/google.png'),
                                ),
                                onPressed: () => _signInWithGoogle(context),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Home();
  }

  _signInWithGoogle(BuildContext context) {}
}