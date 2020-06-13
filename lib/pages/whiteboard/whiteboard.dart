import 'package:flutter/material.dart';
import 'package:whiteboardkit/whiteboard.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class WhiteBoard extends StatefulWidget {
  @override
  _WhiteBoardState createState() => _WhiteBoardState();
}

class _WhiteBoardState extends State<WhiteBoard> {
  DrawingController controller;
  bool isFullScreen = false;
  Icon fullscreenIcon = Icon(Icons.more_vert);
  double topBarSize = 100.0;

  @override
  void initState() {
    controller = new DrawingController();
    controller.onChange().listen((draw) {
      //do something with it
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Whiteboard",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        toggleFullscreen();
                      },
                      child: fullscreenIcon,
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Whiteboard(
                controller: controller,
                style: WhiteboardStyle(toolboxColor: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void toggleFullscreen() {
    if(isFullScreen){

    }
  }
}
