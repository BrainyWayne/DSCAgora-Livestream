import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/getstartedpageview.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/profile.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/videobroadcasting/index.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/whiteboard/whiteboard.dart';
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
  String history = "";
  double visible = 0.0;
  String username = "";
  String email = "";
  String photoUrl = "";
  String number = "";
  String type = "";
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Stream",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          leading: Container(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              //Top white part
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Profile()));
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  username,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(email),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  type,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        IndexPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      child: Hero(
                                        tag: "image0",
                                        child: Image.asset(
                                            "assets/images/meeting.png"),
                                      )),
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Start or join a",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Flexible(
                                    child: Text(
                                  "Video Meeting",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VideoBroadcastingIndexPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      child: Hero(
                                          tag: "image",
                                          child: Image.asset(
                                            "assets/images/radio.png",
                                          ))),
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Start or join a",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Flexible(
                                    child: Text(
                                  "Video Broadcast",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WhiteBoard()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.green],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              child: Container(
                                  padding: EdgeInsets.all(3),
                                  child: Hero(
                                    tag: "image2",
                                    child:
                                        Image.asset("assets/images/board.png"),
                                  )),
                              backgroundColor: Colors.white,
                              radius: 25,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Sketch with the offline",
                              style: TextStyle(color: Colors.white),
                            ),
                            Flexible(
                                child: Text(
                              "Whiteboard",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Bottom grey part
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                color: Colors.grey.withOpacity(0.15),
                child: Column(
                  children: <Widget>[
                    Visibility(
//                visible: alreadyStarted,
                      visible: false,
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
                                        color:
                                            Colors.redAccent.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 30,
                                        left: 25,
                                        right: 15,
                                        bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "Start",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
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
                            child: ClayContainer(
                              spread: 0,
                              customBorderRadius: BorderRadius.circular(10),
                              curveType: CurveType.convex,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                margin: EdgeInsets.only(left: 0, top: 10),
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      history,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Connect",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
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
                                        color: Colors.yellowAccent
                                            .withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
}
