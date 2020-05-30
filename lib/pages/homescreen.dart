import 'package:agora_flutter_webrtc_quickstart/pages/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/getstartedpageview.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  String history;
  double visible;
  String username;
  String email;
  String photoUrl;
  String number;
  String type;
  bool alreadyStarted = true;

  @override
  void initState() {
    history = "nada";
    getHistory();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Text(
              type.toUpperCase(),
              style: TextStyle(letterSpacing: 2),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Stream",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Profile()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                    Text(
                      username,
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(email),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: alreadyStarted,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GetStartedPageView()));
                },
                child: ClayContainer(
                  curveType: CurveType.convex,
                  customBorderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: "getstarted",
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blue]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Image.asset(
                              "assets/images/technology.png",
                              height: 200,
                              width: 200,
                            ),
                            bottom: 15,
                            right: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30, left: 25, right: 15, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Get \nStarted",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Set up your streaming experience",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "Start",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.chevron_right)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => IndexPage()));
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Create or Join a Channel",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.add_call,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: visible,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Previous Channel Joined",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      Icon(Icons.more_vert)
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.1)),
                      margin: EdgeInsets.only(left: 0, top: 10),
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Text(
                            history,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IndexPage(channelName: history),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Live now",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                Icon(Icons.more_vert)
              ],
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/live.png",
                      height: 150,
                      width: 150,
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.yellowAccent.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getHistory() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      if (sharedPreferences.getBool("started") != null) {
        alreadyStarted = sharedPreferences.getBool("started");
      }
    });

    if (sharedPreferences.getString("channel") == null) {
      setState(() {
        visible = 0;
      });
    } else {
      setState(() {
        visible = 120;
        history = sharedPreferences.getString("channel");
      });
    }
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
        Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        print(datasnapshot.data['residence'].toString());
        var photolink;
        try {
          photolink = datasnapshot.data['photo'].toString();
        } catch (e) {
          photoUrl = "N/A";
        }

        setState(() {
          username = datasnapshot.data['name'].toString();
          email = datasnapshot.data['email'].toString();
          photoUrl = photolink;

          number = datasnapshot.data['phone'].toString();
          type = datasnapshot.data['type'].toString();
        });
      }
    });
  }
}
