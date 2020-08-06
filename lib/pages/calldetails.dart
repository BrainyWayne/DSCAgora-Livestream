import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallDetails extends StatefulWidget {
  String channelName, name, date;

  CallDetails({this.channelName, this.name, this.date});

  @override
  _CallDetailsState createState() => _CallDetailsState();
}

class _CallDetailsState extends State<CallDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/star0.jpg",
                            fit: BoxFit.cover,
                            height: 400,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )),
                    ],
                  ),
                ),
                Text(widget.channelName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
