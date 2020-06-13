import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/call.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: PageView(
              children: <Widget>[
//                CallPage(
//                  appId: widget.appId,
//                  channel: widget.channel,
//                  video: widget.video,
//                  audio: widget.audio,
//                  screen: widget.screen,
//                  profile: widget.profile,
//                  width: '',
//                  height: '',
//                  framerate: '',
//                  codec: widget.codec,
//                  mode: widget.mode,
//                ),

              Container(
                color: Colors.red,
              )

              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 10,),
                  CircleAvatar(child: Icon(Icons.chat)),
                  CircleAvatar(child: Icon(Icons.view_headline)),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
