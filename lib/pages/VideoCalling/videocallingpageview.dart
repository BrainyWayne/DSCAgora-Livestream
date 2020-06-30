import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/call.dart';
import 'package:agora_flutter_webrtc_quickstart/agoraappid.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/GroupCalling/GroupCallPage.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/chat/chat_page.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/whiteboard/whiteboard.dart';
import 'package:agora_flutter_webrtc_quickstart/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoCallingPageView extends StatefulWidget {
  final String channel;
  final bool video;
  final bool audio;
  final bool screen;
  final String appId;
  final String profile;
  final String width;
  final String height;
  final String framerate;
  final String codec;
  final String mode;
  bool isChatOpened = false;

  VideoCallingPageView({
    this.appId,
    this.channel,
    this.video,
    this.audio,
    this.screen,
    this.profile,
    this.width,
    this.height,
    this.framerate,
    this.codec,
    this.mode,
  });
  @override
  _VideoCallingPageViewState createState() => _VideoCallingPageViewState();
}



class _VideoCallingPageViewState extends State<VideoCallingPageView> {

  SharedPreferences sharedPreferences;
  String username;
  String email;
  String photoUrl;
  String residence;
  String number;
  String occupation;
  String house;
  String yearGroup;
  String type;



  @override
  void initState() {
    super.initState();
    getUserInfo();
    getUserCache();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: <Widget>[
                  GroupCallPage(
                    channelName: widget.channel,
                    username: username,
                  ),


                  WhiteBoard()

                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  Future<void> getUserCache() async {
     sharedPreferences = await SharedPreferences.getInstance();
     username = sharedPreferences.getString(ConstantString.USERNAME);

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
          residence = datasnapshot.data['residence'].toString();
          occupation = datasnapshot.data['occupation'].toString();
          number = datasnapshot.data['phone'].toString();
          yearGroup = datasnapshot.data['yeargroup'].toString();
          house = datasnapshot.data['house'].toString();
          type = datasnapshot.data['type'].toString();
        });
      }
    });
  }
}
