import 'package:agora_flutter_webrtc_quickstart/theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _widthController = TextEditingController(text: '0');
  final _heightController = TextEditingController(text: '0');
  final _frameRateController = TextEditingController(text: '0');

  bool _screen = false;
  String _profile = "480p";
  final String _appId = "e7699cd7f23042ad86c214aee299a477";

  String _codec = "h264";
  String _mode = "live";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _frameRateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                "Setting",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                  color: fadedBlack,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TextField(
                      controller: _widthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Width', labelText: "width"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Height', labelText: "height"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TextField(
                      controller: _frameRateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'FrameRate', labelText: "FrameRate"),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                RadioListTile(
                  title: Text("h264"),
                  value: "h264",
                  groupValue: _codec,
                  onChanged: (String value) {
                    setState(() {
                      _codec = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text("vp8"),
                  value: "vp8",
                  groupValue: _codec,
                  onChanged: (String value) {
                    setState(() {
                      _codec = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                RadioListTile(
                  title: Text("live"),
                  value: "live",
                  groupValue: _mode,
                  onChanged: (String value) {
                    setState(() {
                      _mode = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text("rtc"),
                  value: "rtc",
                  groupValue: _mode,
                  onChanged: (String value) {
                    setState(() {
                      _mode = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
