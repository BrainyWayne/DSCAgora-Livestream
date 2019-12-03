import 'package:agora_flutter_webrtc_quickstart/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../theme.dart';
import 'entry.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      new PageController(viewportFraction: 0.5, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    var loggedin = false;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/index');
        },
        child: Icon(Icons.video_call),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.indigoAccent[100],
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: Icon(
                  Icons.settings,
                  color: fadedBlack,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: loggedin
                    ? Icon(
                        Icons.account_circle,
                        color: fadedBlack,
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/avatar.png',
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -40,
                top: -80,
                child: Container(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/dsclogo.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 120),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'DSC KNUST',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                color: fadedBlack),
                          ),
                          Text(
                            'Live Streaming',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 20,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                Colors.red,
                                Colors.red,
                                Colors.green,
                                Colors.blue,
                                Colors.blue
                              ])),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          height: 240,
                          width: double.infinity,
                          child: PageView(
                            controller: pageController,
                            children: <Widget>[
                              InkWell(
                                child: buildCard(
                                  title: "DSC Support",
                                  icon: Icons.help,
                                  cardColor: Colors.red[600],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, "/index",
                                      arguments: Constants.DSCSUPPORT);
                                },
                              ),
                              InkWell(
                                child: buildCard(
                                  title: "DSC Core Team",
                                  icon: Icons.group,
                                  cardColor: Colors.green[600],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, "/index",
                                      arguments: Constants.CORE_TEAM_CHANNEL);
                                },
                              ),
                              InkWell(
                                child: buildCard(
                                  title: "Agora Support",
                                  icon: Icons.headset_mic,
                                  cardColor: Colors.blue[600],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, "/index",
                                      arguments: Constants.AGORASUPPORT);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                      alignment: Alignment.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCard({
    String title,
    IconData icon,
    Color cardColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(color: cardColor),
          height: 200,
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(color: textWhite, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
