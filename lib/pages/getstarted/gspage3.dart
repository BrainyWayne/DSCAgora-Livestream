import 'package:flutter/material.dart';

class GetStartedPageThree extends StatefulWidget {
  @override
  _GetStartedPageThreeState createState() => _GetStartedPageThreeState();
}

class _GetStartedPageThreeState extends State<GetStartedPageThree> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/easyaccess.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 20),
            color: Colors.white.withOpacity(0.3),
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

          
        ],
      ),
    );
  }
}
