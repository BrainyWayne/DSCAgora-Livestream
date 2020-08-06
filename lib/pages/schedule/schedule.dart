import 'package:agora_flutter_webrtc_quickstart/pages/calldetails.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/home/home.dart';
import 'package:agora_flutter_webrtc_quickstart/util/crudobj.dart';
import 'package:agora_flutter_webrtc_quickstart/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:share/share.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  FirebaseUser user;
  String _username = "";
  String _email = "";
  QuerySnapshot postmethods;
  double schedularHeight = 0;
  bool darkMode = false;
  Color schedularColor = Colors.white;
  CRUDMethods crudObj = new CRUDMethods();
  Color borderColor = Colors.black;
  String dateAndTime = "Show date and time picker";
  String scheduledChannelName = "";
  String scheduleButtonText = 'Schedule';

  @override
  void initState() {
    checkDarkMode();
    getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
            child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/radio.png",
                            height: 30,
                            width: 30,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schedularHeight = 400;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 5),
                              child: Icon(Icons.add_circle),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Schedule",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),

                      //  Icon(Icons.settings)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: postmethods.documents.length,
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CallDetails(
                              name: postmethods.documents[i].data['name'],
                              channelName: postmethods.documents[i].data['channelname'],
                              date: postmethods.documents[i].data['dateandtime'],

                            )));
                        },
                        child: new Container(
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  postmethods.documents[i].data['channelname'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  postmethods.documents[i].data['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  postmethods.documents[i].data['dateandtime'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                            postmethods
                                                    .documents[i].data['name'] +
                                                " has invited you to join his scheduled call " + postmethods.documents[i].data['channelname'] + " on " +
                                                postmethods.documents[i]
                                                    .data['dateandtime'],
                                            subject:
                                                'Scheduled call invitation');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.share),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
//
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: schedularHeight,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: schedularColor),
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Create a new schedule",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              schedularHeight = 0;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.clear),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Scheduling as "),
                        Text(_username)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Channel name"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor)),
                      child: TextField(
                        onChanged: ((value) {
                          scheduledChannelName = value;
                          if (value == "" || value.length < 4) {
                            schedularHeight = 300;
                            setState(() {});
                          } else {
                            setState(() {
                              schedularHeight = 370;
                            });
                          }
                        }),
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: "Channel name"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Date and Time"),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
//                        onPressed: () {
//                          DatePicker.showDateTimePicker(context,
//                              showTitleActions: true, onChanged: (date) {
//                            print('change $date in time zone ' +
//                                date.timeZoneOffset.inHours.toString());
//                          }, onConfirm: (date) {
//                            print('confirm $date');
//                            setState(() {
//                              dateAndTime = date.toString();
//                            });
//                          },
//                              currentTime: DateTime.now(),
//                              locale: LocaleType.en);
//                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dateAndTime,
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            schedularHeight = 0;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Cancel"),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            addSchedule(scheduledChannelName, dateAndTime);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(scheduleButtonText),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void checkDarkMode() {
    print(WidgetsBinding.instance.window.platformBrightness);

    if (WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      darkMode = true;
      schedularColor = Colors.black;
      borderColor = Colors.grey;
    } else if (WidgetsBinding.instance.window.platformBrightness ==
        Brightness.light) {
      darkMode = false;
      schedularColor = Colors.white;
      borderColor = Colors.black;
    }
  }

  void addSchedule(String channelname, String datetime) {
    crudObj.addScheduleData({
      'channelname': channelname,
      'dateandtime': datetime,
      'name': _username,
      'email': _email,
    }).then((result) {
      setState(() {
        scheduleButtonText = "Scheduled";
        schedularHeight = 0;
        scheduledChannelName = "";
        datetime = "";
      });

      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getUserInfo() async {
    user = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection("schedules")
        .getDocuments()
        .then((results) {
      setState(() {
        postmethods = results;
      });
    });
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
          _username = datasnapshot.data['name'].toString();
          _email = datasnapshot.data['email'].toString();
          photoUrl = photolink;

          number = datasnapshot.data['phone'].toString();
          type = datasnapshot.data['type'].toString();
        });
      }
    });
  }
}
