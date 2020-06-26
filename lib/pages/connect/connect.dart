import 'package:agora_flutter_webrtc_quickstart/pages/VideoCalling/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/videobroadcasting/index.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/whiteboard/whiteboard.dart';
import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset("assets/images/radio.png", height: 30, width: 30,),
                      SizedBox(height: 20,),
                      Text("Connect", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),

                      //  Icon(Icons.settings)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20,),
                  child: Row(
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20,),
                  child: GestureDetector(
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
                ),
              ],
            ),
        ),
      ),
    );
  }
}
