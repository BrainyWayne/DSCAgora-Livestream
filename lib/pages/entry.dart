import 'package:agora_flutter_webrtc_quickstart/theme.dart';
import 'package:flutter/material.dart';
import 'call.dart';
import 'package:agora_flutter_webrtc_quickstart/agoraappid.dart';

class IndexPage extends StatefulWidget {
  final String channelName;

  IndexPage({this.channelName});
  @override
  State<StatefulWidget> createState() {
    return new IndexState();
  }
}

class IndexState extends State<IndexPage> {
  TextEditingController _channelController;

  bool _validateError = false;
  bool _video = true;
  bool _audio = true;
  bool _screen = false;
  String _profile = "480p";
  final String _appId = AgoraAppId.id;

  String _codec = "h264";
  String _mode = "live";

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// set inital channel name
    _channelController = TextEditingController(text: widget.channelName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              // height: 400,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: fadedBlack,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settings'),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Join a Group",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                              color: fadedBlack
                              // fontFamily: "Georgia",
                              ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: _channelController,
                        decoration: InputDecoration(
                            errorText: _validateError
                                ? "Channel name is mandatory"
                                : null,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1)),
                            hintText: 'Channel name'),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "New one is created if group does not exist",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: greyText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: () => onJoin(),
                                child: Text("Join"),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            CheckboxListTile(
                                title: Text("video"),
                                value: _video,
                                activeColor: Theme.of(context).accentColor,
                                onChanged: (value) {
                                  setState(() {
                                    _video = value;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading),
                            CheckboxListTile(
                                title: Text("audio"),
                                value: _audio,
                                activeColor: Theme.of(context).accentColor,
                                onChanged: (value) {
                                  setState(() {
                                    _audio = value;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading),
                            CheckboxListTile(
                                title: Text("screen"),
                                value: _screen,
                                activeColor: Theme.of(context).accentColor,
                                onChanged: (value) {
                                  setState(() {
                                    _screen = value;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading)
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(children: <Widget>[
                        RadioListTile(
                          title: const Text('240p'),
                          value: "240p",
                          groupValue: _profile,
                          onChanged: (String value) {
                            setState(() {
                              _profile = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('360p'),
                          value: "360p",
                          groupValue: _profile,
                          onChanged: (String value) {
                            setState(() {
                              _profile = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('480p'),
                          value: "480p",
                          groupValue: _profile,
                          onChanged: (String value) {
                            setState(() {
                              _profile = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('720p'),
                          value: "720p",
                          groupValue: _profile,
                          onChanged: (String value) {
                            setState(() {
                              _profile = value;
                            });
                          },
                        ),
                      ])),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  onJoin() {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    if (_channelController.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new CallPage(
                    appId: _appId,
                    channel: _channelController.text,
                    video: _video,
                    audio: _audio,
                    screen: _screen,
                    profile: _profile,
                    width: '',
                    height: '',
                    framerate: '',
                    codec: _codec,
                    mode: _mode,
                  )));
    }
  }
}
