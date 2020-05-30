import 'package:flutter/material.dart';

class rowDays extends StatefulWidget {
  @override
  _rowDaysState createState() => _rowDaysState();
}

class _rowDaysState extends State<rowDays> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                      child: Text("M"),
                    ),
                    CircleAvatar(
                      child: Text("T"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                    CircleAvatar(
                      child: Text("W"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                    CircleAvatar(
                      child: Text("T"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                    CircleAvatar(
                      child: Text("F"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                    CircleAvatar(
                      child: Text("S"),
                    ),
                    CircleAvatar(
                      child: Text("S"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                  ],
                ),
    );
  }
}