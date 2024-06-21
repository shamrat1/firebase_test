import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/services/firebase_chat_service.dart';

final usersProvider = FutureProvider<List<ChatUser>>((ref) =>
    FirebaseChat(firebaseFirestore: FirebaseFirestore.instance).users());
