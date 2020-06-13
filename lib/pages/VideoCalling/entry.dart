import 'package:agora_flutter_webrtc_quickstart/pages/VideoCalling/videocallingpageview.dart';
import 'package:agora_flutter_webrtc_quickstart/theme.dart';
import 'package:agora_flutter_webrtc_quickstart/util/FavoritesModel.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  SharedPreferences sharedPreferences;
  FirebaseUser user;
  final db = Firestore.instance;

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              // height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Hero(
                      tag: "image0",
                      child: Image.asset(
                        "assets/images/meeting.png",
                        width: 100,
                        height: 100,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Video Meeting",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
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
                            hintText: 'Enter Channel Name'),
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

                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Configure temporary settings",
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
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

                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              onJoin();
                              saveHistory(_channelController.text);

                            },
                            child: ClayContainer(
                              customBorderRadius:
                              BorderRadius.circular(15),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Join or Create Channel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: ClayContainer(
                              customBorderRadius:
                              BorderRadius.circular(15),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add to Favorites",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
              builder: (context) => new VideoCallingPageView(
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

  saveHistory(String channel) async {
     sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('channel', channel);
  }

  addToFavorites(String channel) async {
    sharedPreferences = await SharedPreferences.getInstance();



  }


  Future < void > addFavorite(String channel) async {  
     user = await FirebaseAuth.instance.currentUser();
    final TransactionHandler createTransaction = (Transaction tx) async {
    final DocumentSnapshot ds = await tx.get(db.collection('users').document(user.uid).collection("favorites").document(user.uid));
 
    var dataMap = new Map<String, dynamic>();
    dataMap['channelname'] = '_channelname';
 
    await tx.set(ds.reference, dataMap);
 
    return dataMap;
  };
 
  return Firestore.instance.runTransaction(createTransaction).then((mapData) {
    return FavoritesModel.fromMap(mapData);
  }).catchError((error) {
    print('error: $error');
    return null;
  });
}



}
