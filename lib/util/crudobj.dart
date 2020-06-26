import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  FirebaseUser user;

  Future<void> addScheduleData(postData) async {
     user = await FirebaseAuth.instance.currentUser();
    if (isLoggedIn()) {
      Firestore.instance.collection('users').document(user.uid).collection("schedules").add(postData).catchError((e) {
         print(e);
       });
    } else {
      print('You need to be logged in');
    }
  }

  getScheduleData() async {
    return await  Firestore.instance.collection('users').document(user.uid).collection("schedules").getDocuments();
  }
}