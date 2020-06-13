import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'FavoritesModel.dart';
 
final CollectionReference favoritesModelCollection = Firestore.instance.collection('FavoritesModels');
 
class FirebaseFirestoreService {
 
  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();
 
  factory FirebaseFirestoreService() => _instance;
 
  FirebaseFirestoreService.internal();
 
  Future<FavoritesModel> createFavoritesModel(String title, String channelname) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(favoritesModelCollection.document());
 
      final FavoritesModel favoritesModel = new FavoritesModel(ds.documentID, channelname);
      final Map<String, dynamic> data = favoritesModel.toMap();
 
      await tx.set(ds.reference, data);
 
      return data;
    };
 
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return FavoritesModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }
 
  Stream<QuerySnapshot> getFavoritesModelList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = favoritesModelCollection.snapshots();
 
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
 
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
 
    return snapshots;
  }
 

 
  Future<dynamic> deleteFavoritesModel(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(favoritesModelCollection.document(id));
 
      await tx.delete(ds.reference);
      return {'deleted': true};
    };
 
    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}