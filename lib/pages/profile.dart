
import 'package:agora_flutter_webrtc_quickstart/services/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/clay_containers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username;
  String email;
  String photoUrl;
  String residence;
  String number;
  String occupation;
  String house;
  String yearGroup;
  String type;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Material(
        child: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[

           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Stack(
                 children: <Widget>[
                   Image.asset("assets/images/cross.png", fit: BoxFit.cover,),
                   Container(
                     width: double.infinity,
                     height: 300,
                     decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [Colors.white, Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.1)], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter)
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.only(top: 250),
                     width: double.infinity,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[

                         Container(

                           child: ClayContainer(

                             child: Container(
                               child: Row(
                                 children: <Widget>[
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(150),
                                     child: Container(
                                       width: 55,
                                       height: 55,
                                       child: CachedNetworkImage(imageUrl: photoUrl, fit: BoxFit.cover,),
                                     ),
                                   ),
                                   SizedBox(width: 10,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Text(username, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
                                       SizedBox(height: 5,),
                                       Text(type, style: TextStyle(color: Colors.black, fontSize: 15),),
                                     ],
                                   ),
                                 ],
                               ),
                               padding: EdgeInsets.all(10),
                             ),

                             curveType: CurveType.convex,
                             depth: 50,
                             color: Colors.white,
                             spread: 1,
                             

                             borderRadius: 50,
                           ),

                           margin: EdgeInsets.symmetric(horizontal: 20),
                           
                         ),


                         Container(
                           margin: EdgeInsets.only(left: 50),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[

                               Container(


                                 child: Row(

                                   children: <Widget>[

                         

                                   ],
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 ),
                                 margin: EdgeInsets.only(right: 50, top: 40),
                               ),
                               SizedBox(height: 40,),

                               Text(email, style: TextStyle(color: Colors.black, fontSize: 18),),
                               SizedBox(height: 10,),
                               Text(number, style: TextStyle(color: Colors.black, fontSize: 18),),
                               SizedBox(height: 40,),
                             
                              
                             ],
                           ),
                         ),
                         InkWell(
                           onTap: () {
                             Auth _auth = new Auth();
                             _auth.signOut().then((onValue) {
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (BuildContext context) => Login()));
                             });
                           },
                           child: Container(
                             margin: EdgeInsets.only(left: 40),
                             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                             decoration: BoxDecoration(
                                 color: Colors.green, borderRadius: BorderRadius.circular(20)),
                             child: Text("Logout",
                                 style: TextStyle(
                                     color: Colors.white, fontWeight: FontWeight.bold)),
                           ),
                         )
                       ],
                     ),
                   )
                 ],

               ),

             ],
           ),

             ],
           )





      ),
   );
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
    Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        print(datasnapshot.data['residence'].toString());
        var photolink;
        try {
          photolink = datasnapshot.data['photo'].toString();
        } catch (e) {
          photoUrl = "N/A";
        }

        setState(() {
          username = datasnapshot.data['name'].toString();
          email = datasnapshot.data['email'].toString();
          photoUrl = photolink;
          residence = datasnapshot.data['residence'].toString();
          occupation = datasnapshot.data['occupation'].toString();
          number = datasnapshot.data['phone'].toString();
          yearGroup = datasnapshot.data['yeargroup'].toString();
          house = datasnapshot.data['house'].toString();
          type = datasnapshot.data['type'].toString();
        });
      }
    });
  }
}
