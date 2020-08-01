import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/chat/home_page.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/chat/profile_page.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/connect/connect.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/getstartedpageview.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/home/home.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/profile/profile.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/schedule/schedule.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/videobroadcasting/index.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/whiteboard/whiteboard.dart';
import 'package:agora_flutter_webrtc_quickstart/util/strings.dart';
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

int currentindex = 0;

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          currentIndex: currentindex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          onTap: (int i) {
            setState(() {
              currentindex = i;
              _controller.animateToPage(currentindex,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.personal_video),
              title: Text("Connect"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              title: Text("Schedule"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
            ),
          ],
        ),
        body: Container(
            child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[Home(), Connect(), Schedule(), Profile()],
        )),
      ),
    );
  }
}
