import 'package:agora_flutter_webrtc_quickstart/pages/videobroadcasting/index.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/whiteboard/whiteboard.dart';
import 'package:agora_flutter_webrtc_quickstart/util/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../VideoCalling/entry.dart';
import '../getstarted/getstartedpageview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String history = "";
double visible = 0.0;
String username = "";
String email = "";
String photoUrl = "";
String number = "";
String type = "";
bool alreadyStarted = true;
FirebaseUser publicuser;

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  bool darkMode = true;

  @override
  void initState() {
    history = "nada";
    getHistory();
    getUserInfo();
    checkDarkMode();
    cacheUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/radio.png",
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Exemplar",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    //  Icon(Icons.settings)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.5)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/play.png",
                          height: 50,
                          width: 50,
                          color: darkMode ? Colors.green : Colors.green,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/speaker.png",
                          height: 50,
                          width: 50,
                          color: darkMode ? Colors.red : Colors.red,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/exam.png",
                          height: 50,
                          width: 50,
                          color: darkMode ? Colors.yellowAccent : Colors.yellowAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Get face-to-face with a colleague, teacher, or friend "
                          "from the comfort of your home or anywhere "
                          "around the world", style: TextStyle(fontSize: 19),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "SEE ALL",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.computer),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Development",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.attach_money),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Business",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.work),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Office Productivity",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.grain),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Marketing",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.local_florist),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Science",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.swap_vertical_circle),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Economics",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.view_carousel),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Arts",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.wb_iridescent),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Design",
                                        style: TextStyle(letterSpacing: 1),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: visible,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Previous Channel",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Spacer(),
                              Icon(Icons.more_vert)
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Automatically saved channel",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(left: 0, top: 10),
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    history,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "Connect",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
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
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                            Column(
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
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
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
        visible = 160;
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

  Future<void> cacheUserInformation() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(ConstantString.USERNAME, username);
    sharedPreferences.setString(ConstantString.EMAIL, email);
    sharedPreferences.setString(ConstantString.PHOTOURL, photoUrl);
    sharedPreferences.setString(ConstantString.TYPE, type);
  }

  void checkDarkMode() {
    print(WidgetsBinding.instance.window.platformBrightness);

    if (WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      darkMode = true;
    } else if (WidgetsBinding.instance.window.platformBrightness ==
        Brightness.light) {
      darkMode = false;
    }
  }
}
