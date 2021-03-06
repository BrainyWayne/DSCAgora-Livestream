

import 'dart:io';

import 'file:///D:/Mobile%20App%20Development/DSCAgora-Livestream/lib/pages/VideoCalling/entry.dart';
import 'package:agora_flutter_webrtc_quickstart/pages/homescreen.dart';
import 'package:agora_flutter_webrtc_quickstart/services/firebase_auth.dart';
import 'package:agora_flutter_webrtc_quickstart/shared/input_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/home.dart';





class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

FirebaseUser user;
File _image;
String _uploadedFileURL = "null";
double bottomLoaderHeight = 0;
var imageURL;

List<String> _signupType = ['Teacher', 'Student']; // Option 2
String _selectedSignType; // Option 2


  

class _SignupState extends State<Signup> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameontroller = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController schoolController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/radio.png", fit: BoxFit.cover,),
          ),

          Container(
            color: Colors.black.withOpacity(0.8),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      chooseFile();
                    },
                    child: Container(
                        padding: EdgeInsets.all(60),
                        child: _uploadedFileURL == "null"
                            ? CircleAvatar(
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                          radius: 60,
                          backgroundColor: Colors.green,
                        )
                            : Image.file(_image)),
                  ),
                  Text("Tap on icon to select profile image"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: usernameontroller,
                            decoration: InputDecoration(
                                hintText: "Full Name",
                                prefixIcon: Icon(Icons.account_circle),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: numberController,
                            decoration: InputDecoration(
                                hintText: "Number",
                                prefixIcon: Icon(Icons.phone),
                                border: InputBorder.none),
                          ),
                        ),

                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.keyboard),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: TextField(
                            controller: schoolController,
                            decoration: InputDecoration(
                                hintText: "School in Full",
                                prefixIcon: Icon(Icons.group),
                                border: InputBorder.none),
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child:DropdownButton(
                            hint: Text(
                                'Signup type'), // Not necessary for Option 1
                            value: _selectedSignType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSignType = newValue;
                              });
                            },
                            items: _signupType.map((signupType) {
                              return DropdownMenuItem(
                                child: new Text(signupType),
                                value: signupType,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        SizedBox(height: 15),

                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                bottomLoaderHeight = 70;
                              });
                              Auth _auth = new Auth();
                              _auth
                                  .signUp(
                                  emailController.text.toLowerCase().trim(),
                                  passwordController.text)
                                  .then((onValue) async {
                                user = await FirebaseAuth.instance.currentUser();
                                print(user.uid);

                                _auth.sendEmailVerification();

                                //await uploadFile();
                                //Uploading information to firestore
                                Firestore.instance
                                    .collection('users')
                                    .document(user.uid)
                                    .updateData({
                                  "userid": user.uid,
                                  "email": emailController.text,
                                  "name": usernameontroller.text,
                                  "phone": numberController.text,
                                  "school": schoolController.text,
                                  "type": _selectedSignType,
                                  "photo": "default",
                                })
                                    .then((result) => {

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (BuildContext context) =>
                                              HomeScreen()))
                                })
                                    .catchError((err) => print(err));
                              });
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: bottomLoaderHeight,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(15))),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Signing up...",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        _uploadedFileURL = image.toString();
      });
    });
  }

  Future uploadFile() async {
    user = await FirebaseAuth.instance.currentUser();
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child('users/' + user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('Uploaded');
    await storageReference.getDownloadURL().then((photoURL) {
      print("photoURL: " + photoURL);
      imageURL = photoURL;
      print("imageURL: " + imageURL);
      Firestore.instance.collection('users').document(user.uid).updateData({
        "photo": imageURL.toString(),
      });
    });
  }


  savePhotoUrl(String photourl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('photourl', photourl);
    setState(() {
      _uploadedFileURL = photourl;
    });
  }
}
