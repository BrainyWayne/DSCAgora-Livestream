import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

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
  bool informationAvailable = true;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: !informationAvailable,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.notifications),
                    SizedBox(height: 12,),
                    Text("No Notifications", style: TextStyle(
                        fontSize: 22
                    ),),
                  ],
                ),
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
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          ],
        ),
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
        informationAvailable = false;
      });
    } else {
      print(false);
      setState(() {
        isVerified = true;
        informationAvailable = false;
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
}
