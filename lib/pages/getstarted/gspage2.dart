import 'package:flutter/material.dart';

class GetStartedPageTwo extends StatefulWidget {
  @override
  _GetStartedPageTwoState createState() => _GetStartedPageTwoState();
}

class _GetStartedPageTwoState extends State<GetStartedPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 40, right: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    "assets/images/technology.png",
                    height: 50,
                    width: 50,
                  ),
                
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "eCollege \nLive Streaming",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
                SizedBox(height: 30,),
                Text(
                  "Set up a virtual meeting with coursemates on the go",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Positioned(
                bottom: 0,
                child: Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/studentsmeeting.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
