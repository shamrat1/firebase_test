import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';

class FirestoreService {
  String collection;
  FirestoreService({required this.collection});

  Future<String?> addData(dynamic data) async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection(collection);
      var res = await myCollection.add(data);
      updateData(res.id, {"id": res.id});
      print("Data added successfully");
      return res.id;
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  Future<void> updateData(String documentId, dynamic data) async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection(collection);
      await myCollection.doc(documentId).update(data);
      print("Data updated successfully");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<ChatUser?> getUser(String phone) async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection(collection);
      var data =
          await myCollection.where('phone', isEqualTo: phone).limit(1).get();
      var doc = data.docs.first;
      var chatuser = ChatUser.fromMap(doc.data() as Map<String, dynamic>);
      print("Data updated successfully");
      return chatuser;
    } catch (e) {
      print("Error updating data: $e");
    }
  }
}
