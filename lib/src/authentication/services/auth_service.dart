import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/authentication/services/firestore_service.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    var value = await _auth.signInWithCredential(credential);
    // _auth.setPersistence(Persistence.LOCAL);
    // _auth.
    var firestoreService = FirestoreService(collection: "users");
    var token = await FirebaseMessaging.instance.getToken();

    if (value.additionalUserInfo?.isNewUser ?? false) {
      // create a new user
      firestoreService.addData(ChatUser(
        phone: value.user?.phoneNumber ?? "",
        pushToken: token,
      ).toJson());
    } else {
      // get current user from users collection
      var user = await firestoreService.getUser(value.user?.phoneNumber ?? "");
      firestoreService.updateData(user?.id ?? "", {"push_token": token});
    }

    
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
