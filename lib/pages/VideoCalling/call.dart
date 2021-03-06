import 'dart:async';

import 'package:agora_flutter_webrtc/agora_client.dart';
import 'package:agora_flutter_webrtc/agora_stream.dart';
import 'package:agora_flutter_webrtc/agora_view.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/chat/chat_page.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
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
  final String username;

  CallPage({
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
    this.username
  });

  @override
  CallPageState createState() {
    return new CallPageState(
      appId: appId,
      channel: channel,
      video: video,
      audio: audio,
      screen: screen,
      profile: profile,
      width: width,
      height: height,
      framerate: framerate,
      codec: codec,
      mode: mode,
    );
  }
}

class CallPageState extends State<CallPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String appId;
  String channel;
  bool video;
  bool audio;
  bool screen;
  String profile;
  String width;
  String height;
  String framerate;
  String codec;
  String mode;

  double chatHeight = 0;
  double leaveOpacity = 0;

  AgoraClient agoraClient;
  AgoraClient shareScreenClient;

  AgoraStream mainStream;
  AgoraStream shareScreenStream;

  List<AgoraStream> remoteStreams;
  List<AgoraStream> localStreams;
  List<AgoraStream> allStreams;
  List<Timer> timers = new List<Timer>();

  Map<String, String> mediaStats;

  CallPageState({
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

  void startShareScreen(String cname) async {
    shareScreenClient = AgoraClient(appId: appId, mode: mode, codec: codec);

    await shareScreenClient.join(null, cname, 1);
    shareScreenStream = AgoraStream.createStream(
        {'audio': false, 'video': false, 'screen': true});

    try {
      await shareScreenStream.init();
    } catch (e) {}

    await shareScreenClient.publish(shareScreenStream);
    localStreams.add(shareScreenStream);
  }

  void stopShareScreen() async {
    await shareScreenClient?.leave();
    shareScreenClient = null;
    shareScreenStream?.close();
  }

  void initState() {
    super.initState();

    print(
        "$channel,$video,$audio,$screen,$profile,$width,$height,$framerate,$codec,$mode");

    localStreams = new List<AgoraStream>();
    remoteStreams = new List<AgoraStream>();
    allStreams = new List<AgoraStream>();

    agoraClient = AgoraClient(appId: appId, mode: mode, codec: codec);

    agoraClient.on("peer-leave", (evt) async {
      var uid = evt["uid"];
      var stream = remoteStreams.firstWhere((AgoraStream stream) {
        return stream.getId() == uid;
      }, orElse: () {});

      if (stream == null) {
        return;
      }
      setState(() {
        remoteStreams.remove(stream);
        allStreams.remove(stream);
      });
    });

    agoraClient.on("connection-state-change", (evt) async {
      print("state change from ${evt['prvState']} to ${evt['curState']}");
      _globalKey.currentState.showSnackBar(SnackBar(
        content: Text(evt['prvState'] ?? evt['curState']),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ));
    });

    agoraClient.on("stream-removed", (evt) async {
      var stream = evt["stream"];
      setState(() {
        remoteStreams.remove(stream);
        allStreams.remove(stream);
      });
    });

    agoraClient.on("stream-added", (evt) async {
      var stream = evt["stream"];
      await agoraClient.subscribe(stream);
      remoteStreams.add(stream);
      // id=1 means this stream is sharing screen stream
      if (stream.getId() == 1) {
        await stream.play(mode: "contain");
      } else {
        await stream.play();
      }
      setState(() {
        allStreams.add(stream);
      });
    });

    agoraClient.join(null, channel, 0).then((uid) async {
      AgoraStream stream = AgoraStream.createStream(
          {'audio': audio, 'video': video, 'screen': screen});

      if (width != "" && height != "" && framerate != "") {
        stream.setVideoResolution(int.parse(width), int.parse(height));
        stream.setVideoFrameRate(int.parse(framerate));
      } else {
        stream.setVideoProfile(profile);
      }

      await stream.init();
      localStreams.add(stream);
      await stream.play();
      setState(() {
        mainStream = stream;
        allStreams.add(stream);
      });
      return stream;
    }).then((stream) async {
      await agoraClient.publish(stream);
    });
    var timer = Timer.periodic(new Duration(seconds: 1), (_) {
      setState(() {
        mediaStats = mainStream?.getStats();
      });
    });
    timers.add(timer);
  }

  void dispose() {
    super.dispose();
    localStreams?.forEach((AgoraStream stream) {
      stream?.close();
    });
    remoteStreams?.forEach((AgoraStream stream) {
      stream?.close();
    });
    allStreams?.forEach((AgoraStream stream) {
      stream?.close();
    });
    timers?.forEach((Timer timer) {
      timer.cancel();
    });

    localStreams = [];
    remoteStreams = [];
    allStreams = [];
    timers = [];

    stopShareScreen();
    agoraClient.leave();
    agoraClient = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        // appBar: AppBar(
        //   title: Text('In Call'),
        // ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: (mainStream != null && mainStream.isPlaying())
                        ? AgoraVideoView(mainStream)
                        : Center(
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 50,
                                maxWidth: 50,
                                minWidth: 50,
                                maxHeight: 50,
                              ),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    decoration: BoxDecoration(color: Colors.black54),
                  );
                }),
                left: 0,
                top: 0,
              ),
              Positioned(
                child: ListView.builder(
                    itemCount: allStreams.length,
                    itemBuilder: (BuildContext context, int index) {
                      return (mainStream != null &&
                              allStreams[index].getId() != mainStream.getId())
                          ? Container(
                              padding: EdgeInsets.only(bottom: 12.0),
                              height:
                                  MediaQuery.of(context).size.width * 0.3 * 1.3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mainStream = allStreams[index];
                                  });
                                },
                                child: Container(
                                    // child: (allStreams[index] != null && allStreams[index].isPlaying()) ? RTCVideoView(allStreams[index].render) : null,
                                    child: Stack(children: <Widget>[
                                      Container(
                                          child: (allStreams[index] != null &&
                                                  allStreams[index].isPlaying())
                                              ? AgoraVideoView(
                                                  allStreams[index])
                                              : null),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          allStreams[index].getId().toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ]),
                                    decoration:
                                        BoxDecoration(color: Colors.black12)),
                              ))
                          : Container();
                    }),
                right: 16.0,
                top: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.9,
              ),
              Positioned(
                child: mainStream != null
                    ? Column(
                        children: <Widget>[
                          mainStream.isLocal == true
                              ? IconButton(
                                  icon: Icon(Icons.switch_camera,
                                      color: Colors.white),
                                  tooltip: "switch camera",
                                  onPressed: () {
                                    mainStream.switchDevice();
                                  },
                                )
                              : Container(),
                          // IconButton(
                          //   icon: shareScreenStream == null
                          //       ? Icon(Icons.screen_share, color: Colors.white)
                          //       : Icon(Icons.stop_screen_share,
                          //           color: Colors.white),
                          //   tooltip: shareScreenStream == null
                          //       ? 'start sharing screen'
                          //       : 'stop sharing screen',
                          //   onPressed: () {
                          //     if (shareScreenStream == null) {
                          //       startShareScreen(channel);
                          //     } else {
                          //       stopShareScreen();
                          //       setState(() {
                          //         shareScreenStream = null;
                          //       });
                          //     }
                          //   },
                          // ),
                          IconButton(
                            icon: mainStream.isAudioMuted
                                ? Icon(Icons.volume_off, color: Colors.white)
                                : Icon(Icons.volume_up, color: Colors.white),
                            tooltip: mainStream.isAudioMuted
                                ? 'unmute audio'
                                : 'mute audio',
                            onPressed: () {
                              if (mainStream.isAudioMuted) {
                                setState(() {
                                  mainStream.unmuteAudio();
                                });
                              } else {
                                setState(() {
                                  mainStream.muteAudio();
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: mainStream.isVideoMuted
                                ? Icon(Icons.videocam_off, color: Colors.white)
                                : Icon(Icons.videocam, color: Colors.white),
                            tooltip: mainStream.isVideoMuted
                                ? 'unmute video'
                                : 'mute video',
                            onPressed: () {

                            },
                          ),
                        ],
                      )
                    : Container(),
                left: 0,
                bottom: 0,
              ),
              Positioned(
                child: (mainStream != null && mediaStats != null)
                    ? ListView.builder(
                        itemCount: mediaStats.length,
                        itemBuilder: (BuildContext context, int index) {
                          var key = mediaStats.keys.elementAt(index);
                          var value = mediaStats[key];
                          return Text("$key: $value",
                              style: TextStyle(color: Colors.white));
                        })
                    : Container(),
                left: 0,
                top: 0,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: chatHeight,
                  width: double.infinity,
                  child: ChatPage(
                    groupId: widget.channel,
                    userName: widget.username,
                    groupName: widget.channel,),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 0,),
                      Column(
                        children: <Widget>[
                          Icon(Icons.mic, size: 30,),
                          Text("Mute")
                        ],
                      ),
                      GestureDetector(


                        child: Column(
                          children: <Widget>[
                           Icon(Icons.videocam, size: 30,),
                            Text("Video")
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.screen_share, size: 30, color: widget.screen == true ? Colors.green : Colors.black,),
                          Text("Share", style: TextStyle(color: widget.screen == true ? Colors.green : Colors.black),)
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          if(chatHeight == 0){
                            setState(() {
                              chatHeight = 350;
                            });
                          } else if(chatHeight == 350){
                            setState(() {
                              chatHeight = 0;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.voice_chat, size: 30,),
                            Text("Chat")
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(leaveOpacity == 0){
                            setState(() {
                              leaveOpacity = 1;
                            });
                          } else if(leaveOpacity == 1){
                            setState(() {
                              leaveOpacity = 0;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.cancel, size: 30, color: Colors.red,),
                            Text("Leave", style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ),
                      SizedBox(width: 0,),
                    ],
                  ),
                ),
              ),

              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: leaveOpacity,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.cancel, color: Colors.red,),
                        SizedBox(height: 20,),
                        Text("Are you sure you want to leave this meeting?" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                        SizedBox(height: 10,),
                        Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Spacer(),
                            SizedBox(width: 1,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red
                                  ),
                                  child: Text("Leave", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  leaveOpacity = 0;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                              ),
                            ),
                            SizedBox(width: 1,),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
        endDrawer: Drawer(
          child: Container(
              padding: EdgeInsets.only(top: 50),
              child: ListView.builder(
                  itemCount: remoteStreams.length,
                  itemBuilder: (BuildContext context, int index) {
                    var stream = remoteStreams[index];
                    return Container(
                        child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(stream.getId().toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: stream.isAudioMuted
                                    ? Icon(Icons.volume_off)
                                    : Icon(Icons.volume_up),
                                tooltip: stream.isAudioMuted
                                    ? 'unmute audio'
                                    : 'mute audio',
                                onPressed: () {
                                  if (stream.isAudioMuted) {
                                    setState(() {
                                      stream.unmuteAudio();
                                    });
                                  } else {
                                    setState(() {
                                      stream.muteAudio();
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: stream.isVideoMuted
                                    ? Icon(Icons.videocam_off)
                                    : Icon(Icons.videocam),
                                tooltip: stream.isVideoMuted
                                    ? 'unmute video'
                                    : 'mute video',
                                onPressed: () {
                                  print(stream.getId());
                                  if (stream.isVideoMuted) {
                                    setState(() {
                                      stream.unmuteVideo();
                                    });
                                  } else {
                                    setState(() {
                                      stream.muteVideo();
                                    });
                                  }
                                },
                              ),
                              FlatButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () async {
                                  if (stream.hasSubscribed) {
                                    await agoraClient.unsubscribe(stream);
                                    setState(() {
                                      allStreams.remove(stream);
                                    });
                                  } else {
                                    await agoraClient.subscribe(stream);
                                    if (stream.getId() == 1) {
                                      await stream.play(mode: "contain");
                                    } else {
                                      await stream.play();
                                    }
                                    setState(() {
                                      allStreams.add(stream);
                                    });
                                  }
                                },
                                child: Text(
                                  stream.hasSubscribed ? "unsub" : "sub",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
                  })),
        ));
  }
}
