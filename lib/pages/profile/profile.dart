import 'package:agora_flutter_webrtc_quickstart/pages/login.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/signup.dart';
import 'package:agora_flutter_webrtc_quickstart/services/firebase_auth.dart';
import 'package:agora_flutter_webrtc_quickstart/util/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences sharedPreferences;
  FirebaseUser user;
  String history = "";
  double visible = 0.0;
  String username = "...";
  String email = "..";
  String photoUrl = "";
  String number = "";
  String type = ".";
  bool isVerified = true;
  String verificationText =
      "Email not verified. \nClick here to resend verification";

  @override
  void initState() {
    getHistory();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                //  Icon(Icons.settings)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                            fontSize: 23, fontWeight: FontWeight.bold),
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
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext c) => Signup()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.5)),
                    child: Text("Edit Profile"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              user.sendEmailVerification();
              verificationText = "Check your email to verify";
              setState(() {});
            },
            child: Visibility(
              visible: isVerified,
              //  visible: true,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        verificationText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Account Settings",
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Notifications",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Account Security",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Schedule Settings",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Support",
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "About Educate",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Frequently asked questions",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "More by Educate",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Share the Educate App",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Auth auth = new Auth();
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => Login()));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Version 1.0"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Future<void> getUserInfo() async {
    user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
        Firestore.instance.collection('users').document(user.uid);

    if (user.isEmailVerified) {
      print(true);
      setState(() {
        isVerified = false;
      });
    } else {
      print(false);
      setState(() {
        isVerified = true;
      });
    }

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

  getHistory() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      if (sharedPreferences.getBool("started") != null) {}
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
}
