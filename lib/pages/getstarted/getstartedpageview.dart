import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/gspage1.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/gspage2.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/getstarted/gspage3.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPageView extends StatefulWidget {
  @override
  _GetStartedPageViewState createState() => _GetStartedPageViewState();
}

class _GetStartedPageViewState extends State<GetStartedPageView> {
  String nextText = "Next";
  String image = 'assets/images/vm.jpg';
  PageController _pageController = new PageController(initialPage: 0);
  int currentPage = 0;
  Color buttonColor = Colors.red;
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: "getstarted",
        child: Container(
          child: Stack(
            children: [
              PageView(
               // physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: <Widget>[
                  GetStartedPageOne(),
                  GetStartedPageTwo(),
                  GetStartedPageThree(),
                ],
              ),
              
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    
                    if(_pageController.page == 0){
                      _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                      setState(() {
                      buttonColor = Colors.orange;
                    });
                    } else if(_pageController.page == 1){
                      _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                      setState(() {
                      buttonColor = Colors.green;
                      nextText = "Proceed";
                    });
                    } else if(_pageController.page == 2){
                      getStartedStore();
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                    }
                  },
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      nextText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getStartedStore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("started", false);
  }
}
